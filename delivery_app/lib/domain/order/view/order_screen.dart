import 'package:delivery_app/common/component/pagination_list_view.dart';
import 'package:delivery_app/domain/order/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../component/order_card.dart';
import '../model/order_model.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaginationListView<OrderModel>(
      provider: orderProvider,
      itemBuilder: <OrderModel>(context, index, model) {
        return OrderCard.fromModel(
          model: model,
        );
      },
    );
  }
}
