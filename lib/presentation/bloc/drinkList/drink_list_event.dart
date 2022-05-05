part of 'drink_list_bloc.dart';

abstract class DrinkListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDrinks extends DrinkListEvent {}

class DrinkListBookmarkEvent extends DrinkListEvent {
  final int drinkId;
  final bool add;

  DrinkListBookmarkEvent({
    required this.drinkId,
    required this.add,
  });
}

class SearchUpdated extends DrinkListEvent {
  SearchUpdated({required this.searchQuery});

  final String searchQuery;
}
