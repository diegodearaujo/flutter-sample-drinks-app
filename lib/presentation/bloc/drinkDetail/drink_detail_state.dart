part of 'drink_detail_bloc.dart';

enum DrinkDetailStatus { initial, success, failure }

class DrinkDetailState extends Equatable {
  const DrinkDetailState({
    this.status = DrinkDetailStatus.initial,
    this.drink,
  });

  final DrinkDetailStatus status;
  final DrinkDetail? drink;

  DrinkDetailState copyWith({
    DrinkDetailStatus? status,
    DrinkDetail? drink,
  }) {
    return DrinkDetailState(
      status: status ?? this.status,
      drink: drink ?? this.drink,
    );
  }

  @override
  List<Object?> get props => [status, drink];
}

