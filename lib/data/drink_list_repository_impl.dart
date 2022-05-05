import 'package:drinks_flutter_app/data/model/api_drink_detail.dart';
import 'package:drinks_flutter_app/domain/model/bookmark.dart';
import 'package:drinks_flutter_app/domain/model/drink_detail.dart';

import '../domain/model/drink_list_item.dart';
import '../domain/repository/drink_repository.dart';
import 'drink_list_remote_data_source.dart';
import 'model/api_drink_list.dart';

class DrinkListRepositoryImpl implements DrinkRepository {
  final DrinksRemoteDataSource remoteDataSource;

  DrinkListRepositoryImpl(this.remoteDataSource);

  final Map<int, Bookmark> _bookmarks = <int, Bookmark>{};

  @override
  Future<List<DrinkListItem>> getDrinkList() async {
    final res = await remoteDataSource.getDrinks();
    return res.toDomain();
  }

  @override
  Future<List<Bookmark>> getBookmarks() async {
    return _bookmarks.values.toList();
  }

  @override
  Future<void> addBookmark(int drinkId) async {
    _bookmarks[drinkId] =
        Bookmark(drinkId, DateTime.now().millisecondsSinceEpoch);
  }

  @override
  Future<void> removeBookmark(int drinkId) async {
    _bookmarks.remove(drinkId);
  }

  @override
  Future<DrinkDetail> getDrinkDetail(int drinkId) async {
    return (await remoteDataSource.getDrinkDetail(drinkId)).toDomain();
  }
}
