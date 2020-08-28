import 'package:floor/floor.dart';
import 'package:nennos_pizza/domain/entity/pizza_cart_entity.dart';

@dao
abstract class PizzaCartDao {
  @Query('SELECT * FROM PizzaCartEntity')
  Stream<List<PizzaCartEntity>> all();

  @Query('SELECT * FROM PizzaCartEntity')
  Future<List<PizzaCartEntity>> allOnce();

  @Insert()
  Future<void> insert(PizzaCartEntity entity);

  @delete
  Future<void> deleteEntity(PizzaCartEntity entity);

  @Query('DELETE FROM PizzaCartEntity')
  Future<void> clear();

  //todo maybe in a future version of floor this will be supported
  /*@Query('COUNT(*)')
  Future<int> count();*/
}