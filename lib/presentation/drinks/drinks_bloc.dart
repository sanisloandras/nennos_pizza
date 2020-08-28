import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nennos_pizza/domain/interactor/add_drink_to_cart_interactor.dart';
import 'package:nennos_pizza/domain/interactor/load_drinks_interactor.dart';
import 'package:nennos_pizza/presentation/drinks/drinks_event.dart';
import 'package:nennos_pizza/presentation/drinks/drinks_state.dart';
import 'package:nennos_pizza/presentation/pizza_list/cart_item_counter/cart_item_counter_bloc.dart';
import 'package:nennos_pizza/presentation/pizza_list/cart_item_counter/cart_item_counter_event.dart';

class DrinksBloc extends Bloc<DrinksEvent, DrinksState> {
  final LoadDrinksInteractor _loadDrinksInteractor;
  final AddDrinkToCartInteractor _addDrinkToCartInteractor;
  final CartItemCounterBloc _cartItemCounterBloc;

  DrinksBloc(this._loadDrinksInteractor, this._addDrinkToCartInteractor, this._cartItemCounterBloc) : super(DrinksState(true, [], false));

  @override
  Stream<DrinksState> mapEventToState(DrinksEvent event) async* {
    if (event is DrinksRequested) {
      try {
        var drinks = await _loadDrinksInteractor.invoke();
        yield DrinksState(false, drinks, false);
      } catch (e) {
        yield DrinksState(false, [], true);
      }
    } else if (event is AddedToCart) {
      await _addDrinkToCartInteractor.invoke(event.drinkItem);
      _cartItemCounterBloc.add(Incremented());
    }
  }

}