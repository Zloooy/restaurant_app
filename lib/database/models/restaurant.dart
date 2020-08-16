import 'package:meta/meta.dart';
import 'package:flutter/widgets.dart';
class Restaurant  
{
	String id;
	String name;
	String address;
	final String mainImagePath;
	List<String> tags;
	Restaurant({@required this.id,  @required this.name, @required this.address, @required this.tags, @required this.mainImagePath});
	ImageProvider<dynamic> get mainImage => AssetImage(mainImagePath);
}
