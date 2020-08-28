import '../db/database.dart';

class CartItemCountInteractor {
  final AppDatabase _database;

  CartItemCountInteractor(this._database);

  Future<int> invoke() async {
    var drinks = count("DrinkCartEntity");
    var pizzas = count("PizzaCartEntity");
    return Future.wait([pizzas, drinks])
        .then((value) {
      return value.reduce((value, element) => value + element);
    });
  }

  Future<int> count(String from) {
    return _database.database.rawQuery("SELECT COUNT(*) FROM $from").then((value) => value.first["COUNT(*)"]);
  }
}