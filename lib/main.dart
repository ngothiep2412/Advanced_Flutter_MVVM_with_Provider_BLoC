import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mvvm_statemanagements/constants/my_theme_app.dart';
import 'package:mvvm_statemanagements/screens/movies_screen.dart';
import 'package:mvvm_statemanagements/services/init_getIt.dart';
import 'package:mvvm_statemanagements/services/navigation_service.dart';

Future<void> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    await dotenv.load(fileName: 'assets/.env');
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final navigatorKey = NavigationService().navigationKey; -- mỗi lần tạo sẽ tạo

    return MaterialApp(
      navigatorKey: getIt<NavigationService>().navigationKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: MyThemeApp.lightTheme,
      home: const MoviesScreen(),
    );
  }
}
