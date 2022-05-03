import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drinks_flutter_app/domain/model/drink_list_item_with_bookmark.dart';
import 'package:drinks_flutter_app/domain/usecases/drink_list_interactor.dart';
import 'package:drinks_flutter_app/domain/util/custom_error.dart';
import 'package:drinks_flutter_app/presentation/pages/utils/constants.dart';
import 'package:equatable/equatable.dart';

import '../base/base_block.dart';

part 'drink_list_event.dart';
part 'drink_list_state.dart';

class DrinkListBloc extends Bloc<DrinkListEvent, DrinkListState> {
  final DrinkListInteractor drinkListInteractor;

  DrinkListBloc(this.drinkListInteractor) : super(const DrinkListState()) {
    on<GetDrinks>(_onGetDrinks);
    on<AddBookmark>(_onAddBookmark);
    on<SearchUpdated>(_onSearchDrinks);
  }

  Future<void> _onGetDrinks(
      GetDrinks event, Emitter<DrinkListState> emit) async {
    try {
      final res = await drinkListInteractor.getDrinkList(state.searchParameter);
      res.checkResource(onSuccess: (data) {
        emit(state.copyWith(status: Status.success, drinks: data));
      }, onFailure: (error) {
        emit(state.copyWith(status: Status.failure, error: error));
      });
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onSearchDrinks(
      SearchUpdated event, Emitter<DrinkListState> emit) async {
    try {
      final res = await drinkListInteractor.getDrinkList(event.searchQuery);
      res.checkResource(onSuccess: (data) {
        emit(state.copyWith(
            status: Status.success,
            drinks: data,
            searchParameter: event.searchQuery));
      }, onFailure: (error) {
        emit(state.copyWith(
            status: Status.failure,
            error: error,
            searchParameter: event.searchQuery));
      });
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onAddBookmark(
      AddBookmark event, Emitter<DrinkListState> emit) async {
    try {
      final res;
      if (event.add) {
        res = await drinkListInteractor.addBookmark(event.drinkId);
      } else {
        res = await drinkListInteractor.removeBookmark(event.drinkId);
      }
      res.checkResource(onSuccess: (data) {
        print(data.toString());
        emit(state.copyWith(status: Status.success, drinks: data));
      }, onFailure: (error) {
        emit(state.copyWith(status: Status.failure, error: error));
      });
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }
}
