import 'package:flutter/foundation.dart';

import '../model/drink_detail_with_bookmark.dart';
import '../usecases/bookmark_use_case.dart';
import '../usecases/get_drink_detail_with_bookmark_use_case.dart';
import '../util/data_result.dart';

class DrinkDetailInteractor {
  final AddBookmarkUseCase _addBookmarkUseCase;
  final RemoveBookmarkUseCase _removeBookmarkUseCase;
  final GetDrinkDetailWithBookmarkUseCase _drinkDetailWithBookmarkUseCase;

  const DrinkDetailInteractor({
    required AddBookmarkUseCase addBookmarkUseCase,
    required RemoveBookmarkUseCase removeBookmarkUseCase,
    required GetDrinkDetailWithBookmarkUseCase drinkDetailWithBookmarkUseCase,
  })  : _addBookmarkUseCase = addBookmarkUseCase,
        _removeBookmarkUseCase = removeBookmarkUseCase,
        _drinkDetailWithBookmarkUseCase = drinkDetailWithBookmarkUseCase;

  Future<DataResult<DrinkDetailWithBookmark>> addBookmark(int drinkId) async {
    try {
      (await _addBookmarkUseCase.execute(drinkId))
          .either((error) => throw GenericFailure(), (data) => {});
      return getDrinkDetail(drinkId);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return DataResult.failure(e is Failure ? e : GenericFailure());
    }
  }

  Future<DataResult<DrinkDetailWithBookmark>> removeBookmark(
      int drinkId) async {
    try {
      (await _removeBookmarkUseCase.execute(drinkId))
          .either((error) => throw GenericFailure(), (data) => {});
      return getDrinkDetail(drinkId);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return DataResult.failure(e is Failure ? e : GenericFailure());
    }
  }

  Future<DataResult<DrinkDetailWithBookmark>> getDrinkDetail(
      int drinkId) async {
    try {
      return await _drinkDetailWithBookmarkUseCase.execute(drinkId);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return DataResult.failure(e is Failure ? e : GenericFailure());
    }
  }
}
