import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_app_icons.dart';
import 'package:mvvm_statemanagements/models/movies_genre.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/repository/movies_repository.dart';
import 'package:mvvm_statemanagements/services/api_service.dart';
import 'package:mvvm_statemanagements/services/init_getIt.dart';
import 'package:mvvm_statemanagements/services/navigation_service.dart';
import 'package:mvvm_statemanagements/widgets/movies/movies_widget.dart';

import 'movies_detail_screen.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
        actions: [
          IconButton(
            onPressed: () {
              // getIt<NavigationService>().showSnackbar();
              // getIt<NavigationService>().showDialog(FavoriteBtnWidget());
              getIt<NavigationService>().navigate(const MoviesDetailScreen());
            },
            icon: const Icon(MyAppIcons.favoriteRounded),
            color: Colors.red,
          ),
          IconButton(
            onPressed: () async {
              // final List<MovieModel> movies =
              //     await getIt<ApiService>().fetchMovies();
              // log('movies $movies');

              // final List<MoviesGenre> genres =
              //     await getIt<ApiService>().fetchGenres();
              final List<MoviesGenre> genres =
                  await getIt<MoviesRepository>().fetchGenres();
              log('genres $genres');
            },
            icon: const Icon(
              MyAppIcons.darkMode,
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const MoviesWidget();
        },
      ),
    );
  }
}
