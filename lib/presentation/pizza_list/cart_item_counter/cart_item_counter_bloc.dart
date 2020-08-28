import 'package:bloc/bloc.dart';
import 'package:nennos_pizza/domain/interactor/cart_item_count_interactor.dart';
import 'package:nennos_pizza/presentation/pizza_list/cart_item_counter/cart_item_counter_event.dart';
import 'package:nennos_pizza/presentation/pizza_list/cart_item_counter/cart_item_counter_state.dart';

class CartItemCounterBloc extends Bloc<CartItemCounterEvent, CartItemCounterState> {
  CartItemCountInteractor _cartItemCountInteractor;

  CartItemCounterBloc(this._cartItemCountInteractor) : super(CartItemCounterState(0));

  @override
  Stream<CartItemCounterState> mapEventToState(CartItemCounterEvent event) async* {
    if (event is CountRequested) {
      var i = await _cartItemCountInteractor.invoke();
      yield CartItemCounterState(i);
    } else if (event is Incremented) {
      yield CartItemCounterState(state.count + 1);
    } else if (event is Decremented) {
      yield CartItemCounterState(state.count - 1);
    } else if (event is Cleared) {
      yield CartItemCounterState(0);
    }
  }
}
