part of 'drink_detail_bloc.dart';

class DrinkDetailState extends BaseState {
  final DrinkDetailWithBookmark? drink;

  const DrinkDetailState({this.drink, required Status status, Failure? error})
      : super(status: status, error: error);

  DrinkDetailState copyWith(
      {Status? status, DrinkDetailWithBookmark? drink, Failure? error}) {
    return DrinkDetailState(
        status: status ?? this.status,
        drink: drink ?? this.drink,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [status, drink, error];
}
