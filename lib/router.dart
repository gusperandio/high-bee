import 'package:flutter/material.dart';
import 'package:high_bee/handler_authenticate.dart';
import 'package:high_bee/views/home/home.dart';
import 'package:high_bee/views/loading/loading_page.dart';
import 'package:high_bee/views/login/login.dart';
import 'package:high_bee/views/login/recovery_password.dart';
import 'package:high_bee/views/login/welcome.dart';
import 'package:high_bee/views/post/images_post.dart';
import 'package:high_bee/views/post/post_edit.dart';
import 'package:high_bee/views/post/title_post.dart';
import 'package:high_bee/views/register/rules.dart';
import 'package:high_bee/views/register/validation_datas.dart';
import 'package:high_bee/views/register/register.dart';

class MSRouter {
  static Map<String, Widget Function(BuildContext)> routes() => {
    HandlerAuthenticate.routeName: (context) => const HandlerAuthenticate(),
    WelcomePage.routeName: (context) => const WelcomePage(),
    HomePage.routeName: (context) => const HomePage(),
    LoginPage.routeName: (context) => const LoginPage(),
    RecoveryPasswordPage.routeName: (context) => const RecoveryPasswordPage(),
    RegisterPage.routeName: (context) => const RegisterPage(),
    ValidationDatas.routeName: (context) => const ValidationDatas(),
    RulesPage.routeName: (context) => const RulesPage(),
    LoadingPage.routeName: (context) => const LoadingPage(),
    TitlePostPage.routeName: (context) => const TitlePostPage(),
    ImagePostPage.routeName: (context) => const ImagePostPage(),
    PostEditPage.routeName: (context) => const PostEditPage(),
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
