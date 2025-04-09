import 'package:flutter/material.dart';
import 'package:high_bee/handler_authenticate.dart';
import 'package:high_bee/views/home.dart';
import 'package:high_bee/views/login.dart';

class MSRouter {
  static Map<String, Widget Function(BuildContext)> routes() => {
     HandlerAuthenticate.routeName: (context) => const HandlerAuthenticate(),
     LoginPage.routeName: (context) => const LoginPage(),
     HomePage.routeName: (context) => const HomePage(),
  };

  static MaterialPageRoute onGenerateRoute(RouteSettings routeSettings) =>
      MaterialPageRoute<void>(
        settings: routeSettings,
        builder: (BuildContext context) {
          switch (routeSettings.name) {
            default:
              return const HandlerAuthenticate();
          }
        },
      );
}
