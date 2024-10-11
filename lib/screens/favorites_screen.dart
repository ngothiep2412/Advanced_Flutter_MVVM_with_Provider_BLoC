import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/view_models/favorites/favorites_bloc.dart';
import 'package:mvvm_statemanagements/widgets/my_error_widget.dart';

import '../constants/my_app_icons.dart';
import '../widgets/movies/movies_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Movies"),
        actions: [
          IconButton(
            onPressed: () {
              getIt<FavoritesBloc>().add(RemoveAllFromFavorites());
            },
            icon: const Icon(
              MyAppIcons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body:
          BlocBuilder<FavoritesBloc, FavoritesState>(builder: (context, state) {
        if (state is FavoritesLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is FavoritesError) {
          return MyErrorWidget(
            errorText: state.message,
            retryFunction: () {
              getIt<FavoritesBloc>().add(LoadFavorite());
            },
          );
        } else if (state is FavoritesLoaded && (state).favorites.isNotEmpty) {
          return ListView.builder(
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              return MoviesWidget(movieModel: state.favorites[index]);
            },
          );
        }
        return const Center(
          child: Text('No data available'),
        );
      }),
    );
  }
}
