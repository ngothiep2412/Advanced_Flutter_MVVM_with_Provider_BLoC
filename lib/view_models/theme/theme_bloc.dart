import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_theme_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<LoadThemeEvent>(_loadTheme);

    on<ToggleThemeEvent>(_toggleTheme);
  }

  final preferencesKey = 'isDarkMode';

  Future<void> _loadTheme(event, emit) async {
    final preferences = await SharedPreferences.getInstance();
    final isDarkMode = preferences.getBool(preferencesKey) ?? true;

    if (isDarkMode) {
      emit(
        DarkThemeState(themeData: MyThemeData.darkTheme),
      );
    } else {
      emit(
        LightThemeState(themeData: MyThemeData.lightTheme),
      );
    }
  }

  Future<void> _toggleTheme(event, emit) async {
    final preferences = await SharedPreferences.getInstance();

    final currentState = state;

    if (currentState is LightThemeState) {
      emit(
        DarkThemeState(themeData: MyThemeData.lightTheme),
      );
      await preferences.setBool(preferencesKey, true);
    } else {
      emit(
        LightThemeState(themeData: MyThemeData.darkTheme),
      );
      await preferences.setBool(preferencesKey, false);
    }
  }
}
