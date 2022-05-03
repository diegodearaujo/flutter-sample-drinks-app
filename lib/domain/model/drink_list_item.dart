import 'package:equatable/equatable.dart';

class DrinkListItem extends Equatable {
  final int id;
  final String name;
  final String image;

  const DrinkListItem(
      {required this.id, required this.name, required this.image});

  @override
  List<Object> get props => [id, name, image];

  bool matchesSearch(String searchQuery) {
    return name.toLowerCase().contains(searchQuery.toLowerCase());
  }
}
