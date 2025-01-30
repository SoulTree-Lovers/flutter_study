import 'package:delivery_app/common/model/cursor_pagination_model.dart';
import 'package:delivery_app/common/model/model_with_id.dart';
import 'package:delivery_app/common/repository/base_pagination_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/pagination_params.dart';

class PaginationProvider<T extends IModelWithId, U extends IBasePaginationRepository<T>> extends StateNotifier<CursorPaginationBase> {
  final U repository;

  PaginationProvider({
    required this.repository,
  }) : super(CursorPaginationLoading()) {
    paginate();
  }

  Future<void> paginate({
    int fetchCount = 20,
    bool fetchMore = false, // true: fetch more, false: refresh(현재 상태 덮어쓰기)
    bool forceRefetch = false, // true: CursorPaginationLoading
  }) async {
    try {
      // 5가지 경우의 수
      // 1. CursorPagination: 정상적으로 데이터를 가져온 경우

      // 2. CursorPaginationLoading: 데이터가 로딩 중인 상태 (현재 캐시 없음)
      // 3. CursorPaginationError: 에러가 있는 상태
      // 4. CursorPaginationRefetching: 첫 번째 페이지부터 다시 데이터를 가져올 때
      // 5. CursorPaginationFetchingMore: 추가 데이터를 paginate 하라는 요청을 받았을 때

      // 바로 반환하는 상황
      // 1) hasMore가 false일 때 (기존 상태에서 이미 다음 데이터가 없다는 값을 들고 있다면)
      if (state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination;

        if (!pState.meta.hasMore) {
          return;
        }
      }

      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      // 2) fetchMore가 true이고 현재 로딩 중일 때
      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      // PaginationParams를 생성
      PaginationParams paginationParams = PaginationParams(
        count: fetchCount,
      );

      // fetchMore
      // 데이터를 추가로 더 가져오는 상황
      if (fetchMore) {
        final pState = state as CursorPagination<T>;

        state = CursorPaginationFetchingMore(
          meta: pState.meta,
          data: pState.data,
        );

        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );
      } else {
        // 데이터를 처음부터 다시 가져오는 상황
        // 만약 데이터가 있는 상태라면, 기존 데이터를 보존한 채로 Fetch (API 요청) 진행
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination<T>;

          state = CursorPaginationRefetching<T>(
            meta: pState.meta,
            data: pState.data,
          );
        } else {
          // 처음부터 데이터를 가져오는 상황
          state = CursorPaginationLoading();
        }
      }

      final response = await repository.paginate(
        paginationParams: paginationParams,
      );

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore;

        // 기존 데이터에 추가로 가져온 데이터를 더해줌
        state = response.copyWith(
          data: [...pState.data, ...response.data],
        );
      } else {
        state = response;
      }
    } catch (e, stack) {
      print(e);
      print(stack);
      state = CursorPaginationError(message: '데이터를 불러오는 중 에러가 발생했습니다.');
    }
  }
}
