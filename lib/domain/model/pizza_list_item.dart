class PizzaItem {
  final String name;
  final String ingredients;
  final String price;
  final String imageUrl;

  PizzaItem(this.name, this.ingredients, this.price, this.imageUrl);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PizzaItem &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              ingredients == other.ingredients &&
              price == other.price &&
              imageUrl == other.imageUrl;

  @override
  int get hashCode =>
      name.hashCode ^
      ingredients.hashCode ^
      price.hashCode ^
      imageUrl.hashCode;
}