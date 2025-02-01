import 'package:delivery_app/common/const/colors.dart';
import 'package:delivery_app/common/dio/dio.dart';
import 'package:delivery_app/common/layout/default_layout.dart';
import 'package:delivery_app/domain/product/model/product_model.dart';
import 'package:delivery_app/domain/rating/component/rating_card.dart';
import 'package:delivery_app/domain/restaurant/component/restaurant_card.dart';
import 'package:delivery_app/domain/restaurant/model/restaurant_detail_model.dart';
import 'package:delivery_app/domain/restaurant/provider/restaurant_provider.dart';
import 'package:delivery_app/domain/restaurant/repository/restaurant_repository.dart';
import 'package:delivery_app/domain/user/provider/basket_provider.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../common/const/data.dart';
import '../../../common/model/cursor_pagination_model.dart';
import '../../../common/utils/pagination_utils.dart';
import '../../product/component/product_card.dart';
import '../../rating/model/rating_model.dart';
import '../../user/model/basket_item_model.dart';
import '../model/restaurant_model.dart';
import '../provider/restaurant_rating_provider.dart';
import 'package:badges/badges.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'restaurantDetail';
  final String id;

  const RestaurantDetailScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
    scrollController.addListener(listener);
  }

  void listener() {
    PaginationUtils.paginate(
      scrollController: scrollController,
      paginationProvider: ref.read(
        restaurantRatingProvider(widget.id).notifier,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider(widget.id));
    final ratingsState = ref.watch(restaurantRatingProvider(
        widget.id)); // data: CursorPagination<ratingModel> 반환
    final basket = ref.watch(basketProvider);

    if (state == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return DefaultLayout(
      floatingActionButton: renderFloatingActionButton(basket: basket),
      title: state.name,
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          renderTop(
            item: state,
          ),
          if (state is RestaurantDetailModel) renderMenuLabel(),
          if (state is RestaurantDetailModel)
            renderProducts(
              products: state.products,
              restaurant: state,
            ),
          if (state is RestaurantDetailModel) renderReviewLabel(),
          if (ratingsState is CursorPagination<RatingModel>)
            renderRatings(
              models: ratingsState.data,
            ),
        ],
      ),
    );
  }

  FloatingActionButton renderFloatingActionButton({
    required List<BasketItemModel> basket,
  }) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: PRIMARY_COLOR,
      child: Badge(
        showBadge: basket.isNotEmpty,
        badgeContent: Text(
          "${basket.fold(0, (prev, next) => prev + next.count)}",
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontSize: 12,
          ),
        ),
        badgeStyle: BadgeStyle(
          badgeColor: Colors.white,
        ),
        child: Icon(Icons.shopping_basket_outlined),
      ),
    );
  }

  SliverPadding renderMenuLabel() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter renderTop({
    required RestaurantModel item,
  }) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: item,
        isDetail: true,
      ),
    );
  }

  SliverPadding renderProducts({
    required List<RestaurantProductModel> products,
    required RestaurantModel restaurant,
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final json = products[index];

            return InkWell(
              onTap: () {
                ref.read(basketProvider.notifier).addToBasket(
                      productModel: ProductModel(
                        id: json.id,
                        name: json.name,
                        detail: json.detail,
                        imgUrl: json.imgUrl,
                        price: json.price,
                        restaurant: restaurant,
                      ),
                    );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ProductCard.fromRestaurantProductModel(
                  json: json,
                ),
              ),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }

  SliverPadding renderReviewLabel() {
    return SliverPadding(
      padding: EdgeInsets.only(top: 32, left: 16, right: 16),
      sliver: SliverToBoxAdapter(
        child: Text(
          '리뷰',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  SliverPadding renderRatings({
    required List<RatingModel> models,
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) => Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: RatingCard.fromModel(model: models[index]),
          ),
          childCount: models.length,
        ),
      ),
    );
  }
}
