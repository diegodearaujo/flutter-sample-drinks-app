part of 'drink_list_bloc.dart';

enum DrinkListStatus { initial, success, failure }

class DrinkListState extends Equatable {
  const DrinkListState(
      {this.status = DrinkListStatus.initial,
      this.drinks = const <DrinkListItemWithBookmark>[],
      this.error});

  final DrinkListStatus status;
  final List<DrinkListItemWithBookmark> drinks;
  final CustomError? error;

  DrinkListState copyWith(
      {DrinkListStatus? status,
      List<DrinkListItemWithBookmark>? drinks,
      CustomError? error}) {
    return DrinkListState(
        status: status ?? this.status,
        drinks: drinks ?? this.drinks,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [status, drinks, error];
}
