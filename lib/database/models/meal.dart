import "package:meta/meta.dart";
import "package:flutter/widgets.dart";

class Meal {
  String id;
  String name;
  double price;
  String imagePath;
  Meal(
      {@required this.id,
      @required this.name,
      @required this.price,
      @required this.imagePath});
  ImageProvider<dynamic> get image => AssetImage(imagePath);
  @override
  bool operator==(Object other) => (other is Meal) && other.id ==id;
}
