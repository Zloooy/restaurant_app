import "package:flutter/widgets.dart";

class Account {
  static const String REGULAR_USER = "Пользователь",
      ADMIN = "Администратор",
      RESTAURANT_CREW = "Служащий ресторана";
  String id;
  String name;
  String role;
  String? avatarPath;
  Account(
      {required this.id,
      this.name = "Нет имени",
      this.role = Account.REGULAR_USER,
      this.avatarPath});
  ImageProvider<dynamic> get avatar => AssetImage(avatarPath!);
  String get roleName => role;
}
