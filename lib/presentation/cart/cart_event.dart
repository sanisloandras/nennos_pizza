import 'package:equatable/equatable.dart';
import 'package:nennos_pizza/domain/model/cart_item.dart';
import 'package:nennos_pizza/presentation/cart/cart_ui.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CartRequested extends CartEvent {}

class CartUpdated extends CartEvent {
  final CartUi cartUi;

  CartUpdated(this.cartUi);

  @override
  List<Object> get props => [cartUi];
}

class CartItemRemoved extends CartEvent {
  final CartItem cartItem;

  CartItemRemoved(this.cartItem);

  @override
  List<Object> get props => [cartItem];
}

class Checkout extends CartEvent {}

class CheckoutFailedNotified extends CartEvent {}