import 'package:delivery_app/common/dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../common/const/data.dart';
import '../../../common/model/cursor_pagination_model.dart';
import '../../../common/model/pagination_params.dart';
import '../../../common/repository/base_pagination_repository.dart';
import '../../rating/model/rating_model.dart';
import '../model/restaurant_model.dart';

part 'restaurant_rating_repository.g.dart';

final restaurantRatingRepositoryProvider = Provider.family<RestaurantRatingRepository, String>(
  (ref, id) {
    final dio = ref.watch(dioProvider);

    final repository = RestaurantRatingRepository(dio, baseUrl: 'http://$ip/restaurant/$id/rating');

    return repository;
  },
);

// http://ip/restaurant/:rid/rating
@RestApi()
abstract class RestaurantRatingRepository implements IBasePaginationRepository<RatingModel> {
  factory RestaurantRatingRepository(Dio dio, {String baseUrl}) =
      _RestaurantRatingRepository;

  // GET http://$ip/restaurant/
  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  @override
  Future<CursorPagination<RatingModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
