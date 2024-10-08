import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/screens/movies_screen.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/view_models/favorites_provider.dart';
import 'package:mvvm_statemanagements/view_models/movies_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/my_error_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _loadInitialData(BuildContext context) async {
    Future.microtask(() async {
      if (!context.mounted) return;
      await Provider.of<MoviesProvider>(context, listen: false).getMovies();

      if (!context.mounted) return;
      await Provider.of<FavoritesProvider>(context, listen: false)
          .loadFavorites();
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await Provider.of<MoviesProvider>(context, listen: false).getMovies();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return Scaffold(
        body: FutureBuilder(
      future: _loadInitialData(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator.adaptive();
        } else if (snapshot.hasError) {
          if (moviesProvider.genresList.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                getIt<NavigationService>()
                    .navigateReplace(const MoviesScreen());
              },
            );
          }

          return Provider.of<MoviesProvider>(context).isLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : MyErrorWidget(
                  errorText: '_errorMessage',
                  retryFunction: () {
                    _loadInitialData(context);
                  },
                );
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            getIt<NavigationService>().navigateReplace(const MoviesScreen());
          });

          return const SizedBox.shrink();
        }
      },
    )
        // : MyErrorWidget(errorText: '_errorMessage', retryFunction: () {}),
        );
  }
}
