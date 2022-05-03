import 'dart:convert';

import 'package:http/http.dart' as http;

import 'data_constants.dart';
import 'model/api_drink_list.dart';

abstract class DrinkListRemoteDataSource {
  Future<APIDrinkList> getDrinks();
}

class DrinkListRemoteDataSourceImpl implements DrinkListRemoteDataSource {
  @override
  Future<APIDrinkList> getDrinks() async {
    final response = await http.get(Uri.parse(BASE_URL));
    if (response.statusCode == 200) {
      return APIDrinkList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load drink list');
    }
  }
}
