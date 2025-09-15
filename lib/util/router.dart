import 'package:flutter/material.dart';
import 'package:high_bee/infra/providers/handler_authenticate.dart';  
import 'package:high_bee/views/home/home.dart';
import 'package:high_bee/views/loading/loading.dart';
import 'package:high_bee/views/login/login.dart';
import 'package:high_bee/views/post/demonstration_post.dart';
import 'package:high_bee/views/post/post.dart';
import 'package:high_bee/views/profile/profile.dart';
import 'package:high_bee/views/recovery/recovery.dart';
import 'package:high_bee/views/training/training.dart';
import 'package:high_bee/views/wecolme/welcome.dart';
import 'package:high_bee/views/post/images_post.dart';
import 'package:high_bee/views/rules/rules.dart';
import 'package:high_bee/views/validation/validation.dart';
import 'package:high_bee/views/register/register.dart'; 

class MSRouter {
  static Map<String, Widget Function(BuildContext)> routes() => {
    DemonstrationPostPage.routeName: (context) => const DemonstrationPostPage(),
 
    HomePage.routeName: (context) => const HomePage(),

    ImagePostPage.routeName: (context) => const ImagePostPage(),

    LoadingPage.routeName: (context) => const LoadingPage(),

    LoginPage.routeName: (context) => const LoginPage(),

    PostPage.routeName: (context) => const PostPage(),

    ProfilePage.routeName: (context) => const ProfilePage(),

    RecoveryPage.routeName: (context) => const RecoveryPage(),

    RegisterPage.routeName: (context) => const RegisterPage(),

    RulesPage.routeName: (context) => const RulesPage(),

    TrainingPage.routeName: (context) => const TrainingPage(),

    ValidationDatas.routeName: (context) => const ValidationDatas(),

    WelcomePage.routeName: (context) => const WelcomePage(),
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
