import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/screens/restaurant_list/restaurant_list_screen.dart';
import 'package:restaurant_app/ui/routing/route_names.dart';
import 'package:restaurant_app/database/models/index.dart';
class HolidayItem extends StatelessWidget
{
	final Holiday holiday;
	HolidayItem(this.holiday);
	@override
	Widget build(BuildContext context) => GestureDetector(
			onTap:(){
				print("HolidayItem tapped");
				Navigator.of(context).pushNamed(restaurant_list_route, arguments: {
				RestaurantListScreen.TITLE:holiday.name,
				RestaurantListScreen.QUERY_CALLBACK:(bloc)=>bloc.searchByHoliday(holiday)
			});
			},
			child: Card(
			child: Column(
					children: [
						Image(
								height:70,
								image: holiday.icon
								),
						Text(holiday.name)
					]
			)
			)
	);
}
