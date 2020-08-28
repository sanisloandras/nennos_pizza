import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nennos_pizza/domain/dao/drink_cart_dao.dart';
import 'package:nennos_pizza/domain/dao/pizza_cart_dao.dart';
import 'package:nennos_pizza/domain/db/database.dart';
import 'package:nennos_pizza/domain/interactor/add_drink_to_cart_interactor.dart';
import 'package:nennos_pizza/domain/interactor/add_pizza_to_cart_interactor.dart';
import 'package:nennos_pizza/domain/interactor/cart_interactor.dart';
import 'package:nennos_pizza/domain/interactor/cart_item_count_interactor.dart';
import 'package:nennos_pizza/domain/interactor/delete_cart_item_interactor.dart';
import 'package:nennos_pizza/domain/interactor/ingredient_checked_interactor.dart';
import 'package:nennos_pizza/domain/interactor/load_drinks_interactor.dart';
import 'package:nennos_pizza/domain/interactor/load_pizza_list_interactor.dart';
import 'package:nennos_pizza/domain/network/checkout_api.dart';
import 'package:nennos_pizza/domain/network/data_api.dart';
import 'package:nennos_pizza/domain/repository/drinks_repository.dart';
import 'package:nennos_pizza/domain/repository/ingredients_repository.dart';
import 'package:nennos_pizza/domain/repository/pizza_repository.dart';
import 'package:nennos_pizza/presentation/cart/cart_container.dart';
import 'package:nennos_pizza/presentation/drinks/drinks_widget.dart';
import 'package:nennos_pizza/presentation/order_confirmed/order_confirmed_widget.dart';
import 'package:nennos_pizza/presentation/pizza_details/pizza_details_bloc.dart';
import 'package:nennos_pizza/presentation/pizza_details/pizza_details_widget.dart';
import 'package:nennos_pizza/presentation/pizza_list/cart_item_counter/cart_item_counter_bloc.dart';
import 'package:nennos_pizza/presentation/pizza_list/cart_item_counter/cart_item_counter_event.dart';
import 'package:nennos_pizza/presentation/pizza_list/pizza_list_widget.dart';
import 'domain/interactor/checkout_interactor.dart';
import 'presentation/pizza_list/pizza_list_bloc.dart';
import 'presentation/pizza_list/pizza_list_events.dart';
import 'presentation/pizza_list/pizza_list_widget.dart';

GetIt getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database =
      await $FloorAppDatabase.databaseBuilder('database.db').build();
  getIt.registerSingleton<AppDatabase>(database, signalsReady: true);
  getIt.registerSingleton(DataApi());
  var dataApi = DataApi();
  getIt.registerSingleton(PizzaRepository(dataApi));
  getIt.registerLazySingleton<IngredientRepository>(
      () => IngredientRepository(dataApi));
  getIt.registerLazySingleton<DrinkRepository>(() => DrinkRepository(dataApi));
  getIt.registerLazySingleton<PizzaCartDao>(
      () => getIt<AppDatabase>().pizzaCartDao);
  getIt.registerLazySingleton<DrinkCartDao>(
      () => getIt<AppDatabase>().drinkCartDao);
  getIt
      .registerFactory(() => LoadPizzaListInteractor(getIt.get(), getIt.get()));
  getIt.registerFactory(() => IngredientCheckedInteractor(getIt.get()));
  getIt
      .registerFactory(() => AddPizaToCartInteractor(getIt.get(), getIt.get()));
  getIt.registerFactory(() => CartInteractor(getIt.get(), getIt.get()));
  getIt.registerFactory(
      () => RemoveCartItemInteractor(getIt.get(), getIt.get()));
  getIt.registerFactory(
      () => AddDrinkToCartInteractor(getIt.get(), getIt.get()));
  getIt.registerFactory(() => LoadDrinksInteractor(getIt.get()));
  getIt.registerFactory(() => CartItemCountInteractor(database));
  getIt.registerFactory(
      () => CheckoutInteractor(CheckoutApi(), getIt.get(), getIt.get()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PizzaListBloc>(
          create: (BuildContext context) =>
              PizzaListBloc(GetIt.instance.get())..add(PizzasRequested()),
        ),
        BlocProvider<PizzaDetailsBloc>(
          create: (BuildContext context) =>
              PizzaDetailsBloc(getIt.get(), getIt.get(), getIt.get()),
        ),
        //todo search for a better solution
        BlocProvider<CartItemCounterBloc>(
          create: (context) =>
              CartItemCounterBloc(GetIt.instance.get())..add(CountRequested()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: PizzaListWidget(),
        onGenerateRoute: _getRoute,
      ),
    );
  }

  Route _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'pizzaList':
        return _buildRoute(settings, PizzaListWidget());
      case '/pizzaDetails':
        return _buildRoute(
            settings,
            PizzaDetailsWidget(
              pizzaDetailsArgs: settings.arguments,
            ));
      case '/cart':
        return _buildRoute(settings, CartContainerWidget());
      case '/drinks':
        return _buildRoute(settings, DrinksWidget());
      case '/order_confirmed':
        return _buildRoute(settings, OrderConfirmedWidget());
      default:
        return _buildRoute(settings, PizzaListWidget());
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
