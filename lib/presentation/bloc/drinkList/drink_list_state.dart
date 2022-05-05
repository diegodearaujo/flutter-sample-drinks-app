part of 'drink_list_bloc.dart';

class DrinkListState extends BaseState {
  const DrinkListState(
      {required this.drinks,
      required this.searchParameter,
      required Status status,
      Failure? error})
      : super(status: status, error: error);

  final List<DrinkListItemWithBookmark> drinks;
  final String searchParameter;

  DrinkListState copyWith(
      {Status? status,
      List<DrinkListItemWithBookmark>? drinks,
      Failure? error,
      String? searchParameter}) {
    return DrinkListState(
        searchParameter: searchParameter ?? this.searchParameter,
        status: status ?? this.status,
        drinks: drinks ?? this.drinks,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [status, drinks, searchParameter, error];
}
