import 'package:floor/floor.dart';

@entity
class DrinkCartEntity {
  @primaryKey
  final String id;
  final int drinkId;
  final String name;
  final double price;
  final String createdAt;

  DrinkCartEntity(this.id, this.drinkId, this.name, this.price, this.createdAt);
}