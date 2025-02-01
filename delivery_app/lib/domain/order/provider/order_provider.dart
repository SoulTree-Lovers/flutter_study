import 'package:delivery_app/common/model/cursor_pagination_model.dart';
import 'package:delivery_app/common/provider/pagination_provider.dart';
import 'package:delivery_app/domain/order/model/order_model.dart';
import 'package:delivery_app/domain/order/model/post_order_body.dart';
import 'package:delivery_app/domain/order/repository/order_repository.dart';
import 'package:delivery_app/domain/user/provider/basket_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final orderProvider = StateNotifierProvider<OrderStateNotifier, CursorPaginationBase>(
  (ref) {
    final orderRepository = ref.watch(orderRepositoryProvider);
    return OrderStateNotifier(
      ref: ref,
      repository: orderRepository,
    );
  },
);

class OrderStateNotifier extends PaginationProvider<OrderModel, OrderRepository> {
  final Ref ref;

  OrderStateNotifier({
    required this.ref,
    required super.repository,
  });

  Future<bool> postOrder() async {
    try {
      final basket = ref.read(basketProvider);

      final uuid = Uuid();
      final id = uuid.v4();

      final response = await repository.postOrder(
        body: PostOrderBody(
          id: id,
          products: basket
              .map(
                (e) => PostOrderBodyProduct(
                  productId: e.productModel.id,
                  count: e.count,
                ),
              )
              .toList(),
          totalPrice: basket.fold<int>(
            0,
            (prev, next) => prev + (next.productModel.price * next.count),
          ),
          createdAt: DateTime.now().toString(),
        ),
      );

      return true; // 주문 성공
    } catch (e) {
      return false; // 주문 실패
    }
  }
}
