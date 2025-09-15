import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart'; 
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/util/router.dart';

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
    await Future.delayed(const Duration(microseconds: 2000));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate, 
      ],
      title: 'High Bee',
      locale: const Locale('pt', 'BR'),
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: PrimaryColors.carvaoColor,
          selectionColor: PrimaryColors.highBeeColor,
          selectionHandleColor: Colors.amber,
        ),
      ),
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      supportedLocales: const [Locale('en', 'pt-BR')],
      routes: MSRouter.routes(),
      onGenerateRoute: (RouteSettings routeSettings) =>
          MSRouter.onGenerateRoute(routeSettings),
    );
  }
}
