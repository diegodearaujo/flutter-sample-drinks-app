import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drinks_flutter_app/domain/usecases/get_drink_detail_use_case.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/model/drink_detail.dart';

part 'drink_detail_event.dart';
part 'drink_detail_state.dart';

class DrinkDetailBloc extends Bloc<DrinkDetailEvent, DrinkDetailState> {
  final GetDrinkDetailUseCase useCase;

  DrinkDetailBloc(this.useCase) : super(const DrinkDetailState()) {
    on<DrinkDetailFetched>(_onDrinkDetailFetched);
    on<AddBookmark>(_onAddBookmark);
  }

  Future<void> _onDrinkDetailFetched(
      DrinkDetailFetched event, Emitter<DrinkDetailState> emit) async {}

  FutureOr<void> _onAddBookmark(
      AddBookmark event, Emitter<DrinkDetailState> emit) {}
}
