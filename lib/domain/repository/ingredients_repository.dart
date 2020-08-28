import 'dart:convert';

import 'package:nennos_pizza/domain/network/data_api.dart';
import 'package:nennos_pizza/domain/response/ingredient.dart';

class IngredientRepository {
  final DataApi _api;
  List<Ingredient> cache;

  IngredientRepository(this._api);

  Future<List<Ingredient>> ingredients() {
    if (cache != null) return Future.value(cache);
    return _api.ingredients().then((response) {
      var json = jsonDecode(response.data);
      cache = (json as List<dynamic>).map((ingredientJson) {
        return Ingredient.fromJson(ingredientJson);
      }).toList();
      return cache;
    });
  }
}