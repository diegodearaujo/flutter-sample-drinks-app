import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drinks_flutter_app/domain/model/drink_list_item_with_bookmark.dart';
import 'package:drinks_flutter_app/domain/usecases/drink_list_interactor.dart';
import 'package:drinks_flutter_app/domain/util/custom_error.dart';
import 'package:equatable/equatable.dart';

part 'drink_list_event.dart';

part 'drink_list_state.dart';

class DrinkListBloc extends Bloc<DrinkListEvent, DrinkListState> {
  final DrinkListInteractor drinkListInteractor;

  DrinkListBloc(this.drinkListInteractor) : super(const DrinkListState()) {
    on<DrinkListFetched>(_onDrinkListFetched);
    on<SearchDrinks>(_onSearchDrinks);
    on<AddBookmark>(_onAddBookmark);
    on<RemoveBookmark>(_onRemoveBookmark);
  }

  Future<void> _onDrinkListFetched(
      DrinkListFetched event, Emitter<DrinkListState> emit) async {
    try {
      final res = await drinkListInteractor.getDrinkList("");
      res.checkResource(onSuccess: (data) {
        emit(state.copyWith(status: DrinkListStatus.success, drinks: data));
      }, onFailure: (error) {
        emit(state.copyWith(status: DrinkListStatus.failure, error: error));
      });
    } catch (e) {
      emit(state.copyWith(status: DrinkListStatus.failure));
    }
  }

  Future<void> _onSearchDrinks(
      SearchDrinks event, Emitter<DrinkListState> emit) async {
    try {
      print("------------search:"+event.searchQuery+"--------");
      final res = await drinkListInteractor.getDrinkList(event.searchQuery);
      res.checkResource(onSuccess: (data) {
        emit(state.copyWith(status: DrinkListStatus.success, drinks: data));
      }, onFailure: (error) {
        emit(state.copyWith(status: DrinkListStatus.failure, error: error));
      });
    } catch (e) {
      emit(state.copyWith(status: DrinkListStatus.failure));
    }
  }

  Future<void> _onAddBookmark(
      AddBookmark event, Emitter<DrinkListState> emit) async {
    try {
      print("---------add");
      final res = await drinkListInteractor.addBookmark(event.drinkId);
      res.checkResource(onSuccess: (data) {
        print(data.toString());
        emit(state.copyWith(status: DrinkListStatus.success, drinks: data));
      }, onFailure: (error) {
        emit(state.copyWith(status: DrinkListStatus.failure, error: error));
      });
    } catch (e) {
      emit(state.copyWith(status: DrinkListStatus.failure));
    }
  }

  Future<void> _onRemoveBookmark(
      RemoveBookmark event, Emitter<DrinkListState> emit) async {
    try {
      print("---------remove");
      final res = await drinkListInteractor.removeBookmark(event.drinkId);
      res.checkResource(onSuccess: (data) {
        emit(state.copyWith(status: DrinkListStatus.success, drinks: data));
      }, onFailure: (error) {
        emit(state.copyWith(status: DrinkListStatus.failure, error: error));
      });
    } catch (e) {
      emit(state.copyWith(status: DrinkListStatus.failure));
    }
  }
}
