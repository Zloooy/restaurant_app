import 'package:meta/meta.dart';
import 'package:flutter/widgets.dart';
class Restaurant  
{
	String id;
	String name;
	String cuisine;
	String address;
	List<String> tags;
	List<String> holidayIds;
	double rating;
	final String mainImagePath;
	Restaurant({@required this.id,  @required this.name, @required this.cuisine, @required this.address, @required this.tags, @required this.mainImagePath, @required this.rating, this.holidayIds}){
		holidayIds??=[];
	}
	ImageProvider<dynamic> get mainImage => AssetImage(mainImagePath);
}
