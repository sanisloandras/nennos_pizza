import 'package:flutter/cupertino.dart';
import 'package:nennos_pizza/domain/model/cart_item.dart';
import 'cart_list_item_widget.dart';

class CartListWidget extends StatelessWidget {
  final List<CartItem> cartItems;
  final Function(CartItem) onRemove;

  const CartListWidget(this.cartItems, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return CartListItemWidget(
            cartItem: cartItems[index],
            onRemove: onRemove,
          );
        });
  }

}