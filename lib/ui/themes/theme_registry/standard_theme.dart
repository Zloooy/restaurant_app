import "package:flutter/material.dart";
//Maybe later import "../theme_constants.dart";

final ThemeData standardTheme = ThemeData(
    brightness: Brightness.light,
    accentColor: Colors.orange,
    primaryColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.orange,
    ),
    buttonTheme:
        ButtonThemeData(buttonColor: Colors.white, shape: CircleBorder())
    /*TODO if needed
		textTheme: TextTheme(
			headline1: TextStyle(...)
		)
		*/
    );
