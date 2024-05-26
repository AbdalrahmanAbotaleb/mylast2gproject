import 'package:flutter/material.dart';

class ChangeTheme with ChangeNotifier {
  ThemeMode theme = ThemeMode.system;

  changeTheme(ThemeMode theme) {
    this.theme = theme;
   
    notifyListeners();
  }
}
