import 'package:flutter/foundation.dart';
import 'package:nennos_pizza/domain/dao/pizza_cart_dao.dart';
import 'package:nennos_pizza/domain/entity/pizza_cart_entity.dart';
import 'package:nennos_pizza/domain/repository/pizza_repository.dart';
import 'package:nennos_pizza/presentation/pizza_details/pizza_details_state.dart';
import 'package:uuid/uuid.dart';

class AddPizaToCartInteractor {
  final PizzaCartDao _pizzaCartDao;
  final PizzaRepository _pizzaRepository;

  AddPizaToCartInteractor(this._pizzaCartDao, this._pizzaRepository);

  invoke(PizzaDetailsState state) async {
    var pizzas = await _pizzaRepository.pizzas();
    var pizzasIngredients = pizzas.pizzas.firstWhere((element) => element.name == state.name).ingredients;
    var selectedIngredients = state.ingredients.where((element) => element.isChecked == true)
      .map((e) => e.id).toList();
    var isCustom = !listEquals(pizzasIngredients, selectedIngredients);
    var entity = PizzaCartEntity(
        Uuid().v4(),
      (isCustom) ? "Custom ${state.name}" : state.name,
        state.price.toDouble(),
      selectedIngredients.join(","),
      //todo
      ""
    );
    _pizzaCartDao.insert(entity);
  }
}