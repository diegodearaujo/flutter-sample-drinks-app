import 'package:drinks_flutter_app/domain/model/drink_detail.dart';
import 'package:drinks_flutter_app/domain/model/drink_detail_with_bookmark.dart';
import 'package:drinks_flutter_app/domain/repository/drink_repository.dart';
import 'package:drinks_flutter_app/domain/usecases/base_use_case.dart';
import 'package:flutter/foundation.dart';

import '../util/data_result.dart';

class GetDrinkDetailWithBookmarkUseCase implements BaseInputUseCase<int> {
  final DrinkRepository repository;

  GetDrinkDetailWithBookmarkUseCase(this.repository);

  DrinkDetail? drinkDetail;

  @override
  Future<DataResult<DrinkDetailWithBookmark>> execute(int drinkId) async {
    try {
      drinkDetail ??= await repository.getDrinkDetail(drinkId);
      final bookmarks = await repository.getBookmarks();
      return DataResult.success(DrinkDetailWithBookmark.fromDrinkDetail(
          detail: drinkDetail!,
          isBookmark: bookmarks.any((element) => element.drinkId == drinkId)));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return DataResult.failure(e is Failure ? e : GenericFailure());
    }
  }
}
