part of 'drink_detail_bloc.dart';

abstract class DrinkDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDrinkDetail extends DrinkDetailEvent {
  final int drinkId;

  GetDrinkDetail({
    required this.drinkId,
  });
}

class DrinkDetailBookmarkEvent extends DrinkDetailEvent {
  final int drinkId;
  final bool add;

  DrinkDetailBookmarkEvent({
    required this.drinkId,
    required this.add,
  });
}
