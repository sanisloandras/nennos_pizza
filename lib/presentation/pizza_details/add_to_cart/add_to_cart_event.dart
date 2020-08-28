import 'package:equatable/equatable.dart';

abstract class AddToCartEvent extends Equatable {
  const AddToCartEvent();

  @override
  List<Object> get props => [];
}

class AddedToCart extends AddToCartEvent {}

class PriceChanged extends AddToCartEvent {
  final num price;

  PriceChanged(this.price);

  @override
  List<Object> get props => [price];
}