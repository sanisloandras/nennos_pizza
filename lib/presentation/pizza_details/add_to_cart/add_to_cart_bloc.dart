import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nennos_pizza/domain/interactor/add_pizza_to_cart_interactor.dart';
import 'package:nennos_pizza/presentation/pizza_details/add_to_cart/add_to_cart_event.dart';
import 'package:nennos_pizza/presentation/pizza_details/add_to_cart/add_to_cart_state.dart';
import 'package:nennos_pizza/presentation/pizza_details/pizza_details_bloc.dart';
import 'package:nennos_pizza/presentation/pizza_list/cart_item_counter/cart_item_counter_bloc.dart';
import 'package:nennos_pizza/presentation/pizza_list/cart_item_counter/cart_item_counter_event.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  final PizzaDetailsBloc _pizzaDetailsBloc;
  final AddPizaToCartInteractor _addPizaToCartInteractor;
  final CartItemCounterBloc _cartItemCounterBloc;
  StreamSubscription _pizzaDetailsSubscription;

  AddToCartBloc(this._pizzaDetailsBloc, this._addPizaToCartInteractor, this._cartItemCounterBloc) : super(AddToCartState(isEnabled: true, price: 0)) {
    add(PriceChanged(_pizzaDetailsBloc.state.price));
    _pizzaDetailsSubscription = _pizzaDetailsBloc.listen((state) {
      add(PriceChanged(state.price));
    });
  }

  @override
  Future<void> close() {
    _pizzaDetailsSubscription.cancel();
    return super.close();
  }

  @override
  Stream<AddToCartState> mapEventToState(AddToCartEvent event) async* {
    if (event is PriceChanged) {
      yield state.copyWith(price: event.price);
    } else if (event is AddedToCart) {
      yield state.copyWith(isEnabled: false);
      _addPizaToCartInteractor.invoke(_pizzaDetailsBloc.state);
      _cartItemCounterBloc.add(Incremented());
      await Future.delayed(Duration(seconds: 3));
      yield state.copyWith(isEnabled: true);
    }
  }


}