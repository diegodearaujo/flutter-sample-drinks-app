class Bookmark {
  final int drinkId;
  final int timestamp;

  Bookmark(this.drinkId, this.timestamp);

  @override
  String toString() {
    return drinkId.toString();
  }
}
