import 'package:delivery_app/domain/user/model/basket_item_model.dart';
import 'package:delivery_app/domain/user/model/patch_basket_body.dart';
import 'package:delivery_app/domain/user/repository/user_me_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../product/model/product_model.dart';
import 'package:collection/collection.dart';

final basketProvider =
    StateNotifierProvider<BasketProvider, List<BasketItemModel>>((ref) {
  final userMeRepository = ref.watch(userMeRepositoryProvider);
  return BasketProvider(
    userMeRepository: userMeRepository,
  );
});

class BasketProvider extends StateNotifier<List<BasketItemModel>> {
  final UserMeRepository userMeRepository;

  BasketProvider({
    required this.userMeRepository,
  }) : super([]);

  Future<void> patchBasket() async {
    await userMeRepository.patchBasket(
      body: PatchBasketBody(
        basket: state
            .map(
              (e) => PatchBasketBodyBasket(
                productId: e.productModel.id,
                count: e.count,
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> addToBasket({
    required ProductModel productModel,
  }) async {
    // 1) 아직 장바구니에 해당되는 상품이 없다면 새로운 상품을 추가한다.
    // 2) 이미 장바구니에 해당되는 상품이 있다면 해당 상품의 개수를 1 증가시킨다.

    final exists = state.firstWhereOrNull(
            (item) => item.productModel.id == productModel.id) !=
        null;

    if (!exists) {
      // 1)
      state = [
        ...state,
        BasketItemModel(
          productModel: productModel,
          count: 1,
        ),
      ];
    } else {
      // 2)
      state = state
          .map((item) => item.productModel.id == productModel.id
              ? item.copyWith(count: item.count + 1)
              : item)
          .toList();
    }

    // Optimistic Response (긍정적 응답)
    // 요청 응답이 성공할거라 가정하고 위에서 장바구니 상태를 먼저 업데이트한 뒤, 서버에 요청을 보낸다.
    await patchBasket();
  }

  Future<void> removeFromBasket({
    required ProductModel productModel,
    bool isDelete = false, // true라면 개수와 관계없이 해당 상품을 장바구니에서 제거한다.
  }) async {
    // 1) 상품이 장바구니에 없다면 아무것도 하지 않는다.
    // 2) 장바구니에 해당되는 상품의 개수가 1이라면 장바구니에서 제거한다.
    // 3) 장바구니에 해당되는 상품의 개수가 1보다 크다면 해당 상품의 개수를 1 감소시킨다.

    final exists = state.firstWhereOrNull(
            (item) => item.productModel.id == productModel.id) !=
        null;

    if (!exists) {
      // 1)
      return;
    }

    final existingProduct = state.firstWhere(((item) =>
        item.productModel.id == productModel.id)); // 장바구니에 해당되는 상품을 가져온다.

    if (existingProduct.count == 1 || isDelete) {
      // 2)
      state = state
          .where((item) => item.productModel.id != productModel.id)
          .toList(); // 해당 상품을 장바구니에서 제거한다.
    } else {
      // 3)
      state = state
          .map((item) => item.productModel.id == productModel.id
              ? item.copyWith(count: item.count - 1)
              : item)
          .toList(); // 해당 상품의 개수를 1 감소시킨다.
    }

    // Optimistic Response (긍정적 응답)
    // 요청 응답이 성공할거라 가정하고 위에서 장바구니 상태를 먼저 업데이트한 뒤, 서버에 요청을 보낸다.
    await patchBasket();
  }
}
