import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider with ChangeNotifier {
  final List<MovieModel> _favoritesList = [];
  List<MovieModel> get favoritesList => _favoritesList;

  final favoriteKey = "favoriteKey";

  bool isFavorite(MovieModel movieModel) {
    return _favoritesList.any((movie) => movie.id == movieModel.id);
  }

  Future<void> addOrRemoveFavorites(MovieModel movieModel) async {
    if (isFavorite(movieModel)) {
      _favoritesList.removeWhere((movie) => movie.id == movieModel.id);
    } else {
      _favoritesList.add(movieModel);
    }
    await saveFavorites();
    notifyListeners();
  }

  Future<void> saveFavorites() async {
    final preferences = await SharedPreferences.getInstance();

    final stringList =
        _favoritesList.map((movie) => json.encode(movie.toJson())).toList();

    preferences.setStringList(favoriteKey, stringList);
  }

  Future<void> loadFavorites() async {
    final preferences = await SharedPreferences.getInstance();
    final stringList = preferences.getStringList(favoriteKey) ?? [];

    _favoritesList.clear();
    _favoritesList.addAll(
        stringList.map((movie) => MovieModel.fromJson(json.decode(movie))));
    notifyListeners();
  }

  void clearAllFavorite() {
    _favoritesList.clear();
    notifyListeners();
    saveFavorites();
  }
}
