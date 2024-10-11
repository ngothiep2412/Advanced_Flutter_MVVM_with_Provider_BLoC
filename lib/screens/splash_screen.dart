import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_statemanagements/screens/movies_screen.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/view_models/favorites/favorites_bloc.dart';
import 'package:mvvm_statemanagements/view_models/movies/movies_bloc_bloc.dart';

import '../widgets/my_error_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesBloc = getIt<MoviesBlocBloc>();
    final favoritesBloc = getIt<FavoritesBloc>();

    final navigationService = getIt<NavigationService>();

    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<MoviesBlocBloc, MoviesBlocState>(
            bloc: moviesBloc..add(FetchMoviesEvent()),
            listener: (context, state) {
              if (state is MoviesLoadedState &&
                  favoritesBloc.state is FavoritesLoaded) {
                navigationService.navigateReplace(const MoviesScreen());
              } else if (state is MoviesErrorState) {
                navigationService.showSnackbar(state.message);
              }
            },
          ),
          BlocListener<FavoritesBloc, FavoritesState>(
            bloc: favoritesBloc..add(LoadFavorite()),
            listener: (context, state) {
              if (state is FavoritesError) {
                navigationService.showSnackbar(state.message);
              }
            },
          )
        ],
        child: BlocBuilder<MoviesBlocBloc, MoviesBlocState>(
          bloc: moviesBloc..add(FetchMoviesEvent()),
          builder: (context, state) {
            if (state is MoviesLoadingState) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Loading..."),
                    SizedBox(height: 20),
                    CircularProgressIndicator.adaptive(),
                  ],
                ),
              );
            } else if (state is MoviesErrorState) {
              return MyErrorWidget(
                  errorText: '_errorMessage',
                  retryFunction: () {
                    moviesBloc.add(FetchMoviesEvent());
                  });
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
