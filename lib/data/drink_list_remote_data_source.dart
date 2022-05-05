import 'dart:convert';

import 'package:http/http.dart' as http;

import 'data_constants.dart';
import 'model/api_drink_detail.dart';
import 'model/api_drink_list.dart';

abstract class DrinksRemoteDataSource {
  Future<APIDrinkList> getDrinks();

  Future<APIDrinkDetail> getDrinkDetail(int drinkId);
}

class DrinkListRemoteDataSourceImpl implements DrinksRemoteDataSource {
  @override
  Future<APIDrinkList> getDrinks() async {
    final response = await http.get(Uri.parse(DRINK_LIST));
    if (response.statusCode == 200) {
      return APIDrinkList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load drink list');
    }
  }

  @override
  Future<APIDrinkDetail> getDrinkDetail(int drinkId) async {
    final response =
        await http.get(Uri.parse(DRINK_DETAIL + drinkId.toString()));
    if (response.statusCode == 200) {
      return APIDrinkDetail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load drink detail');
    }
  }
}
