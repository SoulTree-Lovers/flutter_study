import 'package:delivery_app/domain/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../common/utils/data_utils.dart';
part 'restaurant_detail_model.g.dart';

@JsonSerializable()
class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<RestaurantProductModel> products;

  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });

  /*factory RestaurantDetailModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return RestaurantDetailModel(
      id: json['id'],
      name: json['name'],
      thumbUrl: json['thumbUrl'],
      tags: List<String>.from(json['tags']),
      priceRange: RestaurantPriceRange.values.firstWhere(
        (e) => e.name == json['priceRange'],
      ),
      ratings: json['ratings'],
      ratingsCount: json['ratingsCount'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
      detail: json['detail'],
      products: json['products'].map<RestaurantProductModel>(
        (productModel) => RestaurantProductModel.fromJson(
          json: productModel,
        ),
      ).toList(),
    );
  }*/

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantDetailModelToJson(this);
}

@JsonSerializable()
class RestaurantProductModel {
  final String id;
  final String name;
  @JsonKey(fromJson: DataUtils.pathToUrl)
  final String imgUrl;
  final String detail;
  final int price;

  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });

/*  factory RestaurantProductModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return RestaurantProductModel(
      id: json['id'],
      name: json['name'],
      imgUrl: 'http://$ip/${json['imgUrl']}',
      detail: json['detail'],
      price: json['price'],
    );
  }*/

  factory RestaurantProductModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantProductModelToJson(this);
}
