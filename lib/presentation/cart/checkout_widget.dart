import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckoutWidget extends StatelessWidget {
  final String text;

  const CheckoutWidget({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(12.0),
        width: double.infinity,
        color: Colors.red,
        child: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
            )
        )
    );
  }

}