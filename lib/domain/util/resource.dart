import 'package:drinks_flutter_app/domain/util/custom_error.dart';

abstract class Resource<T> {
  final T data;

  Resource(this.data);

  void checkResource(
      {required void Function(T data) onSuccess,
      required void Function(CustomError error) onFailure}) {
    if (this is Success) {
      onSuccess(data);
    } else if (this is Failure) {
      onFailure(data as CustomError);
    }
  }
}

class Success<T> extends Resource<T> {
  Success(data) : super(data);
}

class Failure<CustomError> extends Resource<CustomError> {
  Failure(data) : super(data);
}
