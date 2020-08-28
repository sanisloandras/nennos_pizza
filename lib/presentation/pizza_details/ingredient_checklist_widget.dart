import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nennos_pizza/presentation/pizza_details/ingredient_checkable_widget.dart';
import 'package:nennos_pizza/presentation/pizza_details/pizza_details_bloc.dart';
import 'package:nennos_pizza/presentation/pizza_details/pizza_details_event.dart';
import 'package:nennos_pizza/presentation/pizza_details/pizza_details_state.dart';

class IngredientChecklistWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var onIngredientChecked = (id, isChecked) {
      BlocProvider.of<PizzaDetailsBloc>(context)
          .add(IngredientChecked(id, isChecked));
    };
    return BlocBuilder<PizzaDetailsBloc, PizzaDetailsState>(
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: state.ingredients.length,
            itemBuilder: (context, index) {
              return IngredientCheckableWidget(
                ingredient: state.ingredients[index],
                onChanged: onIngredientChecked,
              );
            });
      },
    );
  }
}