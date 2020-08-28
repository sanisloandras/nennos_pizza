import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nennos_pizza/presentation/common/error_widget.dart';
import 'package:nennos_pizza/presentation/common/loading_widget.dart';
import 'package:nennos_pizza/presentation/pizza_details/pizza_details_args.dart';
import 'package:nennos_pizza/presentation/pizza_details/pizza_details_bloc.dart';
import 'package:nennos_pizza/presentation/pizza_details/pizza_details_event.dart';
import 'package:nennos_pizza/presentation/pizza_list/cart_item_counter/cart_item_counter_widget.dart';
import 'package:nennos_pizza/presentation/pizza_list/pizza_list_bloc.dart';
import 'package:nennos_pizza/presentation/pizza_list/pizza_list_item_widget.dart';
import 'package:nennos_pizza/presentation/pizza_list/pizza_list_state.dart';

class PizzaListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[CartItemCounterWidget()],
        title: Text("Nenno's pizza"),
      ),
      body: buildBody(),
    );
  }

  BlocBuilder<PizzaListBloc, PizzaListState> buildBody() {
    return BlocBuilder<PizzaListBloc, PizzaListState>(
      builder: (context, state) {
        if (state is PizzaListLoading) {
          return LoadingWidget();
        } else if (state is PizzaListFailure) {
          return UnexpectedErrorWidget();
        } else if (state is PizzaListLoaded) {
          return ListView.builder(
            itemCount: state.pizzas?.length ?? 0,
            itemBuilder: (context, index) {
              return PizzaListItemWidget(
                pizzaListItem: state.pizzas[index],
                onTap: () {
                  BlocProvider.of<PizzaDetailsBloc>(context)
                    ..add(PizzaDetailsRequested(state.pizzas[index].name));
                  Navigator.of(context).pushNamed("/pizzaDetails",
                      arguments: PizzaDetailsArgs(state.pizzas[index].name));
                },
              );
            },
          );
        }
        throw Exception("Unknown state $state");
      },
    );
  }

}
