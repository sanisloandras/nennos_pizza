import 'package:floor/floor.dart';
import 'package:nennos_pizza/domain/entity/drink_cart_entity.dart';

@dao
abstract class DrinkCartDao {
  @Query('SELECT * FROM DrinkCartEntity')
  Stream<List<DrinkCartEntity>> all();

  @Query('SELECT * FROM DrinkCartEntity')
  Future<List<DrinkCartEntity>> allOnce();

  @Insert()
  Future<void> insert(DrinkCartEntity entity);

  @delete
  Future<void> deleteEntity(DrinkCartEntity entity);

  @Query('DELETE FROM DrinkCartEntity')
  Future<void> clear();
}