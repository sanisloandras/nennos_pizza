class AddToCartState {
  final bool isEnabled;
  final num price;

  AddToCartState({this.isEnabled, this.price});

  AddToCartState copyWith({
    bool isEnabled,
    num price
  }) {
    return AddToCartState(
        isEnabled: isEnabled ?? this.isEnabled,
        price: price ?? this.price
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AddToCartState &&
              runtimeType == other.runtimeType &&
              isEnabled == other.isEnabled &&
              price == other.price;

  @override
  int get hashCode =>
      isEnabled.hashCode ^
      price.hashCode;
}