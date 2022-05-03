part of 'drink_list_bloc.dart';

abstract class DrinkListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDrinks extends DrinkListEvent {}

class AddBookmark extends DrinkListEvent {
  AddBookmark(this.add, {required this.drinkId});

  final int drinkId;
  final bool add;
}

class SearchUpdated extends DrinkListEvent {
  SearchUpdated({required this.searchQuery});

  final String searchQuery;
}
