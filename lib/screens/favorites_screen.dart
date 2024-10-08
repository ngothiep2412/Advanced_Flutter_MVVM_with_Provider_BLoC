import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/view_models/favorites_provider.dart';
import 'package:provider/provider.dart';
import '../constants/my_app_icons.dart';
import '../widgets/movies/movies_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Movies"),
        actions: [
          IconButton(
            onPressed: () {
              favoriteProvider.clearAllFavorite();
            },
            icon: const Icon(
              MyAppIcons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: favoriteProvider.favoritesList.isEmpty
          ? const Center(
              child: Text('No added Favorites'),
            )
          : ListView.builder(
              itemCount: favoriteProvider.favoritesList.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value:
                      favoriteProvider.favoritesList.reversed.toList()[index],
                  child: const MoviesWidget(),
                );
              },
            ),
    );
  }
}
