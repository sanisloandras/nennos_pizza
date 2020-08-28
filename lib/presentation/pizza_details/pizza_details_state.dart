import 'package:nennos_pizza/domain/model/ingredient.dart';

class PizzaDetailsState {
  final bool isLoading;
  final String name;
  final String imageUrl;
  final List<Ingredient> ingredients;
  final num price;

  PizzaDetailsState(
      {this.isLoading, this.name, this.imageUrl, this.ingredients, this.price});

  PizzaDetailsState copyWith(
      {bool isLoading,
      String name,
      String imageUrl,
      List<Ingredient> ingredients,
      num price}) {
    return PizzaDetailsState(
        isLoading: isLoading ?? this.isLoading,
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
        ingredients: ingredients ?? this.ingredients,
        price: price ?? this.price);
  }
}
