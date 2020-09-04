import "package:flutter/material.dart";
import "../screens/index.dart";
import "./route_names.dart";

MaterialPageRoute _route(Widget f(BuildContext context)) =>
    MaterialPageRoute(builder: f);
MaterialPageRoute _noContext(Widget f()) => _route((_) => f());

class RestaurantRouter {
  static final String initialRoute = main_menu_route;
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Route<dynamic> res;
    switch (settings.name) {
      case main_menu_route:
        res = _noContext(() => MainMenuScreen());
        break;
      case landing_route:
        print("redirecting to landing");
        res = _noContext(() => LandingScreen());
        break;
      case restaurant_list_route:
        print("restaurant_router: routing to restaurant list");
        Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
        res = _noContext(() => RestaurantListScreen(
            title: data[RestaurantListScreen.TITLE],
            queryCallback: data[RestaurantListScreen.QUERY_CALLBACK],
	    isClickable: data[RestaurantListScreen.IS_CLICKABLE] ?? false,
	    showSearchBar: data[RestaurantListScreen.SHOW_SEARCH_BAR] ?? false
	    ));
        break;
      case restaurant_details_route:
        Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
        res = _noContext(() => RestaurantDetailsScreen(
            restaurantId: data[RestaurantDetailsScreen.RESTAURANT_ID]
	    ));
        break;
	case meal_menu_route:
	Map<String,dynamic> data = settings.arguments as Map<String, dynamic>;
	res = _noContext(() => MealMenuScreen(
					restaurantId: data[MealMenuScreen.RESTAURANT_ID]
					));
	break;
      case ad_details_route:
	Map<String,dynamic> data = settings.arguments as Map<String, dynamic>;
	res = _noContext(()=>AdDetailsScreen(adId:data[AdDetailsScreen.AD_ID]));
	break;
      case kit_route:
	res = _noContext(()=>KitScreen());
	break;
      case cart_route:
	res = _noContext(()=>CartScreen());
	break;
      case account_route:
	res = _noContext(()=>AccountScreen());
	break;
      default:
        res = _noContext(() => LandingScreen());
        //TODO make 404 screen
        break;
    }
    print("restaurant router: route generated");
    return res;
  }
}
