import 'package:flutter/material.dart';
import 'package:nennos_pizza/domain/model/drink_item.dart';
import 'package:nennos_pizza/presentation/common/text_column_widget.dart';

class DrinkListItemWidget extends StatelessWidget {
  final DrinkItem drinkItem;
  final Function(DrinkItem) onAdd;

  const DrinkListItemWidget({Key key, this.drinkItem, this.onAdd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextColumnWidget(
            name: drinkItem.name,
            price: drinkItem.price,
          ),
          buildAddButton()
        ],
      ),
    );
  }

  IconButton buildAddButton() {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: () => onAdd(drinkItem),
    );
  }
}
