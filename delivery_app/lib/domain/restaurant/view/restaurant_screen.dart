import 'package:delivery_app/common/const/data.dart';
import 'package:delivery_app/common/model/cursor_pagination_model.dart';
import 'package:delivery_app/common/utils/pagination_utils.dart';
import 'package:delivery_app/domain/restaurant/component/restaurant_card.dart';
import 'package:delivery_app/domain/restaurant/provider/restaurant_provider.dart';
import 'package:delivery_app/domain/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/dio/dio.dart';
import '../model/restaurant_model.dart';
import '../repository/restaurant_repository.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController.addListener(scrollListner);
  }

  void scrollListner() {
    PaginationUtils.paginate(
      scrollController: scrollController,
      paginationProvider: ref.read(
        restaurantProvider.notifier,
      ),
    );
    // 현재 위치가 최대 길이보다 조금 덜 되는 위치까지 왔다면 새로운 데이터를 추가 요청
    // if (scrollController.offset >
    //     scrollController.position.maxScrollExtent - 300) {
    //   // maxScrollExtent: 스크롤 가능한 최대 길이
    //   ref.read(restaurantProvider.notifier).paginate(fetchMore: true);
    // }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(restaurantProvider);

    // 1. 맨 처음 로딩
    if (data is CursorPaginationLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 2. 에러 발생
    if (data is CursorPaginationError) {
      return Center(
        child: Text(data.message),
      );
    }

    final cp = data as CursorPagination; // 임시

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        controller: scrollController,
        itemCount: cp.data.length + 1,
        itemBuilder: (_, index) {
          if (index == cp.data.length) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Center(
                child: data is CursorPaginationFetchingMore
                    ? CircularProgressIndicator()
                    : Text('마지막 데이터입니다 ㅠㅠ'),
              ),
            );
          }

          final item = cp.data[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RestaurantDetailScreen(
                    id: item.id,
                  ),
                ),
              );
            },
            child: RestaurantCard.fromModel(model: item),
          );
        },
        separatorBuilder: (_, index) {
          return SizedBox(height: 16);
        },
      ),
    );
  }
}
