import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextColumnWidget extends StatelessWidget {
  final String name;
  final String price;

  const TextColumnWidget({Key key, this.name, this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        Text(price, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)
      ],
    );
  }

}