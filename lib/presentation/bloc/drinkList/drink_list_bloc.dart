import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drinks_flutter_app/domain/interactors/drink_list_interactor.dart';
import 'package:drinks_flutter_app/domain/model/drink_list_item_with_bookmark.dart';
import 'package:drinks_flutter_app/presentation/bloc/base/base_state.dart';
import 'package:drinks_flutter_app/presentation/pages/utils/constants.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/util/data_result.dart';
import '../base/base_block.dart';

part 'drink_list_event.dart';
part 'drink_list_state.dart';

class DrinkListBloc extends Bloc<DrinkListEvent, DrinkListState> {
  final DrinkListInteractor drinkListInteractor;

  DrinkListBloc(this.drinkListInteractor)
      : super(const DrinkListState(
            status: Status.loading, searchParameter: emptySearch, drinks: [])) {
    on<GetDrinks>(_onGetDrinks);
    on<DrinkListBookmarkEvent>(_onAddBookmark);
    on<SearchUpdated>(_onSearchDrinks);
  }

  Future<void> _onGetDrinks(
      GetDrinks event, Emitter<DrinkListState> emit) async {
    try {
      final res = await drinkListInteractor.getDrinkList(state.searchParameter);
      res.fold(
          (error) => emit(state.copyWith(status: Status.failure, error: error)),
          (data) => emit(state.copyWith(status: Status.success, drinks: data)));
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onSearchDrinks(
      SearchUpdated event, Emitter<DrinkListState> emit) async {
    try {
      final res = await drinkListInteractor.getDrinkList(event.searchQuery);
      res.fold(
          (error) => emit(state.copyWith(
              status: Status.failure,
              error: error,
              searchParameter: event.searchQuery)),
          (data) => emit(state.copyWith(
              status: Status.success,
              drinks: data,
              searchParameter: event.searchQuery)));
    } catch (e) {
      emit(state.copyWith(
          status: Status.failure, searchParameter: event.searchQuery));
    }
  }

  Future<void> _onAddBookmark(
      DrinkListBookmarkEvent event, Emitter<DrinkListState> emit) async {
    try {
      final DataResult<List<DrinkListItemWithBookmark>> res;
      if (event.add) {
        res = await drinkListInteractor.addBookmark(event.drinkId);
      } else {
        res = await drinkListInteractor.removeBookmark(event.drinkId);
      }
      res.fold(
          (error) => emit(state.copyWith(status: Status.failure, error: error)),
          (data) => emit(state.copyWith(status: Status.success, drinks: data)));
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }
}
