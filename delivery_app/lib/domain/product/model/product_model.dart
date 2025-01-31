import 'package:delivery_app/common/model/model_with_id.dart';
import 'package:delivery_app/domain/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../common/utils/data_utils.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel implements IModelWithId {
  final String id;
  final String name; // 상품명
  final String detail; // 상품 상세 설명
  @JsonKey(fromJson: DataUtils.pathToUrl)
  final String imgUrl; // 상품 이미지 URL
  final int price; // 상품 가격
  final RestaurantModel restaurant; // 상품을 등록한 음식점

  ProductModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
    required this.restaurant,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
}