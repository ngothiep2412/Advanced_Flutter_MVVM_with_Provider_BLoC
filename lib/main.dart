import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mvvm_statemanagements/constants/my_theme_data.dart';
import 'package:mvvm_statemanagements/screens/splash_screen.dart';
import 'package:mvvm_statemanagements/view_models/favorites/favorites_bloc.dart';
import 'package:mvvm_statemanagements/view_models/movies/movies_bloc_bloc.dart';
import 'package:mvvm_statemanagements/view_models/theme/theme_bloc.dart';
import 'service/init_getit.dart';
import 'service/navigation_service.dart';

void main() {
  setupLocator(); // Initialize GetIt
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.landscapeRight,
  ]).then((_) async {
    await dotenv.load(fileName: "assets/.env");
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ThemeBloc>()..add(LoadThemeEvent()),
        ),
        BlocProvider(
          create: (_) => getIt<MoviesBlocBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<FavoritesBloc>(),
        )
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: getIt<NavigationService>().navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Movies App',
            theme: state is LightThemeState
                ? MyThemeData.lightTheme
                : MyThemeData.darkTheme,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
