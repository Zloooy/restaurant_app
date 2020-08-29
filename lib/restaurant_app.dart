import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/themes/theme_bloc.dart';
import 'package:restaurant_app/ui/routing/routes.dart';
import 'package:restaurant_app/utils/dp_extension/index.dart';

class RestaurantApp extends StatefulWidget {
  @override
  _RestaurantAppState createState() => new _RestaurantAppState();
}

class _RestaurantAppState extends State<RestaurantApp> {
  final ThemeBloc _themeBloc = ThemeBloc();
  @override
  Widget build(BuildContext context) {
    DpExtension(WidgetsBinding.instance.window);
    return StreamBuilder<ThemeData>(
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
