import 'package:delivery_app/common/model/cursor_pagination_model.dart';
import 'package:delivery_app/domain/restaurant/model/restaurant_detail_model.dart';
import 'package:delivery_app/domain/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  // baseUrl: http://$ip/restaurant (공통 URL)

  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // GET http://$ip/restaurant/
  @GET('/')
  @Headers({
    'accessToken' : 'true',
  })
  Future<CursorPagination<RestaurantModel>> paginate();

  // GET http://$ip/restaurant/{id}
  @GET('/{id}')
  @Headers({
   'accessToken' : 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
