import 'package:equatable/equatable.dart';
import 'package:nennos_pizza/domain/model/drink_item.dart';

class DrinksState extends Equatable {
  final bool isLoading;
  final List<DrinkItem> drinks;
  final bool hasError;

  DrinksState(this.isLoading, this.drinks, this.hasError);

  @override
  List<Object> get props => [isLoading, drinks, hasError];
}