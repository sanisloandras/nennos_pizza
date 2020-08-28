import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nennos_pizza/domain/model/ingredient.dart';
import 'package:nennos_pizza/presentation/common/text_column_widget.dart';

class IngredientCheckableWidget extends StatelessWidget {
  final Ingredient ingredient;
  final Function(int, bool) onChanged;

  const IngredientCheckableWidget({Key key, this.ingredient, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextColumnWidget(name: ingredient.name, price: ingredient.price,),
          Checkbox(
            value: ingredient.isChecked,
            activeColor: Colors.red,
            onChanged: (isChecked) {
              this.onChanged(ingredient.id, isChecked);
            }
          )
        ],
      ),
    );
  }

}