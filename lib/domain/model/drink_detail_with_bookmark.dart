import 'package:drinks_flutter_app/domain/model/drink_detail.dart';

class DrinkDetailWithBookmark extends DrinkDetail {
  final bool isBookmark;

  DrinkDetailWithBookmark(
      {required this.isBookmark,
      required int id,
      required String instructions,
      required String name,
      required String image,
      required List<Ingredient> ingredients})
      : super(
            id: id,
            instructions: instructions,
            name: name,
            image: image,
            ingredients: ingredients);

  DrinkDetailWithBookmark.fromDrinkDetail(
      {required DrinkDetail detail, required this.isBookmark})
      : super(
            id: detail.id,
            instructions: detail.instructions,
            name: detail.name,
            image: detail.image,
            ingredients: detail.ingredients);
}
