import 'package:floor/floor.dart';

@entity
class PizzaCartEntity {
  @primaryKey
  final String id;
  final String name;
  final double price;
  final String ingredientIds;
  final String createdAt;

  PizzaCartEntity(this.id, this.name, this.price, this.ingredientIds, this.createdAt);
}