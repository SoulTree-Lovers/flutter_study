class ShoppingItemModel {
  final String name; // 아이템 이름
  final int quantity; // 아이템 수량
  final bool hasBought; // 구매 여부
  final bool isSpicy; // 매운맛 여부

  ShoppingItemModel({
    required this.name,
    required this.quantity,
    required this.hasBought,
    required this.isSpicy,
  });

  ShoppingItemModel copyWith({
    String? name,
    int? quantity,
    bool? hasBought,
    bool? isSpicy,
  }) {
    return ShoppingItemModel(
      name: name?? this.name,
      quantity: quantity?? this.quantity,
      hasBought: hasBought?? this.hasBought,
      isSpicy: isSpicy?? this.isSpicy,
    );
  }
}