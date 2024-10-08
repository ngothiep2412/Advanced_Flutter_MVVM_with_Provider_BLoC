import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_theme_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeMode = MyThemeData.lightTheme;
  ThemeData get themeData => _themeMode;

  final String themeKey = 'isDarkMode';

  ThemeProvider() {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final preferences = await SharedPreferences.getInstance();

    final isDarkMode = preferences.getBool(themeKey) ?? false;

    _themeMode = isDarkMode ? MyThemeData.darkTheme : MyThemeData.lightTheme;

    notifyListeners();
  }

  Future<void> toggleTheme() async {
    final preferences = await SharedPreferences.getInstance();

    _themeMode = _themeMode == MyThemeData.darkTheme
        ? MyThemeData.lightTheme
        : MyThemeData.darkTheme;

    preferences.setBool(themeKey, _themeMode == MyThemeData.darkTheme);

    notifyListeners();
  }
}
