import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nennos_pizza/presentation/common/loading_widget.dart';
import 'package:nennos_pizza/presentation/common/pizza_image.dart';
import 'package:nennos_pizza/presentation/pizza_details/add_to_cart/add_to_cart_widget.dart';
import 'package:nennos_pizza/presentation/pizza_details/ingredient_checklist_widget.dart';
import 'package:nennos_pizza/presentation/pizza_details/ingredients_label_widget.dart';
import 'package:nennos_pizza/presentation/pizza_details/pizza_details_args.dart';
import 'package:nennos_pizza/presentation/pizza_details/pizza_details_bloc.dart';
import 'package:nennos_pizza/presentation/pizza_details/pizza_details_state.dart';

class PizzaDetailsWidget extends StatelessWidget {
  final PizzaDetailsArgs pizzaDetailsArgs;

  const PizzaDetailsWidget({Key key, this.pizzaDetailsArgs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(pizzaDetailsArgs.name),
        ),
        body: BlocBuilder<PizzaDetailsBloc, PizzaDetailsState>(
            buildWhen: (prev, next) {
          if (prev.isLoading && !next.isLoading) return true;
          return prev.imageUrl != next.imageUrl;
        }, builder: (context, state) {
          if (state.isLoading) return LoadingWidget();
          return Column(
            children: <Widget>[
              Expanded(
                child: buildContentList(state),
              ),
              AddToCartWidget()
            ],
          );
        }));
  }

  ListView buildContentList(PizzaDetailsState state) {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          if (index == 0) {
            return PizzaImageWidget(
              imageUrl: state.imageUrl,
            );
          } else if (index == 1) {
            return IngredientsLabelWidget();
          } else {
            return IngredientChecklistWidget();
          }
        });
  }
}
