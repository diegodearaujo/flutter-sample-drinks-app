import 'package:drinks_flutter_app/domain/repository/drink_repository.dart';
import 'package:drinks_flutter_app/domain/usecases/base_use_case.dart';
import 'package:drinks_flutter_app/domain/util/data_result.dart';

class AddBookmarkUseCase implements BaseInputUseCase<int> {
  final DrinkRepository drinkRepository;

  AddBookmarkUseCase(this.drinkRepository);

  @override
  Future<DataResult<void>> execute(int drinkId) async {
    await drinkRepository.addBookmark(drinkId);
    return (DataResult.success(null));
  }
}

class RemoveBookmarkUseCase implements BaseInputUseCase<int> {
  final DrinkRepository drinkRepository;

  RemoveBookmarkUseCase(this.drinkRepository);

  @override
  Future<DataResult<void>> execute(int drinkId) async {
    await drinkRepository.removeBookmark(drinkId);
    return (DataResult.success(null));
  }
}
