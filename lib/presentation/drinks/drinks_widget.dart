import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nennos_pizza/domain/model/drink_item.dart';
import 'package:nennos_pizza/presentation/common/error_widget.dart';
import 'package:nennos_pizza/presentation/common/loading_widget.dart';
import 'package:nennos_pizza/presentation/drinks/drink_list_item_widget.dart';
import 'package:nennos_pizza/presentation/drinks/drinks_bloc.dart';
import 'package:nennos_pizza/presentation/drinks/drinks_event.dart';
import 'package:nennos_pizza/presentation/drinks/drinks_state.dart';
import 'package:nennos_pizza/presentation/pizza_list/cart_item_counter/cart_item_counter_bloc.dart';
import 'package:nennos_pizza/presentation/pizza_list/pizza_list_bloc.dart';

class DrinksWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var cartItemCounterBloc = BlocProvider.of<CartItemCounterBloc>(context);
    var pizzaList = BlocProvider.of<PizzaListBloc>(context);
    return BlocProvider<DrinksBloc>(
      create: (context) {
        return DrinksBloc(GetIt.instance.get(), GetIt.instance.get(), cartItemCounterBloc)
          ..add(DrinksRequested());
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Drinks"),
          ),
          body: BlocBuilder<DrinksBloc, DrinksState>(
            builder: (context, state) {
              if (state.isLoading) {
                return LoadingWidget();
              } else if (state.hasError) {
                return UnexpectedErrorWidget();
              } else {
                return ListView.builder(
                    itemCount: state.drinks.length,
                    itemBuilder: (context, index) {
                      return DrinkListItemWidget(
                        drinkItem: state.drinks[index],
                        onAdd: (drinkItem) {
                          BlocProvider.of<DrinksBloc>(context).add(AddedToCart(
                              drinkItem));
                        },
                      );
                    });
              }
            },
          )
      ),
    );
  }
}