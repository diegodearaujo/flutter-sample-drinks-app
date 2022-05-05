import 'package:drinks_flutter_app/domain/util/data_result.dart';
import 'package:equatable/equatable.dart';

import 'base_block.dart';

abstract class BaseState extends Equatable {
  final Status status;
  final Failure? error;

  const BaseState({
    required this.status,
    this.error,
  });
}
