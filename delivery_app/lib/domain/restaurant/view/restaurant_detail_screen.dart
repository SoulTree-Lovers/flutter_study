import 'package:delivery_app/common/dio/dio.dart';
import 'package:delivery_app/common/layout/default_layout.dart';
import 'package:delivery_app/domain/rating/component/rating_card.dart';
import 'package:delivery_app/domain/restaurant/component/restaurant_card.dart';
import 'package:delivery_app/domain/restaurant/model/restaurant_detail_model.dart';
import 'package:delivery_app/domain/restaurant/provider/restaurant_provider.dart';
import 'package:delivery_app/domain/restaurant/repository/restaurant_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../common/const/data.dart';
import '../../product/component/product_card.dart';
import '../model/restaurant_model.dart';
import '../provider/restaurant_rating_provider.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider(widget.id));
    final ratingsState = ref.watch(restaurantRatingProvider(widget.id));

    print('ratingsState: $ratingsState');

    if (state == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return DefaultLayout(
      title: state.name,
      child: CustomScrollView(
        slivers: [
          renderTop(
            item: state,
          ),
          if (state is RestaurantDetailModel) renderMenuLabel(),
          if (state is RestaurantDetailModel)
            renderProducts(
              products: state.products,
            ),
          if (state is RestaurantDetailModel) renderReviewLabel(),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: RatingCard(
                profileImage: AssetImage(
                  'asset/img/logo/codefactory_logo.png',
                ),
                images: [],
                rating: 4,
                email: 'test@codefactory.ai',
                content: '맛있어요!',
              ),
            ),
          )
        ],
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
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final json = products[index];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ProductCard.fromModel(
                json: json,
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
}
