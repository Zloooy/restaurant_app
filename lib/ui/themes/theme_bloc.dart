import "package:rxdart/rxdart.dart";
import "package:flutter/material.dart" show ThemeData;
import "./theme_registry/index.dart";

class ThemeBloc {
  static final ThemeBloc _instance = ThemeBloc._create();
  BehaviorSubject<ThemeData> _themeDataController;
  final BehaviorSubject<String> _themeNameController;
  Stream<ThemeData?>? _themeDataOutput;
  factory ThemeBloc() {
    return _instance;
  }
  ThemeBloc._create()
      : _themeDataController = BehaviorSubject<ThemeData>.seeded(defaultTheme),
        _themeNameController = BehaviorSubject<String>() {
    _themeDataOutput = _themeDataController.mergeWith([
      _themeNameController
          .where(themeDict.containsKey)
          .distinct()
          .map((themeName) => themeDict[themeName]!)
    ]);
  }
  Stream<ThemeData?>? get themeStream => _themeDataOutput;
  void setTheme(String themeName) => _themeNameController.add(themeName);
  void dispose() {
    _themeDataController.close();
    _themeNameController.close();
  }
}
