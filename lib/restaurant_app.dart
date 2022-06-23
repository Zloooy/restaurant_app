import "package:flutter/material.dart";
import "package:restaurant_app/ui/themes/theme_bloc.dart";
import "package:restaurant_app/ui/routing/routes.dart";

class RestaurantApp extends StatefulWidget {
  RestaurantApp({Key? key}) : super(key: key);
  @override
  _RestaurantAppState createState() => _RestaurantAppState();
}

class _RestaurantAppState extends State<RestaurantApp> {
  final ThemeBloc _themeBloc = ThemeBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeData?>(
        stream: _themeBloc.themeStream,
        builder: (context, snapshot) => MaterialApp(
              theme: snapshot.data,
              initialRoute: RestaurantRouter.initialRoute,
              onGenerateRoute: RestaurantRouter.generateRoute,
            ));
  }

  @override
  void dispose() {
    super.dispose();
    _themeBloc.dispose();
  }
}
