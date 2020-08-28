import 'package:equatable/equatable.dart';
import 'package:nennos_pizza/domain/model/pizza_list_item.dart';

abstract class PizzaListState extends Equatable {

  @override
  List<Object> get props => [];
}

class PizzaListLoading extends PizzaListState {}

class PizzaListLoaded extends PizzaListState {
  final List<PizzaItem> pizzas;

  PizzaListLoaded(this.pizzas);

  @override
  List<Object> get props => [pizzas];
}

class PizzaListFailure extends PizzaListState {}