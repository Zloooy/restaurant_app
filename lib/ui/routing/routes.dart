import 'package:flutter/material.dart';
import '../screens/index.dart';
import './route_names.dart';
MaterialPageRoute _route(Widget f(BuildContext context)) => MaterialPageRoute(builder: f);
MaterialPageRoute _noContext(Widget f()) => _route((_)=>f());
class RestaurantRouter
{
	static final String initialRoute = landing_route;
	static Route<dynamic> generateRoute(RouteSettings settings)
	{
		Route<dynamic> res;
		switch (settings.name)
		{
			case landing_route:
				res = _noContext(()=>LandingScreen());
				break;
			case restaurant_list_route:
				print("restaurant_router: routing to restaurant list");
				Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
				res = _noContext(()=>RestaurantListScreen(
								title: data[RestaurantListScreen.TITLE],
								queryCallback: data[RestaurantListScreen.QUERY_CALLBACK]
								));
				break;
			default:
				res = _noContext(()=>LandingScreen());
				//TODO make 404 screen
				break;
		}
				print("restaurant router: route generated");
		return res;
	}
}
