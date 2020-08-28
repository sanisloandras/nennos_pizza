import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IngredientsLabelWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Text("Ingredients", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)
    );
  }
}