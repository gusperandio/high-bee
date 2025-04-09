import 'package:flutter/material.dart';
import 'package:high_bee/handler_authenticate.dart';

class MSRouter {
  static Map<String, Widget Function(BuildContext)> routes() => {
     HandlerAuthenticate.routeName: (context) => const HandlerAuthenticate(),
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
