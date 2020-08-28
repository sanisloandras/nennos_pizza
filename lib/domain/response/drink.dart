class Drink {
  int id;
  String name;
  num price;

  Drink(this.id, this.name, this.price);

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      json['id'],
      json['name'],
      json['price'],
    );
  }
}