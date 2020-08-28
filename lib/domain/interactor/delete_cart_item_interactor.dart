import 'package:nennos_pizza/domain/dao/drink_cart_dao.dart';
import 'package:nennos_pizza/domain/dao/pizza_cart_dao.dart';
import 'package:nennos_pizza/domain/model/cart_item.dart';

class RemoveCartItemInteractor {
  final PizzaCartDao _pizzaCartDao;
  final DrinkCartDao _drinkCartDao;

  RemoveCartItemInteractor(this._pizzaCartDao, this._drinkCartDao);

  invoke(CartItem cartItem) async {
    //todo not cool... merging the daos could solve this
    try {
      var pizzaCartItem = (await _pizzaCartDao.allOnce())
          .firstWhere((element) => element.id == cartItem.id);
      if (pizzaCartItem != null) {
        await _pizzaCartDao.deleteEntity(pizzaCartItem);
        return;
      }
    } catch (e) {
      try {
        var drinkCartItem = (await _drinkCartDao.allOnce())
            .firstWhere((element) => element.id == cartItem.id);
        if (drinkCartItem != null)
          await _drinkCartDao.deleteEntity(drinkCartItem);
      } catch (e) {}
    }
  }
}
