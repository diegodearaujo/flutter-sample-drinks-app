import 'package:drinks_flutter_app/domain/model/drink_detail.dart';
import 'package:drinks_flutter_app/domain/repository/drink_repository.dart';
import 'package:drinks_flutter_app/domain/usecases/base_use_case.dart';

import '../util/resource.dart';

class GetDrinkDetailUseCase implements BaseInputUseCase<String> {
  final DrinkRepository repository;

  GetDrinkDetailUseCase(this.repository);

  @override
  Future<Resource<DrinkDetail>> execute(String drinkId) {
    // TODO: implement execute
    throw UnimplementedError();
  }
}
