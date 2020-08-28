import 'dart:convert';

import 'package:nennos_pizza/domain/network/data_api.dart';
import 'package:nennos_pizza/domain/response/pizzas_response.dart';

class PizzaRepository {
  final DataApi _api;
  PizzasResponse cache;

  PizzaRepository(this._api);

  Future<PizzasResponse> pizzas() {
    if (cache != null) return Future.value(cache);
    return _api.pizzas().then((response) {
      Map<String, dynamic> map = jsonDecode(response.data);
      cache = PizzasResponse.fromJson(map);
      return cache;
    });
  }
}