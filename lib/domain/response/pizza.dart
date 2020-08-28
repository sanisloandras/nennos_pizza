class Pizza {
  String imageUrl;
  List<int> ingredients;
  String name;

  Pizza(this.imageUrl, this.ingredients, this.name);

  factory Pizza.fromJson(Map<String, dynamic> json) {
    var ingredients = (json['ingredients'] as List).map((i) {
      return i as int;
    }).toList();
    return Pizza(
        json['imageUrl'],
        ingredients,
        json['name'],
    );
  }
}