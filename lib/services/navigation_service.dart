import 'package:flutter/material.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigationKey;

  NavigationService() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  navigate(Widget widget) {
    return navigationKey.currentState?.push(
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  navigateReplace(Widget widget) {
    return navigationKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  Future<void> showDialog(Widget widget) async {
    await showAdaptiveDialog(
      barrierDismissible: true,
      context: navigationKey.currentContext!,
      builder: (context) => widget,
    );
  }

  void showSnackbar() {
    final context = navigationKey.currentContext!;
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    const snackbarWidget = SnackBar(
      content: Text(
        'Hello world - a movies app',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbarWidget);
  }
}
