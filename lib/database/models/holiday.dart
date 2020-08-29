import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class Holiday {
  final String id, name, iconPath;
  Holiday({@required this.id, @required this.name, @required this.iconPath});
  ImageProvider<dynamic> get icon => AssetImage(this.iconPath);
}
