import 'package:drinks_flutter_app/domain/util/custom_error.dart';

const String emptySearch = "";

extension StringMapper on CustomError {
  String toPresentation() {
    switch (this) {
      case CustomError.dataError:
        return "Data Error";
    }
  }
}
