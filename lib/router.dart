import 'package:flutter/material.dart';
import 'package:high_bee/handler_authenticate.dart';
import 'package:high_bee/viewmodel/counter.dart';
import 'package:high_bee/viewmodel/loading/loading_view_model.dart';
import 'package:high_bee/viewmodel/login/login_view_model.dart';
import 'package:high_bee/viewmodel/recovery/recovery_view_model.dart';
import 'package:high_bee/viewmodel/register/register_view_model.dart';
import 'package:high_bee/viewmodel/rules/rules_view_model.dart';
import 'package:high_bee/viewmodel/validation/validation_view_model.dart';
import 'package:high_bee/views/counter/counter.dart';
import 'package:high_bee/views/home/home.dart';
import 'package:high_bee/views/loading/loading.dart';
import 'package:high_bee/views/login/login.dart';
import 'package:high_bee/views/recovery/recovery.dart';
import 'package:high_bee/views/wecolme/welcome.dart';
import 'package:high_bee/views/post/images_post.dart';
import 'package:high_bee/views/post/post_edit.dart';
import 'package:high_bee/views/post/title_post.dart';
import 'package:high_bee/views/rules/rules.dart';
import 'package:high_bee/views/validation/validation.dart';
import 'package:high_bee/views/register/register.dart';
import 'package:provider/provider.dart';

class MSRouter {
  static Map<String, Widget Function(BuildContext)> routes() => {
    HandlerAuthenticate.routeName: (context) => const HandlerAuthenticate(),
    WelcomePage.routeName: (context) => const WelcomePage(),
    HomePage.routeName: (context) => const HomePage(),
    LoginPage.routeName:
        (context) => ChangeNotifierProvider(
          create: (_) => LoginViewModel(),
          child: const LoginPage(),
        ),
    RecoveryPage.routeName:
        (context) => ChangeNotifierProvider(
          create: (_) => RecoveryViewModel(),
          child: const RecoveryPage(),
        ),
    RegisterPage.routeName:
        (context) => ChangeNotifierProvider(
          create: (_) => RegisterViewModel(),
          child: const RegisterPage(),
        ),
    ValidationDatas.routeName:
        (context) => ChangeNotifierProvider(
          create: (_) => ValidationViewModel(),
          child: const ValidationDatas(),
        ),
    RulesPage.routeName:
        (context) => ChangeNotifierProvider(
          create: (_) => RulesViewModel(),
          child: const RulesPage(),
        ),
    LoadingPage.routeName:
        (context) => ChangeNotifierProvider(
          create: (_) => LoadingViewModel(),
          child: const LoadingPage(),
        ),
    TitlePostPage.routeName: (context) => const TitlePostPage(),
    ImagePostPage.routeName: (context) => const ImagePostPage(),
    PostEditPage.routeName: (context) => const PostEditPage(),
    CounterView.routeName:
        (context) => ChangeNotifierProvider(
          create: (_) => CounterViewModel(),
          child: const CounterView(),
        ),
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
