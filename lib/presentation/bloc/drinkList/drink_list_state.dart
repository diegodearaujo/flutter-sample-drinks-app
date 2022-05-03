part of 'drink_list_bloc.dart';

class DrinkListState extends Equatable {
  const DrinkListState(
      {this.status = Status.loading,
      this.drinks = const <DrinkListItemWithBookmark>[],
      this.error,
      this.searchParameter = emptySearch});

  final Status status;
  final List<DrinkListItemWithBookmark> drinks;
  final CustomError? error;
  final String searchParameter;

  DrinkListState copyWith(
      {Status? status,
      List<DrinkListItemWithBookmark>? drinks,
      CustomError? error,
      String? searchParameter}) {
    return DrinkListState(
        searchParameter: searchParameter ?? this.searchParameter,
        status: status ?? this.status,
        drinks: drinks ?? this.drinks,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [status, drinks, error];
}
