import 'package:nennos_pizza/domain/response/pizza.dart';

class PizzasResponse {
  int basePrice;
  List<Pizza> pizzas;

  PizzasResponse(this.basePrice, this.pizzas);

  factory PizzasResponse.fromJson(Map<String, dynamic> json) {
    var pizzas = (json['pizzas'] as List).map((i) {
      return Pizza.fromJson(i);
    }).toList();
    return PizzasResponse(
        json['basePrice'],
        pizzas
    );
  }
}