import 'package:get_it/get_it.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/view_models/favorites/favorites_bloc.dart';
import 'package:mvvm_statemanagements/view_models/movies/movies_bloc_bloc.dart';
import 'package:mvvm_statemanagements/view_models/theme/theme_bloc.dart';

import '../repository/movies_repo.dart';
import 'api_service.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<MoviesRepository>(
      () => MoviesRepository(getIt<ApiService>()));

  getIt.registerLazySingleton<ThemeBloc>(() => ThemeBloc());
  getIt.registerLazySingleton<MoviesBlocBloc>(() => MoviesBlocBloc());
  getIt.registerLazySingleton<FavoritesBloc>(() => FavoritesBloc());
}
