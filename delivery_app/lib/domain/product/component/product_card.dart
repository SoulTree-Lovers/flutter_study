import 'package:delivery_app/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/const/data.dart';
import '../../restaurant/model/restaurant_detail_model.dart';
import '../../user/provider/basket_provider.dart';
import '../model/product_model.dart';

class ProductCard extends ConsumerWidget {
  final String id;
  final Image image;
  final String name;
  final String detail;
  final int price;
  final VoidCallback? onSubtract;
  final VoidCallback? onAdd;

  const ProductCard({
    super.key,
    required this.id,
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
    this.onSubtract,
    this.onAdd,
  });

  factory ProductCard.fromProductModel({
    required ProductModel model,
    VoidCallback? onSubtract,
    VoidCallback? onAdd,
  }) {
    return ProductCard(
      id: model.id,
      image: Image.network(
        model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
      onSubtract: onSubtract,
      onAdd: onAdd,
    );
  }

  factory ProductCard.fromRestaurantProductModel({
    required RestaurantProductModel json,
    VoidCallback? onSubtract,
    VoidCallback? onAdd,
  }) {
    return ProductCard(
      id: json.id,
      image: Image.network(
        json.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      name: json.name,
      detail: json.detail,
      price: json.price,
      onSubtract: onSubtract,
      onAdd: onAdd,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);

    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: image,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      detail,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: BODY_TEXT_COLOR,
                      ),
                    ),
                    Text(
                      price.toString(),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: PRIMARY_COLOR,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (onSubtract != null && onAdd != null)
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: _Footer(
            total: (basket.firstWhere((e) => e.productModel.id == id).count * basket.firstWhere((e) => e.productModel.id == id).productModel.price).toString(),
            count: basket.firstWhere((e) => e.productModel.id == id).count,
            onSubtract: onSubtract!,
            onAdd: onAdd!,
          ),
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  final String total;
  final int count;
  final VoidCallback onSubtract;
  final VoidCallback onAdd;

  const _Footer({
    super.key,
    required this.total,
    required this.count,
    required this.onSubtract,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '총액: $total',
            style: TextStyle(
              color: PRIMARY_COLOR,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          children: [
            renderButton(
              icon: Icons.remove,
              onTap: onSubtract,
            ),
            SizedBox(width: 8),
            Text(
              count.toString(),
              style: TextStyle(
                color: PRIMARY_COLOR,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8),
            renderButton(
              icon: Icons.add,
              onTap: onAdd,
            ),
          ],
        ),
      ],
    );
  }

  Widget renderButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: PRIMARY_COLOR,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          color: PRIMARY_COLOR,
        ),
      ),
    );
  }
}
