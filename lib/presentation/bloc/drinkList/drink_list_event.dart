part of 'drink_list_bloc.dart';

abstract class DrinkListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DrinkListFetched extends DrinkListEvent {}

class SearchDrinks extends DrinkListEvent {
  SearchDrinks({required this.searchQuery});

  final String searchQuery;
}

class AddBookmark extends DrinkListEvent {
  AddBookmark({required this.drinkId});

  final int drinkId;
}

class RemoveBookmark extends DrinkListEvent {
  RemoveBookmark({required this.drinkId});

  final int drinkId;
}
