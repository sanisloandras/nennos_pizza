abstract class CartItemCounterEvent {}

class CountRequested extends CartItemCounterEvent {}
class Incremented extends CartItemCounterEvent {}
class Decremented extends CartItemCounterEvent {}
class Cleared extends CartItemCounterEvent {}