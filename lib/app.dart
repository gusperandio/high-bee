import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:high_bee/router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    print("Initializing app...");
    await Future.delayed(const Duration(microseconds: 2500));
    print("End splash...");
    FlutterNativeSplash
        .remove(); // Remove the splash screen after initialization
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      supportedLocales: const [Locale('en', 'pt-BR')],
      routes: MSRouter.routes(),
      onGenerateRoute: (RouteSettings routeSettings) =>
          MSRouter.onGenerateRoute(routeSettings),
    );
  }
}
