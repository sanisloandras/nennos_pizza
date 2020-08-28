import 'package:equatable/equatable.dart';
import 'package:nennos_pizza/domain/model/drink_item.dart';

abstract class DrinksEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DrinksRequested extends DrinksEvent {}

class AddedToCart extends DrinksEvent {
  final DrinkItem drinkItem;

  AddedToCart(this.drinkItem);

  @override
  List<Object> get props => [props];
}