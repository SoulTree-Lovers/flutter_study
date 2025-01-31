import 'package:delivery_app/common/const/colors.dart';
import 'package:flutter/material.dart';

import '../../../common/const/data.dart';
import '../../restaurant/model/restaurant_detail_model.dart';
import '../model/product_model.dart';

class ProductCard extends StatelessWidget {
  final Image image;
  final String name;
  final String detail;
  final int price;

  const ProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
  });

  factory ProductCard.fromProductModel({
    required ProductModel model,
  }){
    return ProductCard(
      image: Image.network(
        model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
    );
  }


  factory ProductCard.fromRestaurantProductModel({
    required RestaurantProductModel json,
  }) {
    return ProductCard(
      image: Image.network(
        json.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      name: json.name,
      detail: json.detail,
      price: json.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
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
    );
  }
}
