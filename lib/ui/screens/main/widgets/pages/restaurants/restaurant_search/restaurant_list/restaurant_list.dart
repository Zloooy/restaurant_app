import 'package:flutter/widgets.dart';
import 'package:restaurant_app/database/models/restaurant.dart';
import './restaurant_item.dart';
class RestaurantList extends StatelessWidget
{
	final List<Restaurant> _restaurants;
	RestaurantList(this._restaurants,{Key key}):super(key:key);
	@override
	Widget build(BuildContext context) => SliverList(
			delegate:SliverChildBuilderDelegate(
				(BuildContext context, int i) =>
					(i<_restaurants.length) ? RestaurantItem(_restaurants[i]) : null
					)
			);
}
/*
class _RestaurantListState extends State<RestaurantList>
{
	List<Restaurant> _restaurants = [];
	void setRestaurants(List<Restaurant> restaurants) =>
			setState(()=>_restaurants=restaurants);
}
*/
