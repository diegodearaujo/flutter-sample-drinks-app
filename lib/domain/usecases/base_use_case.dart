import '../util/resource.dart';

abstract class BaseInputUseCase<Input> {
  Future<Resource> execute(Input input);
}

abstract class BaseOutputUseCase {
  Future<Resource> execute();
}
