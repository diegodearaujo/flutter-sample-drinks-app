import 'package:drinks_flutter_app/domain/model/drink_detail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_drink_detail.g.dart';

@JsonSerializable()
class APIDrinkDetail {
  final List<APIDrinkDetailElement> drinks;

  const APIDrinkDetail({
    required this.drinks,
  });

  factory APIDrinkDetail.fromJson(Map<String, dynamic> json) =>
      _$APIDrinkDetailFromJson(json);

  Map<String, dynamic> toJson() => _$APIDrinkDetailToJson(this);
}

@JsonSerializable()
class APIDrinkDetailElement {
  final String idDrink;
  final String strInstructions;
  final String strDrink;
  final String strDrinkThumb;
  final String? strIngredient1;
  final String? strIngredient2;
  final String? strIngredient3;
  final String? strIngredient4;
  final String? strIngredient5;
  final String? strIngredient6;
  final String? strIngredient7;
  final String? strIngredient8;
  final String? strIngredient9;
  final String? strIngredient10;
  final String? strIngredient11;
  final String? strIngredient12;
  final String? strIngredient13;
  final String? strIngredient14;
  final String? strIngredient15;
  final String? strMeasure1;
  final String? strMeasure2;
  final String? strMeasure3;
  final String? strMeasure4;
  final String? strMeasure5;
  final String? strMeasure6;
  final String? strMeasure7;
  final String? strMeasure8;
  final String? strMeasure9;
  final String? strMeasure10;
  final String? strMeasure11;
  final String? strMeasure12;
  final String? strMeasure13;
  final String? strMeasure14;
  final String? strMeasure15;

  const APIDrinkDetailElement({
    required this.idDrink,
    required this.strInstructions,
    required this.strDrink,
    required this.strDrinkThumb,
    required this.strIngredient1,
    required this.strIngredient2,
    required this.strIngredient3,
    required this.strIngredient4,
    required this.strIngredient5,
    required this.strIngredient6,
    required this.strIngredient7,
    required this.strIngredient8,
    required this.strIngredient9,
    required this.strIngredient10,
    required this.strIngredient11,
    required this.strIngredient12,
    required this.strIngredient13,
    required this.strIngredient14,
    required this.strIngredient15,
    required this.strMeasure1,
    required this.strMeasure2,
    required this.strMeasure3,
    required this.strMeasure4,
    required this.strMeasure5,
    required this.strMeasure6,
    required this.strMeasure7,
    required this.strMeasure8,
    required this.strMeasure9,
    required this.strMeasure10,
    required this.strMeasure11,
    required this.strMeasure12,
    required this.strMeasure13,
    required this.strMeasure14,
    required this.strMeasure15,
  });

  factory APIDrinkDetailElement.fromJson(Map<String, dynamic> json) =>
      _$APIDrinkDetailElementFromJson(json);

  Map<String, dynamic> toJson() => _$APIDrinkDetailElementToJson(this);
}

class Pair {
  final String? left;
  final String? right;

  const Pair({
    required this.left,
    required this.right,
  });

  Ingredient? toIngredient() {
    if (left != null && right != null) {
      return Ingredient(left!, right!);
    } else {
      return null;
    }
  }
}

extension Mapper on APIDrinkDetail {
  DrinkDetail toDomain() {
    final drinkInfo = drinks.first;
    final List<Pair> ingredients = [
      Pair(left: drinkInfo.strIngredient1, right: drinkInfo.strMeasure1),
      Pair(left: drinkInfo.strIngredient2, right: drinkInfo.strMeasure2),
      Pair(left: drinkInfo.strIngredient3, right: drinkInfo.strMeasure3),
      Pair(left: drinkInfo.strIngredient4, right: drinkInfo.strMeasure4),
      Pair(left: drinkInfo.strIngredient5, right: drinkInfo.strMeasure5),
      Pair(left: drinkInfo.strIngredient6, right: drinkInfo.strMeasure6),
      Pair(left: drinkInfo.strIngredient7, right: drinkInfo.strMeasure7),
      Pair(left: drinkInfo.strIngredient8, right: drinkInfo.strMeasure8),
      Pair(left: drinkInfo.strIngredient9, right: drinkInfo.strMeasure9),
      Pair(left: drinkInfo.strIngredient10, right: drinkInfo.strMeasure10),
      Pair(left: drinkInfo.strIngredient11, right: drinkInfo.strMeasure11),
      Pair(left: drinkInfo.strIngredient12, right: drinkInfo.strMeasure12),
      Pair(left: drinkInfo.strIngredient13, right: drinkInfo.strMeasure13),
      Pair(left: drinkInfo.strIngredient14, right: drinkInfo.strMeasure14),
      Pair(left: drinkInfo.strIngredient15, right: drinkInfo.strMeasure15),
    ];

    return DrinkDetail(
        id: int.parse(drinkInfo.idDrink),
        instructions: drinkInfo.strInstructions,
        name: drinkInfo.strDrink,
        image: drinkInfo.strDrinkThumb,
        ingredients: ingredients
            .map((e) => e.toIngredient())
            .whereType<Ingredient>()
            .toList());
  }
}
