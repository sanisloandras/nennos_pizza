import 'package:nennos_pizza/domain/model/pizza_list_item.dart';
import 'package:nennos_pizza/domain/repository/ingredients_repository.dart';
import 'package:nennos_pizza/domain/repository/pizza_repository.dart';
import 'package:nennos_pizza/domain/response/ingredient.dart';
import 'package:nennos_pizza/domain/response/pizzas_response.dart';

class LoadPizzaListInteractor {
  final PizzaRepository _pizzaRepository;
  final IngredientRepository _ingredientRepository;

  LoadPizzaListInteractor(this._pizzaRepository, this._ingredientRepository);

  Future<List<PizzaItem>> invoke() {
    var pizzaResponseFuture = _pizzaRepository.pizzas();
    var ingredientsFuture = _ingredientRepository.ingredients();
    return Future.wait([pizzaResponseFuture, ingredientsFuture]).then((values) {
      PizzasResponse pizzasResponse = values[0];
      List<Ingredient> ingredients = values[1];
      return pizzasResponse.pizzas.map((pizza) {
        var pizzasIngredients = ingredients
            .where((ingredient) => pizza.ingredients.contains(ingredient.id));
        num price = _calcPizzaPrice(pizzasResponse, pizzasIngredients);
        return PizzaItem(pizza.name, _ingredientsText(pizzasIngredients),
            "\$$price", pizza.imageUrl);
      }).toList();
    });
  }

  String _ingredientsText(Iterable<Ingredient> pizzasIngredients) {
    return pizzasIngredients.map((ingredient) {
      return ingredient.name;
    }).join(", ");
  }

  num _calcPizzaPrice(
      PizzasResponse pizzasResponse, Iterable<Ingredient> pizzasIngredients) {
    return pizzasResponse.basePrice +
        pizzasIngredients.map((ingredient) {
          return ingredient.price;
        }).reduce((p1, p2) {
          return p1 + p2;
        });
  }
}
