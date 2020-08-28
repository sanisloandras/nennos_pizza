class CartItem {
  final String id;
  final String name;
  final String price;

  CartItem(this.id, this.name, this.price);

  @override
  String toString() {
    return 'CartItem{id: $id, name: $name, price: $price}';
  }
}