import "package:meta/meta.dart";
import "package:flutter/widgets.dart";
import "./meal.dart";

class Restaurant {
  String id;
  String name;
  String cuisine;
  String description;
  String address;
  List<String> tags;
  List<String> holidayIds;
  double rating;
  final String mainImagePath;
  List<Meal> _menu;
  Restaurant(
      {@required this.id,
      @required this.name,
      @required this.cuisine,
      @required this.address,
      @required this.tags,
      @required this.mainImagePath,
      @required this.rating,
      @required List<Meal> menu,
      this.holidayIds = const [],
      this.description = "Нет описания."})
      : _menu = menu;
  ImageProvider<dynamic> get mainImage => AssetImage(mainImagePath);
  List<Meal> get menu => _menu;
}
