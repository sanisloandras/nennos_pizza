import '../model/drink_item.dart';
import '../repository/drinks_repository.dart';

class LoadDrinksInteractor {
  final DrinkRepository _drinkRepository;

  LoadDrinksInteractor(this._drinkRepository);

  Future<List<DrinkItem>> invoke() {
    return _drinkRepository.drinks().then((drinks) {
      return drinks.map((drink) {
        return DrinkItem(drink.id, drink.name, "\$${drink.price}");
      }).toList();
    });
  }
}