import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nennos_pizza/domain/interactor/cart_interactor.dart';
import 'package:nennos_pizza/domain/interactor/checkout_interactor.dart';
import 'package:nennos_pizza/domain/interactor/delete_cart_item_interactor.dart';
import 'package:nennos_pizza/presentation/cart/cart_event.dart';
import 'package:nennos_pizza/presentation/cart/cart_state.dart';
import 'package:nennos_pizza/presentation/cart/checkout_state.dart';
import 'package:nennos_pizza/presentation/pizza_list/cart_item_counter/cart_item_counter_bloc.dart';
import 'package:nennos_pizza/presentation/pizza_list/cart_item_counter/cart_item_counter_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartInteractor _cartInteractor;
  final RemoveCartItemInteractor _removeCartItemInteractor;
  final CheckoutInteractor _checkoutInteractor;
  final CartItemCounterBloc _cartItemCounterBloc;
  StreamSubscription _cartSubscription;

  CartBloc(this._cartInteractor, this._removeCartItemInteractor,
      this._checkoutInteractor, this._cartItemCounterBloc)
      : super(CartState(isLoading: true, price: 0, cartItems: [], checkoutState: CheckoutState.INITIAL));

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is CartRequested) {
      _cartSubscription?.cancel();
      _cartSubscription = _cartInteractor.invoke().listen((event) {
        add(CartUpdated(event));
      });
    } else if (event is CartUpdated) {
      yield state.copyWith(
          isLoading: false,
          price: event.cartUi.price,
          cartItems: event.cartUi.cartItems);
    } else if (event is CartItemRemoved) {
      await _removeCartItemInteractor.invoke(event.cartItem);
      _cartItemCounterBloc.add(Decremented());
    } else if (event is Checkout) {
      var checkout = _checkoutInteractor.invoke();
      try {
        await checkout;
        _cartItemCounterBloc.add(Cleared());
        yield state.copyWith(checkoutState: CheckoutState.SUCCESS, cartItems: []);
      } catch (e) {
        yield state.copyWith(checkoutState: CheckoutState.FAILED);
      }
    } else if (event is CheckoutFailedNotified) {
      yield state.copyWith(checkoutState: CheckoutState.INITIAL);
    }
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    return super.close();
  }
}
