import 'package:drinks_flutter_app/domain/util/data_result.dart';

abstract class BaseInputUseCase<Input> {
  Future<DataResult> execute(Input input);
}

abstract class BaseOutputUseCase {
  Future<DataResult> execute();
}
