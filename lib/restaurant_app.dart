import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/screens/auth/auth_screen.dart';
import 'package:restaurant_app/ui/screens/landing/landing_screen.dart';
import 'package:restaurant_app/ui/screens/main_menu/main_menu_screen.dart';
import 'package:restaurant_app/ui/themes/theme_bloc.dart';
class RestaurantApp extends StatelessWidget
{
	final ThemeBloc _theme_bloc = ThemeBloc();
	@override
	Widget build(BuildContext context)
	{
		return StreamBuilder<ThemeData>(
				stream:_theme_bloc.theme_stream,
				builder: (context, snapshot) => MaterialApp(
						home:new LandingScreen(),
						theme:snapshot.data
						)
		);
	}
}
