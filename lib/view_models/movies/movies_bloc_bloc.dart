import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mvvm_statemanagements/models/movies_genre.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/repository/movies_repo.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';

part 'movies_bloc_event.dart';
part 'movies_bloc_state.dart';

class MoviesBlocBloc extends Bloc<MoviesBlocEvent, MoviesBlocState> {
  MoviesBlocBloc() : super(MoviesInitial()) {
    on<FetchMoviesEvent>(_onFetchMovies);
    on<FetchMoreMoviesEvent>(_onFetchMoreMovies);
  }

  final MoviesRepository _moviesRepository = getIt<MoviesRepository>();
  Future<void> _onFetchMovies(event, emit) async {
    try {
      emit(MoviesLoadingState());

      var genres = await _moviesRepository.fetchGenres();

      log('genres length: ${genres.length}');

      var movies = await _moviesRepository.fetchMovies(page: 1);

      emit(
        MoviesLoadedState(
          currentPage: 1,
          genres: genres,
          movies: movies,
        ),
      );
    } catch (e) {
      emit(MoviesErrorState(message: 'Failed to load movies $e'));
    }
  }

  Future<void> _onFetchMoreMovies(event, emit) async {
    final currentState = state;

    if (currentState is MoviesLoadingMoreState) {
      return;
    }

    if (currentState is! MoviesLoadedState) {
      return;
    }

    emit(MoviesLoadingMoreState(
      currentPage: currentState.currentPage,
      genres: currentState.genres,
      movies: currentState.movies,
    ));

    try {
      List<MovieModel> movies = await _moviesRepository.fetchMovies(
          page: currentState.currentPage + 1);

      if (movies.isEmpty) {
        emit(currentState);
        return;
      }

      currentState.movies.addAll(movies);

      emit(MoviesLoadedState(
        currentPage: currentState.currentPage + 1,
        genres: currentState.genres,
        movies: currentState.movies,
      ));
    } catch (e) {
      emit(MoviesErrorState(message: 'Failed to load movies $e'));
    }
  }
}
