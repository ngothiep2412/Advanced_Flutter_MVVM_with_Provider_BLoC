import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_app_icons.dart';
import 'package:mvvm_statemanagements/screens/movies_detail_screen.dart';
import 'package:mvvm_statemanagements/services/init_getIt.dart';
import 'package:mvvm_statemanagements/services/navigation_service.dart';
import 'package:mvvm_statemanagements/widgets/movies/favorite_btn.dart';
import 'package:mvvm_statemanagements/widgets/movies/movies_widget.dart';

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
              getIt<NavigationService>().showSnackbar();
              // getIt<NavigationService>().showDialog(FavoriteBtnWidget());
              // getIt<NavigationService>().navigate(const MoviesDetailScreen());
            },
            icon: const Icon(MyAppIcons.favoriteRounded),
            color: Colors.red,
          ),
          IconButton(
            onPressed: () {},
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
