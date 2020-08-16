import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/screens/auth/auth_screen.dart';
import 'package:restaurant_app/ui/screens/main/main_screen.dart';
class RestaurantApp extends StatelessWidget
{
	@override
	Widget build(BuildContext context)
	{
		return MaterialApp(home:new MainScreen());
	}
}
