import 'dart:convert';

import 'package:nennos_pizza/domain/network/data_api.dart';
import 'package:nennos_pizza/domain/response/drink.dart';

class DrinkRepository {
  final DataApi _api;
  List<Drink> cache;

  DrinkRepository(this._api);

  Future<List<Drink>> drinks() {
    if (cache != null) return Future.value(cache);
    return _api.drinks().then((response) {
      var json = jsonDecode(response.data);
      cache = (json as List<dynamic>).map((json) {
        return Drink.fromJson(json);
      }).toList();
      return cache;
    });
  }
}