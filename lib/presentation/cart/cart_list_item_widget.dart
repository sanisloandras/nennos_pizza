import 'package:flutter/material.dart';
import 'package:nennos_pizza/domain/model/cart_item.dart';
import 'package:nennos_pizza/presentation/common/text_column_widget.dart';

class CartListItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final Function(CartItem) onRemove;

  const CartListItemWidget({Key key, this.cartItem, this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextColumnWidget(
            name: cartItem.name,
            price: cartItem.price,
          ),
          buildRemoveButton()
        ],
      ),
    );
  }

  IconButton buildRemoveButton() {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        onRemove(cartItem);
      },
    );
  }
}
