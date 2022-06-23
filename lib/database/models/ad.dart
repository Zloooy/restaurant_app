import "package:flutter/material.dart";

class Ad {
  final String id;
  final String imagePath;
  final String restaurantId;
  String description;
  String title;
  Ad(
      {required this.id,
      required this.restaurantId,
      required this.imagePath,
      this.description = "Нет описания.",
      this.title = "Реклама"});
  ImageProvider<dynamic> get image => AssetImage(imagePath);
}
