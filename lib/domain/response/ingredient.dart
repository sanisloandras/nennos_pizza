class Ingredient {
  int id;
  String name;
  dynamic price;

  Ingredient(this.id, this.name, this.price);

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      json['id'],
      json['name'],
      json['price'],
    );
  }
}