import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:high_bee/app.dart';
import 'package:high_bee/firebase_options.dart';
import 'package:high_bee/util/deep_link_handler.dart'; 
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //! Native Splash Screen
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);

  //! Dotenv Instance
  await dotenv.load(fileName: ".env");

  //! Deep Link Handler
  DeepLinkHandler().init();

  //! Firebase Initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //! Firebase Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  //! Catches errors outside Flutter
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await initializeDateFormatting(
    'pt_BR',
    null,
  ).then((_) => runApp(const riverpod.ProviderScope(child: MyApp())));
}
