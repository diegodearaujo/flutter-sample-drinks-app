import 'package:json_annotation/json_annotation.dart';

import '../../domain/model/drink_list_item.dart';

part 'api_drink_list.g.dart';

@JsonSerializable()
class APIDrinkList {
  final List<DrinkListDetail> drinks;

  APIDrinkList({required this.drinks});

  factory APIDrinkList.fromJson(Map<String, dynamic> json) =>
      _$APIDrinkListFromJson(json);

  Map<String, dynamic> toJson() => _$APIDrinkListToJson(this);
}

@JsonSerializable()
class DrinkListDetail {
  final String idDrink;
  final String strDrink;
  final String strDrinkThumb;

  DrinkListDetail(
      {required this.idDrink,
      required this.strDrink,
      required this.strDrinkThumb});

  factory DrinkListDetail.fromJson(Map<String, dynamic> json) =>
      _$DrinkListDetailFromJson(json);

  Map<String, dynamic> toJson() => _$DrinkListDetailToJson(this);
}

extension Mapper on APIDrinkList {
  List<DrinkListItem> toDomain() {
    return drinks
        .map((e) => DrinkListItem(
            id: int.parse(e.idDrink), name: e.strDrink, image: e.strDrinkThumb))
        .toList();
  }
}
