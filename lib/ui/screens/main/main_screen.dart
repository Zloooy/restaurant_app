import 'package:flutter/material.dart';

//test imports TODO remove it
import './widgets/pages/restaurants/restaurant_search/restaurant_search.dart';
class MainScreen extends StatelessWidget
{
	@override
	Widget build(BuildContext context)=> Scaffold(
			body:Center(child:RestaurantSearch()));
}
