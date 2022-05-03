import 'package:bloc/bloc.dart';
import 'package:drinks_flutter_app/presentation/pages/drink_list_page.dart';
import 'package:flutter/material.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(MyApp()),
  );
}

class MyApp extends MaterialApp {
  MyApp() : super(home: DrinkListPage());
}
