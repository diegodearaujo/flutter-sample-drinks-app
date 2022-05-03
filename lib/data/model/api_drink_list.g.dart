// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_drink_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIDrinkList _$APIDrinkListFromJson(Map<String, dynamic> json) => APIDrinkList(
      drinks: (json['drinks'] as List<dynamic>)
          .map((e) => DrinkListDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$APIDrinkListToJson(APIDrinkList instance) =>
    <String, dynamic>{
      'drinks': instance.drinks,
    };

DrinkListDetail _$DrinkListDetailFromJson(Map<String, dynamic> json) =>
    DrinkListDetail(
      idDrink: json['idDrink'] as String,
      strDrink: json['strDrink'] as String,
      strDrinkThumb: json['strDrinkThumb'] as String,
    );

Map<String, dynamic> _$DrinkListDetailToJson(DrinkListDetail instance) =>
    <String, dynamic>{
      'idDrink': instance.idDrink,
      'strDrink': instance.strDrink,
      'strDrinkThumb': instance.strDrinkThumb,
    };
