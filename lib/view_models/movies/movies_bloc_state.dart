part of 'movies_bloc_bloc.dart';

sealed class MoviesBlocState extends Equatable {
  const MoviesBlocState();

  @override
  List<Object> get props => [];
}

final class MoviesInitial extends MoviesBlocState {}

final class MoviesLoadingState extends MoviesBlocState {}

final class MoviesLoadedState extends MoviesBlocState {
  final List<MovieModel> movies;
  final List<MoviesGenre> genres;
  final int currentPage;

  const MoviesLoadedState({
    this.movies = const [],
    this.genres = const [],
    this.currentPage = 0,
  });

  @override
  List<Object> get props => [movies, genres, currentPage];
}

final class MoviesLoadingMoreState extends MoviesBlocState {
  final List<MovieModel> movies;
  final List<MoviesGenre> genres;
  final int currentPage;

  const MoviesLoadingMoreState({
    this.movies = const [],
    this.genres = const [],
    this.currentPage = 0,
  });

  @override
  List<Object> get props => [movies, genres, currentPage];
}

final class MoviesErrorState extends MoviesBlocState {
  final String message;

  const MoviesErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
