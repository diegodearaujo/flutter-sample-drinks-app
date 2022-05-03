import 'package:drinks_flutter_app/domain/model/drink_list_item_with_bookmark.dart';
import 'package:drinks_flutter_app/domain/repository/drink_repository.dart';
import 'package:drinks_flutter_app/domain/usecases/base_use_case.dart';

import '../model/bookmark.dart';
import '../model/drink_list_item.dart';
import '../util/resource.dart';

class GetDrinkListWithBookmarkUseCase implements BaseInputUseCase<String> {
  final DrinkRepository repository;

  GetDrinkListWithBookmarkUseCase(this.repository);

  List<DrinkListItem> _allDrinks = [];
  List<DrinkListItem> _searchedDrinks = [];
  String _lastSearch = "";

  @override
  Future<Resource<List<DrinkListItemWithBookmark>>> execute(
      String searchQuery) async {
    if (_allDrinks.isEmpty) {
      _allDrinks = await repository.getDrinkList();
      _searchedDrinks = _allDrinks;
    }
    if (searchQuery != _lastSearch) {
      _lastSearch = searchQuery;
      _searchedDrinks = _searchDrinks(searchQuery);
    }
    final bookmarks = await repository.getBookmarks();
    return Success<List<DrinkListItemWithBookmark>>(
        _mergeSearchedDrinksWithBookmarks(bookmarks));
  }

  List<DrinkListItem> _searchDrinks(String searchQuery) {
    if (searchQuery.isEmpty) {
      return _allDrinks;
    }
    return _allDrinks
        .where((element) => element.matchesSearch(searchQuery))
        .toList();
  }

  List<DrinkListItemWithBookmark> _mergeSearchedDrinksWithBookmarks(
      List<Bookmark> bookmarks) {
    final bookmarkSet = bookmarks.map((e) => e.drinkId).toSet();
    final res = _searchedDrinks
        .map((e) => DrinkListItemWithBookmark(
            bookmark: bookmarkSet.contains(e.id),
            id: e.id,
            name: e.name,
            image: e.image))
        .toList();
    res.sort((a, b) => a.name.compareTo(b.name));
    return res;
  }
}
