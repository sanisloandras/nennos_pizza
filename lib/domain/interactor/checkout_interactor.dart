import 'package:flutter/widgets.dart';
import 'package:nennos_pizza/domain/dao/drink_cart_dao.dart';
import 'package:nennos_pizza/domain/dao/pizza_cart_dao.dart';
import 'package:nennos_pizza/domain/network/checkout_api.dart';

class CheckoutInteractor {
  final CheckoutApi _checkoutApi;
  final PizzaCartDao _pizzaCartDao;
  final DrinkCartDao _drinkCartDao;

  CheckoutInteractor(this._checkoutApi, this._pizzaCartDao, this._drinkCartDao);

  Future<void> invoke() {
    var pizzas = _pizzaCartDao.allOnce().then((value) {
      var pizzas = value.map((e) {
        return {
          'name': e.name,
          'ingredients': e.ingredientIds
        };
      });
      return pizzas.toList();
    });
    Future<List<int>> drinkIds = _drinkCartDao.allOnce().then((value) {
      return value.map((e) => e.drinkId).toList();
    });
    var response = Future.wait([pizzas, drinkIds]).then((value) {
      var request = {
        "pizzas": value[0],
        "drinks": value[1]
      };
      return _checkoutApi.checkout(request);
    });
    var cleanup = Future.wait([_pizzaCartDao.clear(), _drinkCartDao.clear()]);
    return response.then((value) => cleanup);
  }
}