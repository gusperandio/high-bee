import 'package:flutter/material.dart';
import 'package:high_bee/handler_authenticate.dart';
import 'package:high_bee/viewmodel/counter.dart';
import 'package:high_bee/viewmodel/home/home_view_model.dart';
import 'package:high_bee/viewmodel/loading/loading_view_model.dart';
import 'package:high_bee/viewmodel/login/login_view_model.dart';
import 'package:high_bee/viewmodel/post/image_post_view_model.dart';
import 'package:high_bee/viewmodel/post/post_view_model.dart';
import 'package:high_bee/viewmodel/profile/profile_view_model.dart';
import 'package:high_bee/viewmodel/recovery/recovery_view_model.dart';
import 'package:high_bee/viewmodel/register/register_view_model.dart';
import 'package:high_bee/viewmodel/rules/rules_view_model.dart';
import 'package:high_bee/viewmodel/training/training_view_model.dart';
import 'package:high_bee/viewmodel/validation/validation_view_model.dart';
import 'package:high_bee/views/counter/counter.dart';
import 'package:high_bee/views/home/home.dart';
import 'package:high_bee/views/loading/loading.dart';
import 'package:high_bee/views/login/login.dart';
import 'package:high_bee/views/post/post.dart';
import 'package:high_bee/views/profile/profile.dart';
import 'package:high_bee/views/recovery/recovery.dart';
import 'package:high_bee/views/training/training.dart';
import 'package:high_bee/views/wecolme/welcome.dart';
import 'package:high_bee/views/post/images_post.dart';
import 'package:high_bee/views/rules/rules.dart';
import 'package:high_bee/views/validation/validation.dart';
import 'package:high_bee/views/register/register.dart';
import 'package:provider/provider.dart';

class MSRouter {
  static Map<String, Widget Function(BuildContext)> routes() => {
    CounterView.routeName:
        (context) => ChangeNotifierProvider(
          create: (_) => CounterViewModel(),
          child: const CounterView(),
        ),
    HandlerAuthenticate.routeName: (context) => const HandlerAuthenticate(),
    HomePage.routeName:
        (context) => ChangeNotifierProvider(
          create: (_) => HomeViewModel(),
          child: const HomePage(),
        ),
    ImagePostPage.routeName:
        (context) => ChangeNotifierProvider(
          create: (_) => ImagePostViewModel(),
          child: const ImagePostPage(),
        ),
    LoadingPage.routeName:
        (context) => ChangeNotifierProvider(
          create: (_) => LoadingViewModel(),
          child: const LoadingPage(),
        ),
    LoginPage.routeName:
        (context) => ChangeNotifierProvider(
          create: (_) => LoginViewModel(),
          child: const LoginPage(),
        ),
    PostPage.routeName:
        (context) => ChangeNotifierProvider(
          create: (_) => PostViewModel(),
          child: const PostPage(),
        ),
    ProfilePage.routeName:
        (context) => ChangeNotifierProvider(
          create: (_) => ProfileViewModel(),
          child: const ProfilePage(),
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
    RulesPage.routeName:
        (context) => ChangeNotifierProvider(
          create: (_) => RulesViewModel(),
          child: const RulesPage(),
        ),
    TrainingPage.routeName:
        (context) => ChangeNotifierProvider(
          create: (_) => TrainingViewModel(),
          child: const TrainingPage(),
        ),
    ValidationDatas.routeName:
        (context) => ChangeNotifierProvider(
          create: (_) => ValidationViewModel(),
          child: const ValidationDatas(),
        ),
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
