import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nennos_pizza/presentation/cart/cart_bloc.dart';
import 'package:nennos_pizza/presentation/cart/cart_event.dart';
import 'package:nennos_pizza/presentation/cart/cart_list_widget.dart';
import 'package:nennos_pizza/presentation/cart/cart_state.dart';
import 'package:nennos_pizza/presentation/cart/checkout_state.dart';
import 'package:nennos_pizza/presentation/cart/checkout_widget.dart';

class CartContainerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartBloc>(
      create: (context) {
        return CartBloc(GetIt.instance.get(), GetIt.instance.get(),
            GetIt.instance.get(), BlocProvider.of(context))
          ..add(CartRequested());
      },
      child: Scaffold(
          appBar: buildAppBar(() => Navigator.of(context).pushNamed("/drinks")),
          body: BlocListener<CartBloc, CartState>(
            listener: (context, state) {
              if (state.checkoutState == CheckoutState.SUCCESS) {
                Navigator.of(context).pushNamed("/order_confirmed");
              } else if (state.checkoutState == CheckoutState.FAILED) {
                showUnexpectedErrirDialog(context);
                BlocProvider.of<CartBloc>(context)
                    .add(CheckoutFailedNotified());
              }
            },
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return buildContent(state, context);
              },
            ),
          )),
    );
  }

  buildContent(CartState state, BuildContext context) {
    if (state.cartItems.isEmpty) return buildEmptyView();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: CartListWidget(state.cartItems, (cartItem) {
            BlocProvider.of<CartBloc>(context)
                .add(CartItemRemoved(cartItem));
          }),
        ),
        GestureDetector(
          onTap: () =>
              BlocProvider.of<CartBloc>(context).add(Checkout()),
          child: CheckoutWidget(
            text: "Checkout (\$${state.price})",
          ),
        )
      ],
    );
  }

  void showUnexpectedErrirDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Oops!"),
            content: Text("Unexpected error :/"),
            actions: [
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  Center buildEmptyView() {
    return Center(
      child: Text("Your cart is empty :/"),
    );
  }

  AppBar buildAppBar(Future<Object> onTapDrinks()) {
    return AppBar(
      actions: <Widget>[buildDrinksButton(onTapDrinks)],
      title: Text("Cart"),
    );
  }

  IconButton buildDrinksButton(Function onPressed) {
    return IconButton(
        icon: Icon(
          Icons.local_drink,
          color: Colors.white,
        ),
        onPressed: onPressed);
  }
}
