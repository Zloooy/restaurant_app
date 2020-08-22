import 'package:flutter/widgets.dart';
import 'package:restaurant_app/database/models/restaurant.dart';
import './restaurant_item.dart';
class RestaurantList extends StatelessWidget
{
	final List<Restaurant> _restaurants;
	RestaurantList(this._restaurants,{Key key}):super(key:key);
	@override
	Widget build(BuildContext context) => (_restaurants != null || _restaurants.length > 0) ? SliverList(
			delegate:SliverChildBuilderDelegate(
				(BuildContext context, int i) {
					print("restaurant list: building item $i");
					return RestaurantItem(_restaurants[i]);
				},
				childCount: _restaurants.length
					)
			) : SliverToBoxAdapter(child:
			Center(child:
					Text("No restaurants")));
}
/*
class _RestaurantListState extends State<RestaurantList>
{
	List<Restaurant> _restaurants = [];
	void setRestaurants(List<Restaurant> restaurants) =>
			setState(()=>_restaurants=restaurants);
}
*/
