import 'package:get_it/get_it.dart';
import 'package:mvvm_statemanagements/repository/movies_repository.dart';
import 'package:mvvm_statemanagements/services/api_service.dart';
import 'package:mvvm_statemanagements/services/navigation_service.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<MoviesRepository>(
      () => MoviesRepository(getIt<ApiService>()));
}
