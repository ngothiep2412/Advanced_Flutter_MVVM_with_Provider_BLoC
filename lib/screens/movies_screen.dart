import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_app_icons.dart';
import 'package:mvvm_statemanagements/models/movies_genre.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/repository/movies_repository.dart';
import 'package:mvvm_statemanagements/services/init_getIt.dart';
import 'package:mvvm_statemanagements/services/navigation_service.dart';
import 'package:mvvm_statemanagements/widgets/movies/movies_widget.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final List<MovieModel> _movies = [];
  int _currentPage = 1;
  bool _isFetching = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchMovies();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isFetching) {
      _fetchMovies();
    }
  }

  Future<void> _fetchMovies() async {
    try {
      if (_isFetching) return;

      setState(() {
        _isFetching = true;
      });
      final List<MovieModel> movies =
          await getIt<MoviesRepository>().fetchMovies(page: _currentPage);
      setState(() {
        _movies.addAll(movies);
        _currentPage++;
      });
    } catch (error) {
      getIt<NavigationService>()
          .showSnackbar('An Error has been occurred $error');
    } finally {
      setState(() {
        _isFetching = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

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
              // getIt<NavigationService>().navigate(const MoviesDetailScreen(movieModel: _movies[index],));
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
        itemCount: _movies.length + (_isFetching ? 1 : 0),
        controller: _scrollController,
        itemBuilder: (context, index) {
          if (index < _movies.length) {
            return MoviesWidget(
              movieModel: _movies[index],
            );
          } else {
            return const CircularProgressIndicator.adaptive();
          }
        },
      ),
    );
  }
}
