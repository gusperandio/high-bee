import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:high_bee/components/styles/colors.dart';

class AppContainer extends StatelessWidget {
  final Widget? body;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final Color? statusBarColor;
  final Brightness? statusBarIconBrightness;
  final Brightness? statusBarBrightness;
  final Color? systemNavigationBarColor;
  final Brightness? systemNavigationBarIconBrightness;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const AppContainer({
    super.key,
    this.body,
    this.bottomNavigationBar,
    this.appBar,
    this.backgroundColor,
    this.statusBarColor,
    this.statusBarIconBrightness,
    this.statusBarBrightness,
    this.systemNavigationBarColor,
    this.systemNavigationBarIconBrightness,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor ?? Colors.transparent,
        statusBarIconBrightness: statusBarIconBrightness ?? Brightness.light,
        systemNavigationBarColor: systemNavigationBarColor ?? Colors.black,
        systemNavigationBarIconBrightness:
            systemNavigationBarIconBrightness ?? Brightness.light,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor ?? PrimaryColors.highBeeColor,
        appBar: appBar,
        body:
            Theme.of(context).platform == TargetPlatform.android
                ? SafeArea(child: body!)
                : body!,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
      ),
    );
  }
}
