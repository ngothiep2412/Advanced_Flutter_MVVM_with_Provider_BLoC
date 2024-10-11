import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/view_models/favorites/favorites_bloc.dart';

import '../../constants/my_app_icons.dart';

class FavoriteBtnWidget extends StatelessWidget {
  const FavoriteBtnWidget({super.key, required this.movieModel});

  final MovieModel movieModel;

  @override
  Widget build(BuildContext context) {
    final navigationService = getIt<NavigationService>();
    return BlocConsumer<FavoritesBloc, FavoritesState>(
        listener: (context, state) {
      if (state is FavoritesError) {
        navigationService.showSnackbar(state.message);
      }
    }, builder: (context, state) {
      bool isFavorite = (state is FavoritesLoaded) &&
          (state).favorites.any((movie) => movie.id == movieModel.id);
      return IconButton(
        onPressed: () {
          getIt<FavoritesBloc>().add(
            isFavorite
                ? RemoveFromFavorites(movieModel: movieModel)
                : AddToFavorite(movieModel: movieModel),
          );
        },
        icon: Icon(
          isFavorite ? MyAppIcons.favorite : MyAppIcons.favoriteOutlineRounded,
          color: isFavorite ? Colors.red : null,
          size: 20,
        ),
      );
    });
  }
}


// class FavoriteBtnWidget extends StatelessWidget {
//   const FavoriteBtnWidget({super.key, required this.movieModel});

//   final MovieModel movieModel;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<FavoritesBloc, FavoritesState>(
//         builder: (context, state) {
//       bool isFavorite = (state is FavoritesLoaded) &&
//           (state).favorites.any((movie) => movie.id == movieModel.id);
//       return IconButton(
//         onPressed: () {
//           getIt<FavoritesBloc>().add(isFavorite
//               ? RemoveFromFavorites(movieModel: movieModel)
//               : AddToFavorite(movieModel: movieModel));
//         },
//         icon: Icon(
//           isFavorite ? MyAppIcons.favorite : MyAppIcons.favoriteOutlineRounded,
//           color: isFavorite ? Colors.red : null,
//           size: 20,
//         ),
//       );
//     });
//   }
// }
