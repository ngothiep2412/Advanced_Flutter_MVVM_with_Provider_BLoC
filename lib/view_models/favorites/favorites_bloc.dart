import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<LoadFavorite>(_loadFavorites);
    on<AddToFavorite>(_addToFavorites);
    on<RemoveFromFavorites>(_removeFromFavorite);
    on<RemoveAllFromFavorites>(_clearAllFavorite);
  }

  final favoritesKey = 'favoritesKey';

  Future<void> _saveFavorites(List<MovieModel> favoritesList) async {
    final preferences = await SharedPreferences.getInstance();

    final stringList =
        favoritesList.map((movie) => jsonEncode(movie.toJson())).toList();

    preferences.setStringList(favoritesKey, stringList);
  }

  // bool _isFavorite(MovieModel movieModel) {
  //   if (state is FavoritesLoaded) {
  //     return (state as FavoritesLoaded)
  //         .favorites
  //         .any((movie) => movie.id == movieModel.id);
  //   }
  //   return false;
  // }

  Future<void> _addToFavorites(AddToFavorite event, emit) async {
    if (state is FavoritesLoaded) {
      List<MovieModel> updatedFavorites =
          List.from((state as FavoritesLoaded).favorites)
            ..add(event.movieModel);

      log('add ${updatedFavorites.length}');

      emit(FavoritesLoaded(favorites: updatedFavorites));

      await _saveFavorites(updatedFavorites);
    }
  }

  Future<void> _removeFromFavorite(RemoveFromFavorites event, emit) async {
    if (state is FavoritesLoaded) {
      List<MovieModel> updatedFavorites = (state as FavoritesLoaded)
          .favorites
          .where((movie) => movie.id != event.movieModel.id)
          .toList();

      log('remove ${updatedFavorites.length}');

      emit(FavoritesLoaded(favorites: updatedFavorites));

      await _saveFavorites(updatedFavorites);
    }
  }

  Future<void> _loadFavorites(event, emit) async {
    final preferences = await SharedPreferences.getInstance();

    final stringList = preferences.getStringList(favoritesKey) ?? [];

    final favoritesList = stringList
        .map((movie) => MovieModel.fromJson(json.decode(movie)))
        .toList();

    emit(FavoritesLoaded(favorites: favoritesList));
  }

  void _clearAllFavorite(event, emit) {
    emit(const FavoritesLoaded(favorites: []));

    _saveFavorites([]);
  }
}
