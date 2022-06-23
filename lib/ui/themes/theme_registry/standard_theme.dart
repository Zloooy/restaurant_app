import "package:flutter/material.dart";
import "../theme_constants.dart";

final ThemeData standardTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.light().copyWith(
      primary: Colors.white,
      secondary: Colors.orange,
      onPrimary: Colors.black,
    ),
    iconTheme: IconThemeData(color: Colors.black),
    primaryIconTheme: IconThemeData(color: Colors.black),
    buttonTheme: ButtonThemeData(
      //buttonColor: Colors.white,
      shape: CircleBorder(),
      /*TODO if needed
		textTheme: TextTheme(
			headline1: TextStyle(...)
		)
		*/
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonStyle));
