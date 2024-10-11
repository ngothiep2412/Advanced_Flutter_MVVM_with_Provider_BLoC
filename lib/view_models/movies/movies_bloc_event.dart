part of 'movies_bloc_bloc.dart';

sealed class MoviesBlocEvent extends Equatable {
  const MoviesBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchMoviesEvent extends MoviesBlocEvent {}

class FetchMoreMoviesEvent extends MoviesBlocEvent {}
