import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PriceWidget extends StatelessWidget {
  final String price;

  const PriceWidget({Key key, this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.all(Radius.circular(4.0))
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.shopping_cart, color: Colors.white,),
          Text(price, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
        ],
      )
    );
  }

}