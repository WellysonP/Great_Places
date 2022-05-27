import 'package:flutter/material.dart';

class ChangeTheme with ChangeNotifier {
  ThemeData themeData = ThemeData();

  bool get isDark => themeData.brightness == Brightness.dark;

  void changeTheme() {
    if (isDark) {
      themeData = ThemeData.light();
    } else {
      themeData = ThemeData.dark();
    }
    notifyListeners();
  }
}
