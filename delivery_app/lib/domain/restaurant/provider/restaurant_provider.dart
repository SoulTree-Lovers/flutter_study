import 'package:delivery_app/common/model/cursor_pagination_model.dart';
import 'package:delivery_app/common/model/pagination_params.dart';
import 'package:delivery_app/common/provider/pagination_provider.dart';
import 'package:delivery_app/domain/restaurant/model/restaurant_model.dart';
import 'package:delivery_app/domain/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

final restaurantDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((element) => element.id == id); // id가 존재하지 않으면 null 반환
});

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);
    final notifier = RestaurantStateNotifier(repository: repository);

    return notifier;
  },
);

class RestaurantStateNotifier
    extends PaginationProvider<RestaurantModel, RestaurantRepository> {
  RestaurantStateNotifier({
    required super.repository,
  });

  void getDetail({
    required String id,
  }) async {
    // 만약 아직 데이터가 하나도 없는 상태라면 (CursorPagination이 아니라면)
    // 데이터를 가져오는 시도를 한다.
    if (state is! CursorPagination) {
      await paginate();
    }

    // state가 CursorPagination이 아니라면 그냥 리턴
    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;

    final response = await repository.getRestaurantDetail(
      id: id,
    );

    // [RestaurantModel(1), RestaurantModel(2), RestaurantModel(3)] 였을 때,
    // id = 10인 detail을 가져올 때 에러 발생
    // 데이터가 없을 때 그냥 캐시의 끝에 데이터를 추가해버린다.
    // [RestaurantModel(1), RestaurantModel(2), RestaurantModel(3), RestaurantDetailModel(10)] 으로 바뀜
    if (pState.data.where((e) => e.id == id).isEmpty) {
      state = pState.copyWith(
        data: <RestaurantModel> [...pState.data, response],
      );
    } else {
      // [RestaurantModel(1), RestaurantModel(2), RestaurantModel(3)] 였을 때,
      // id = 2 인 detail을 가져왔다고 가정
      // getDetail(2)
      // [RestaurantModel(1), RestaurantDetailModel(2), RestaurantModel(3)] 로 바뀜
      state = pState.copyWith(
          data: pState.data
              .map<RestaurantModel>((e) => e.id == id ? response : e)
              .toList());
    }
  }
}
