import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drinks_flutter_app/domain/model/drink_detail_with_bookmark.dart';
import 'package:drinks_flutter_app/domain/util/data_result.dart';
import 'package:drinks_flutter_app/presentation/bloc/base/base_block.dart';
import 'package:drinks_flutter_app/presentation/bloc/base/base_state.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/interactors/drink_detail_interactor.dart';

part 'drink_detail_event.dart';
part 'drink_detail_state.dart';

class DrinkDetailBloc extends Bloc<DrinkDetailEvent, DrinkDetailState> {
  final DrinkDetailInteractor drinkDetailInteractor;

  DrinkDetailBloc(this.drinkDetailInteractor)
      : super(const DrinkDetailState(status: Status.loading)) {
    on<GetDrinkDetail>(_onGetDrinkDetail);
    on<DrinkDetailBookmarkEvent>(_onBookmark);
  }

  Future<void> _onGetDrinkDetail(
      GetDrinkDetail event, Emitter<DrinkDetailState> emit) async {
    final res = await drinkDetailInteractor.getDrinkDetail(event.drinkId);
    res.fold(
        (error) => emit(state.copyWith(status: Status.failure, error: error)),
        (data) => emit(state.copyWith(status: Status.success, drink: data)));
  }

  Future<void> _onBookmark(
      DrinkDetailBookmarkEvent event, Emitter<DrinkDetailState> emit) async {
    final DataResult<DrinkDetailWithBookmark> res;
    if (event.add) {
      res = await drinkDetailInteractor.addBookmark(event.drinkId);
    } else {
      res = await drinkDetailInteractor.removeBookmark(event.drinkId);
    }
    res.fold(
        (error) => emit(state.copyWith(status: Status.failure, error: error)),
        (data) => emit(state.copyWith(status: Status.success, drink: data)));
  }
}
