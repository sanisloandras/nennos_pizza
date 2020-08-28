import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nennos_pizza/domain/model/pizza_list_item.dart';
import 'package:nennos_pizza/presentation/common/pizza_image.dart';

import 'price_widget.dart';

class PizzaListItemWidget extends StatelessWidget {
  final PizzaItem pizzaListItem;
  final Function onTap;

  const PizzaListItemWidget({Key key, this.pizzaListItem, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: content(),
      onTap: this.onTap,
    );
  }

  Widget content() {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          PizzaImageWidget(imageUrl: pizzaListItem.imageUrl),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: footer(),
          )
        ],
      ),
    );
  }

  Widget footer() {
    return Container(
      color: Colors.grey[900].withOpacity(0.5),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            title(),
            ingredients(),
            SizedBox(height: 8,),
            PriceWidget(price: pizzaListItem.price)
          ],
        ),
      ),
    );
  }

  Text ingredients() {
    return Text(pizzaListItem.ingredients,
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis
          );
  }

  Text title() {
    return Text(pizzaListItem.name,
              style: TextStyle(color: Colors.white, fontSize: 18, ),
              overflow: TextOverflow.ellipsis
          );
  }
}