import 'package:flutter/material.dart';
import 'package:high_bee/handler_authenticate.dart';
import 'package:high_bee/views/home/home.dart';
import 'package:high_bee/views/welcome.dart';

class MSRouter {
  static Map<String, Widget Function(BuildContext)> routes() => {
     HandlerAuthenticate.routeName: (context) => const HandlerAuthenticate(),
     WelcomePage.routeName: (context) => const WelcomePage(),
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
