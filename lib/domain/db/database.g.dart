// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PizzaCartDao _pizzaCartDaoInstance;

  DrinkCartDao _drinkCartDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PizzaCartEntity` (`id` TEXT, `name` TEXT, `price` REAL, `ingredientIds` TEXT, `createdAt` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DrinkCartEntity` (`id` TEXT, `drinkId` INTEGER, `name` TEXT, `price` REAL, `createdAt` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PizzaCartDao get pizzaCartDao {
    return _pizzaCartDaoInstance ??= _$PizzaCartDao(database, changeListener);
  }

  @override
  DrinkCartDao get drinkCartDao {
    return _drinkCartDaoInstance ??= _$DrinkCartDao(database, changeListener);
  }
}

class _$PizzaCartDao extends PizzaCartDao {
  _$PizzaCartDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _pizzaCartEntityInsertionAdapter = InsertionAdapter(
            database,
            'PizzaCartEntity',
            (PizzaCartEntity item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'price': item.price,
                  'ingredientIds': item.ingredientIds,
                  'createdAt': item.createdAt
                },
            changeListener),
        _pizzaCartEntityDeletionAdapter = DeletionAdapter(
            database,
            'PizzaCartEntity',
            ['id'],
            (PizzaCartEntity item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'price': item.price,
                  'ingredientIds': item.ingredientIds,
                  'createdAt': item.createdAt
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _pizzaCartEntityMapper = (Map<String, dynamic> row) =>
      PizzaCartEntity(
          row['id'] as String,
          row['name'] as String,
          row['price'] as double,
          row['ingredientIds'] as String,
          row['createdAt'] as String);

  final InsertionAdapter<PizzaCartEntity> _pizzaCartEntityInsertionAdapter;

  final DeletionAdapter<PizzaCartEntity> _pizzaCartEntityDeletionAdapter;

  @override
  Stream<List<PizzaCartEntity>> all() {
    return _queryAdapter.queryListStream('SELECT * FROM PizzaCartEntity',
        queryableName: 'PizzaCartEntity',
        isView: false,
        mapper: _pizzaCartEntityMapper);
  }

  @override
  Future<List<PizzaCartEntity>> allOnce() async {
    return _queryAdapter.queryList('SELECT * FROM PizzaCartEntity',
        mapper: _pizzaCartEntityMapper);
  }

  @override
  Future<void> clear() async {
    await _queryAdapter.queryNoReturn('DELETE FROM PizzaCartEntity');
  }

  @override
  Future<void> insert(PizzaCartEntity entity) async {
    await _pizzaCartEntityInsertionAdapter.insert(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteEntity(PizzaCartEntity entity) async {
    await _pizzaCartEntityDeletionAdapter.delete(entity);
  }
}

class _$DrinkCartDao extends DrinkCartDao {
  _$DrinkCartDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _drinkCartEntityInsertionAdapter = InsertionAdapter(
            database,
            'DrinkCartEntity',
            (DrinkCartEntity item) => <String, dynamic>{
                  'id': item.id,
                  'drinkId': item.drinkId,
                  'name': item.name,
                  'price': item.price,
                  'createdAt': item.createdAt
                },
            changeListener),
        _drinkCartEntityDeletionAdapter = DeletionAdapter(
            database,
            'DrinkCartEntity',
            ['id'],
            (DrinkCartEntity item) => <String, dynamic>{
                  'id': item.id,
                  'drinkId': item.drinkId,
                  'name': item.name,
                  'price': item.price,
                  'createdAt': item.createdAt
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _drinkCartEntityMapper = (Map<String, dynamic> row) =>
      DrinkCartEntity(
          row['id'] as String,
          row['drinkId'] as int,
          row['name'] as String,
          row['price'] as double,
          row['createdAt'] as String);

  final InsertionAdapter<DrinkCartEntity> _drinkCartEntityInsertionAdapter;

  final DeletionAdapter<DrinkCartEntity> _drinkCartEntityDeletionAdapter;

  @override
  Stream<List<DrinkCartEntity>> all() {
    return _queryAdapter.queryListStream('SELECT * FROM DrinkCartEntity',
        queryableName: 'DrinkCartEntity',
        isView: false,
        mapper: _drinkCartEntityMapper);
  }

  @override
  Future<List<DrinkCartEntity>> allOnce() async {
    return _queryAdapter.queryList('SELECT * FROM DrinkCartEntity',
        mapper: _drinkCartEntityMapper);
  }

  @override
  Future<void> clear() async {
    await _queryAdapter.queryNoReturn('DELETE FROM DrinkCartEntity');
  }

  @override
  Future<void> insert(DrinkCartEntity entity) async {
    await _drinkCartEntityInsertionAdapter.insert(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteEntity(DrinkCartEntity entity) async {
    await _drinkCartEntityDeletionAdapter.delete(entity);
  }
}
