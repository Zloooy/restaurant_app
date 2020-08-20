import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart' show ThemeData;
import './theme_registry/index.dart';
class ThemeBloc
{
	static final ThemeBloc _instance = ThemeBloc._create();
	BehaviorSubject<ThemeData> _themeDataController;
	final BehaviorSubject<String> _themeNameController;
	Stream<ThemeData> _themeDataOutput;
	factory ThemeBloc()
	{
		return _instance;
	}
	ThemeBloc._create():
		_themeDataController = new BehaviorSubject<ThemeData>.seeded(DEFAULT_THEME),
		_themeNameController = new BehaviorSubject<String>()
	{
		_themeDataOutput = _themeDataController.mergeWith([_themeNameController.where(theme_dict.containsKey).distinct().map((theme_name)=>theme_dict[theme_name])]);
	}
	Stream<ThemeData> get theme_stream => _themeDataOutput;
	void setTheme(String theme_name) => _themeNameController.add(theme_name);
}
