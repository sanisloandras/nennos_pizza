import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nennos_pizza/presentation/pizza_details/add_to_cart/add_to_cart_bloc.dart';
import 'package:nennos_pizza/presentation/pizza_details/add_to_cart/add_to_cart_event.dart';
import 'package:nennos_pizza/presentation/pizza_details/add_to_cart/add_to_cart_state.dart';
import 'package:nennos_pizza/presentation/pizza_details/pizza_details_bloc.dart';

class AddToCartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddToCartBloc>(
      create: (context) {
        return AddToCartBloc(BlocProvider.of<PizzaDetailsBloc>(context),
            GetIt.instance.get(), BlocProvider.of(context));
      },
      child: BlocBuilder<AddToCartBloc, AddToCartState>(
        builder: (context, state) {
          var text;
          if (state.isEnabled) {
            text = buildText("Add to cart \$${state.price}");
          } else {
            text = buildText("Added to cart");
          }
          var children = <Widget>[];
          if (state.isEnabled) children.add(buildCartIcon());
          children.add(text);
          return GestureDetector(
            onTap: () =>
                BlocProvider.of<AddToCartBloc>(context).add(AddedToCart()),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              color: state.isEnabled ? Colors.amber : Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            ),
          );
        },
      ),
    );
  }

  Text buildText(String text) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18.0),
    );
  }

  Icon buildCartIcon() => Icon(
        Icons.shopping_cart,
        color: Colors.white,
      );
}
