import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_manage_by_riverpod/model/shopping_item_model.dart';
import 'package:state_manage_by_riverpod/riverpod/state_notifier_provider.dart';

final filteredShoppingListProvider = Provider<List<ShoppingItemModel>>(
  (ref) {
    final filterState = ref.watch(filterProvider);
    final shoppingListState = ref.watch(shoppingListProvider);

    // FilterState가 all인 경우에는 모든 상태를 반환하고
    if (filterState == FilterState.all) {
      return shoppingListState;
    }

    // FilterState가 spicy인 경우에는 isSpicy가 true인 상태를 반환하고 그렇지 않은 경우에는 isSpicy가 false인 상태를 반환합니다.
    return shoppingListState
        .where((e) => filterState == FilterState.spicy ? e.isSpicy : !e.isSpicy)
        .toList();
  },
);

enum FilterState {
  notSpicy,
  spicy,
  all,
}

final filterProvider = StateProvider<FilterState>((ref) => FilterState.all);
