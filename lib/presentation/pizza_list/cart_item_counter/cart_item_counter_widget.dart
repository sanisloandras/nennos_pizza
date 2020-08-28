import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nennos_pizza/presentation/pizza_list/cart_item_counter/cart_item_counter_bloc.dart';
import 'package:nennos_pizza/presentation/pizza_list/cart_item_counter/cart_item_counter_state.dart';

//todo test text size/length?
//todo ripple effect
class CartItemCounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed("/cart"),
      child: Container(
        margin: EdgeInsets.only(right: 8),
        child: Row(
          children: <Widget>[
            buildCount(),
            cartIcon(),
            //cartIcon()
          ],
        ),
      ),
    );
  }

  Widget buildCount() {
    return BlocBuilder<CartItemCounterBloc, CartItemCounterState>(
      builder: (context, state) {
        if (state.count <= 0) return Container();
        return Container(
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Text(
            //"99+",
            //"9977",
            state.count.toString(),
            style: TextStyle(
                color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  Widget cartIcon() => Icon(
        Icons.shopping_cart,
        color: Colors.white,
      );
}
