import 'package:drinks_flutter_app/domain/model/bookmark.dart';

import '../model/drink_detail.dart';
import '../model/drink_list_item.dart';

abstract class DrinkRepository {
  Future<List<DrinkListItem>> getDrinkList();

  Future<DrinkDetail> getDrinkDetail();

  Future<List<Bookmark>> getBookmarks();

  Future<void> addBookmark(int drinkId);

  Future<void> removeBookmark(int drinkId);
}
