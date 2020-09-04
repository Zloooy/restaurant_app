import "package:flutter/material.dart";
class Kit
{
	String id;
	String title;
	String description;
	final List<String> mainImagePaths;
	Kit({@required this.id,
	@required this.title,
	this.description = "Нет описания",
	this.mainImagePaths = const []});
	List<ImageProvider<dynamic>> get mainImages => mainImagePaths.map(
			(path) => AssetImage(path)
			).toList();
}
