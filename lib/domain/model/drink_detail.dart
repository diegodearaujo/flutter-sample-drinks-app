class DrinkDetail {
  final int id;
  final String instructions;
  final String name;
  final String image;
  final List<Ingredient> ingredients;

  const DrinkDetail({
    required this.id,
    required this.instructions,
    required this.name,
    required this.image,
    required this.ingredients,
  });
}

class Ingredient {
  final String name;
  final String measure;

  Ingredient(this.name, this.measure);
}
