import 'package:drinks_flutter_app/domain/usecases/bookmark_use_case.dart';
import 'package:drinks_flutter_app/domain/usecases/get_drink_list_with_bookmarks_use_case.dart';

import '../model/drink_list_item_with_bookmark.dart';
import '../util/data_result.dart';

class DrinkListInteractor {
  final AddBookmarkUseCase _addBookmarkUseCase;
  final RemoveBookmarkUseCase _removeBookmarkUseCase;
  final GetDrinkListWithBookmarkUseCase _drinkListWithBookmarkUseCase;

  DrinkListInteractor(this._addBookmarkUseCase,
      this._drinkListWithBookmarkUseCase, this._removeBookmarkUseCase);

  String _searchQuery = "";

  Future<DataResult<List<DrinkListItemWithBookmark>>> getDrinkList(
      String searchQuery) {
    _searchQuery = searchQuery;
    return _drinkListWithBookmarkUseCase.execute(_searchQuery);
  }

  Future<DataResult<List<DrinkListItemWithBookmark>>> addBookmark(
      int drinkId) async {
    await _addBookmarkUseCase.execute(drinkId);
    return _drinkListWithBookmarkUseCase.execute(_searchQuery);
  }

  Future<DataResult<List<DrinkListItemWithBookmark>>> removeBookmark(
      int drinkId) async {
    await _removeBookmarkUseCase.execute(drinkId);
    return _drinkListWithBookmarkUseCase.execute(_searchQuery);
  }
}
