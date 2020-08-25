import 'package:meta/meta.dart';
import'package:flutter/material.dart';
class Ad
{
	final String imagePath;
	Ad({@required this.imagePath});
	ImageProvider<dynamic> get image => AssetImage(this.imagePath);
}
