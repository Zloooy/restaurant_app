import 'package:flutter/material.dart';
import '../theme_constants.dart';

final ThemeData standard_theme = ThemeData(
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
