import 'package:delivery_app/common/const/colors.dart';
import 'package:flutter/material.dart';

import '../model/order_model.dart';

class OrderCard extends StatelessWidget {
  final DateTime orderDate;
  final Image image;
  final String name;
  final String productsDetail;
  final int price;

  const OrderCard({
    super.key,
    required this.orderDate,
    required this.image,
    required this.name,
    required this.productsDetail,
    required this.price,
  });

  factory OrderCard.fromModel({
    required OrderModel model,
  }) {
    // 주문한 상품 개수가 1개인 경우: 상품명 그대로 표시
    // 주문한 상품 개수가 1개 초과인 경우: 상품명 외 n-1개 표시
    final productsDetail = model.products.length < 2
        ? model.products.first.product.name
        : '${model.products.first.product.name} 외 ${model.products.length - 1}개';

    return OrderCard(
      orderDate: model.createdAt,
      image: Image.network(
        model.restaurant.thumbUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      name: model.restaurant.name,
      productsDetail: productsDetail,
      price: model.totalPrice,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 2025.01.01
        Text(
          '${orderDate.year}.${orderDate.month.toString().padLeft(2, '0')}.${orderDate.day.toString().padLeft(2, '0')} 주문완료',
        ),
        SizedBox(height: 8),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: image,
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  '$productsDetail $price원',
                  style: TextStyle(
                    color: BODY_TEXT_COLOR,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
