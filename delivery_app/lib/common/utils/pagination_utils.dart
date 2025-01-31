import 'package:delivery_app/common/provider/pagination_provider.dart';
import 'package:flutter/material.dart';

class PaginationUtils {
  static void paginate({
    required ScrollController scrollController,
    required PaginationProvider paginationProvider,
  }) {
    // 현재 위치가 최대 길이보다 조금 덜 되는 위치까지 왔다면 새로운 데이터를 추가 요청
    if (scrollController.offset >
        scrollController.position.maxScrollExtent - 300) {
      // maxScrollExtent: 스크롤 가능한 최대 길이
      paginationProvider.paginate(fetchMore: true);
    }
  }
}
