import 'package:equatable/equatable.dart';
import 'package:nennos_pizza/domain/model/cart_item.dart';
import 'package:nennos_pizza/presentation/cart/checkout_state.dart';

class CartState extends Equatable {
  final bool isLoading;
  final num price;
  final List<CartItem> cartItems;
  final CheckoutState checkoutState;

  CartState({this.isLoading, this.price, this.cartItems, this.checkoutState});

  CartState copyWith({bool isLoading, num price, List<CartItem> cartItems, CheckoutState checkoutState}) {
    return CartState(
        isLoading: isLoading ?? this.isLoading,
        price: price ?? this.price,
        cartItems: cartItems ?? this.cartItems,
        checkoutState: checkoutState ?? this.checkoutState);
  }

  @override
  List<Object> get props => [isLoading, price, cartItems, checkoutState];
}
