import 'package:nennos_pizza/domain/repository/ingredients_repository.dart';
import 'package:nennos_pizza/presentation/pizza_details/pizza_details_state.dart';
import 'package:nennos_pizza/domain/model/ingredient.dart' as pizzadetails;

class IngredientCheckedInteractor {
  final IngredientRepository _ingredientsRepository;

  IngredientCheckedInteractor(this._ingredientsRepository);

  Future<PizzaDetailsState> invoke(PizzaDetailsState state, int ingredientId, bool isChecked) {
    return _ingredientsRepository.ingredients().then((ingredients) {
      var ingredientPrice = ingredients.firstWhere((ingredient) {
        return ingredient.id == ingredientId;
      }).price;
      var index = state.ingredients.indexWhere((element) {
        return (element.id == ingredientId);
      });
      var elementToReplace = state.ingredients[index];
      state.ingredients[index] = pizzadetails.Ingredient(
          elementToReplace.id,
          elementToReplace.name,
          elementToReplace.price,
          isChecked);
      var newPrice = (isChecked)
          ? state.price + ingredientPrice
          : state.price - ingredientPrice;
      return state.copyWith(price: newPrice, ingredients: state.ingredients);
    });
  }
}