part of 'drink_detail_bloc.dart';

abstract class DrinkDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DrinkDetailFetched extends DrinkDetailEvent {}

class AddBookmark extends DrinkDetailEvent {
  AddBookmark({required this.drinkId});

  final int drinkId;
}
