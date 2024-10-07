import 'package:mvvm_statemanagements/models/movies_genre.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/services/api_service.dart';

class MoviesRepository {
  final ApiService _apiService;

  MoviesRepository(this._apiService);

  Future<List<MovieModel>> fetchMovies({int page = 1}) async {
    return _apiService.fetchMovies(page: page);
  }

  List<MoviesGenre> cachedGenres = [];

  Future<List<MoviesGenre>> fetchGenres() async {
    return cachedGenres = await _apiService.fetchGenres();
  }
}
