import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';
import 'package:nennos_pizza/domain/dao/drink_cart_dao.dart';
import 'package:nennos_pizza/domain/dao/pizza_cart_dao.dart';
import 'package:nennos_pizza/domain/entity/drink_cart_entity.dart';
import 'package:nennos_pizza/domain/entity/pizza_cart_entity.dart';
part 'database.g.dart';

@Database(version: 2, entities: [PizzaCartEntity, DrinkCartEntity])
abstract class AppDatabase extends FloorDatabase {
  PizzaCartDao get pizzaCartDao;
  DrinkCartDao get drinkCartDao;
}
