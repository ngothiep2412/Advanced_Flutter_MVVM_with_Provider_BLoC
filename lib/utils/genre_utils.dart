import 'package:mvvm_statemanagements/models/movies_genre.dart';
import 'package:mvvm_statemanagements/repository/movies_repository.dart';
import 'package:mvvm_statemanagements/services/init_getIt.dart';

class GenreUtils {
  static List<MoviesGenre> movieGenresNames(List<int> genreIds) {
    final movieRepository = getIt<MoviesRepository>();
    final cachedGenres = movieRepository.cachedGenres;

    List<MoviesGenre> genreNames = [];

    for (var genreId in genreIds) {
      MoviesGenre genre = cachedGenres.firstWhere((g) => g.id == genreId);
      genreNames.add(genre);
    }

    return genreNames;
  }
}
