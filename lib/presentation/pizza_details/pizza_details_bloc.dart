import 'package:bloc/bloc.dart';
import 'package:nennos_pizza/domain/interactor/ingredient_checked_interactor.dart';
import 'package:nennos_pizza/domain/model/ingredient.dart' as PizzaDetails;
import 'package:nennos_pizza/domain/repository/ingredients_repository.dart';
import 'package:nennos_pizza/domain/repository/pizza_repository.dart';
import 'package:nennos_pizza/domain/response/ingredient.dart';
import 'package:nennos_pizza/domain/response/pizzas_response.dart';
import 'package:nennos_pizza/presentation/pizza_details/pizza_details_event.dart';
import 'package:nennos_pizza/presentation/pizza_details/pizza_details_state.dart';

class PizzaDetailsBloc extends Bloc<PizzaDetailsEvent, PizzaDetailsState> {
  final PizzaRepository _pizzaRepository;
  final IngredientRepository _ingredientsRepository;
  final IngredientCheckedInteractor _ingredientCheckedInteractor;

  PizzaDetailsBloc(this._pizzaRepository, this._ingredientsRepository,
      this._ingredientCheckedInteractor)
      : super(PizzaDetailsState(
            isLoading: true));

  @override
  Stream<PizzaDetailsState> mapEventToState(PizzaDetailsEvent event) async* {
    if (event is PizzaDetailsRequested) {
      yield await _pizzaDetailsRequestedToState(event.name);
    } else if (event is IngredientChecked) {
      yield await _ingredientCheckedInteractor.invoke(
          state, event.id, event.isChecked);
    }
  }

  _pizzaDetailsRequestedToState(pizzaName) {
    var pizzaResponseFuture = _pizzaRepository.pizzas();
    var ingredientsFuture = _ingredientsRepository.ingredients();
    return Future.wait([pizzaResponseFuture, ingredientsFuture])
        .then((values) {
      PizzasResponse pizzasResponse = values[0];
      List<Ingredient> ingredients = values[1];
      var pizza = pizzasResponse.pizzas.firstWhere((pizza) {
        return pizza.name == pizzaName;
      });
      var ingredientsUi = ingredients.map((ingredient) {
        return PizzaDetails.Ingredient(
            ingredient.id,
            ingredient.name,
            "\$${ingredient.price}",
            pizza.ingredients.contains(ingredient.id));
      });
      var pizzasIngredients = ingredients.where((ingredient) {
        return pizza.ingredients.contains(ingredient.id);
      });
      return PizzaDetailsState(
          isLoading: false,
          name: pizzaName,
          imageUrl: pizza.imageUrl,
          ingredients: ingredientsUi.toList(),
          price: _calcPizzaPrice(pizzasResponse, pizzasIngredients));
    });
  }

  num _calcPizzaPrice(
      PizzasResponse pizzasResponse, Iterable<Ingredient> pizzasIngredients) {
    var price = pizzasResponse.basePrice +
        pizzasIngredients.map((ingredient) {
          return ingredient.price;
        }).reduce((p1, p2) {
          return p1 + p2;
        });
    return price;
  }
}
