import 'package:drinks_flutter_app/domain/model/drink_list_item.dart';

class DrinkListItemWithBookmark extends DrinkListItem {
  final bool bookmark;

  const DrinkListItemWithBookmark(
      {required int id,
      required String name,
      required String image,
      required this.bookmark})
      : super(id: id, name: name, image: image);

  @override
  List<Object> get props => [id, name, image, bookmark];
}
