import 'package:equatable/equatable.dart';

abstract class PizzaDetailsEvent extends Equatable {
  const PizzaDetailsEvent();

  @override
  List<Object> get props => [];
}

class PizzaDetailsRequested extends PizzaDetailsEvent {
  final String name;

  PizzaDetailsRequested(this.name);

  @override
  List<Object> get props => [name];
}

class IngredientChecked extends PizzaDetailsEvent {
  final int id;
  final bool isChecked;

  IngredientChecked(this.id, this.isChecked);

  @override
  List<Object> get props => [id, isChecked];
}