import 'package:nennos_pizza/domain/model/cart_item.dart';

class CartUi {
  final List<CartItem> cartItems;
  final num price;

  CartUi(this.cartItems, this.price);

  @override
  String toString() {
    return 'CartUi{cartItems: $cartItems, price: $price}';
  }
}