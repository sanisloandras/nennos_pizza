import 'package:nennos_pizza/domain/dao/drink_cart_dao.dart';
import 'package:nennos_pizza/domain/entity/drink_cart_entity.dart';
import 'package:nennos_pizza/domain/model/drink_item.dart';
import 'package:nennos_pizza/domain/repository/drinks_repository.dart';
import 'package:uuid/uuid.dart';

class AddDrinkToCartInteractor {
  final DrinkRepository _drinkRepository;
  final DrinkCartDao _drinkCartDao;

  AddDrinkToCartInteractor(this._drinkRepository, this._drinkCartDao);

  invoke(DrinkItem drinkItem) async {
    var drinks = await _drinkRepository.drinks();
    var drink = drinks.firstWhere((element) => element.id == drinkItem.id);
    var entity = DrinkCartEntity(
        Uuid().v4(),
        drink.id,
        drink.name,
        drink.price.toDouble(),
        //todo
        ""
    );
    await _drinkCartDao.insert(entity);
  }
}