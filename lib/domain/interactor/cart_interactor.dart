import 'package:nennos_pizza/domain/dao/drink_cart_dao.dart';
import 'package:nennos_pizza/domain/dao/pizza_cart_dao.dart';
import 'package:nennos_pizza/domain/model/cart_item.dart';
import 'package:nennos_pizza/presentation/cart/cart_ui.dart';
import 'package:rxdart/rxdart.dart';

class CartInteractor {
  final PizzaCartDao _pizzaCartDao;
  final DrinkCartDao _drinkCartDao;

  CartInteractor(this._pizzaCartDao, this._drinkCartDao);

  Stream<CartUi> invoke() {
    var pizzas = _pizzaCartDao.all().map(mapper);
    var drinks = _drinkCartDao.all().map(mapper);
    return Rx.combineLatest([pizzas, drinks], (values) {
      T pizzaCart = values[0];
      T drinkCart = values[1];
      var cartItems = List<CartItem>();
      cartItems.addAll(pizzaCart.cartItems);
      cartItems.addAll(drinkCart.cartItems);
      return CartUi(cartItems, pizzaCart.price + drinkCart.price);
    });
  }

  T mapper(event) {
    var cartList = List<CartItem>();
    var price = 0.0;
    event.forEach((element) {
      cartList.add(CartItem(element.id, element.name, "\$${element.price}"));
      price += element.price;
    });
    return T(cartList, price);
  }
}

class T {
  final List<CartItem> cartItems;
  final double price;

  T(this.cartItems, this.price);
}
