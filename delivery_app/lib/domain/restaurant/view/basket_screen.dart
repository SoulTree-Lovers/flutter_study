import 'package:delivery_app/common/const/colors.dart';
import 'package:delivery_app/common/layout/default_layout.dart';
import 'package:delivery_app/domain/product/component/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../user/provider/basket_provider.dart';

class BasketScreen extends ConsumerWidget {
  static String get routeName => '/basket';

  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);

    if (basket.isEmpty) {
      return DefaultLayout(
        title: '장바구니',
        child: Center(
          child: Text(
            '텅',
            style: TextStyle(
              fontSize: 50,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    final productsTotalPrice = basket.fold<int>(
      0,
      (prev, next) => prev + (next.productModel.price * next.count),
    );

    final deliveryFee = basket.first.productModel.restaurant.deliveryFee;

    return DefaultLayout(
      title: '장바구니',
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (_, __) => const Divider(
                    height: 32,
                    thickness: 0.5,
                  ),
                  itemCount: basket.length,
                  itemBuilder: (_, index) {
                    final model = basket[index];

                    return ProductCard.fromProductModel(
                      model: model.productModel,
                      onAdd: () {
                        ref
                            .read(basketProvider.notifier)
                            .addToBasket(productModel: model.productModel);
                      },
                      onSubtract: () {
                        ref
                            .read(basketProvider.notifier)
                            .removeFromBasket(productModel: model.productModel);
                      },
                    );
                  },
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '장바구니 금액 합계',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: BODY_TEXT_COLOR,
                        ),
                      ),
                      Text(
                        '$productsTotalPrice 원',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: BODY_TEXT_COLOR,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '배달비',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: BODY_TEXT_COLOR,
                        ),
                      ),
                      Text(
                        '$deliveryFee 원',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: BODY_TEXT_COLOR,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '총액',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${productsTotalPrice + deliveryFee} 원',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('주문하기'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PRIMARY_COLOR,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
