import 'package:equatable/equatable.dart';

abstract class PizzaListEvent extends Equatable {
  const PizzaListEvent();

  @override
  List<Object> get props => [];
}

class PizzasRequested extends PizzaListEvent {}