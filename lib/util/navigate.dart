import 'package:flutter/material.dart';

class MSNavigate {
  static void to(context, Widget Function(BuildContext) page) {
    Navigator.push(context, MaterialPageRoute(builder: page));
  }

  static void toName(context, String nameRoute, {Object? arguments}) {
    Navigator.pushNamed(context, nameRoute, arguments: arguments);
  }

  static void toRoot(context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/', (_) => false);
  }

 static void replaceWithName(BuildContext context, String nameRoute,
      {Object? arguments}) {
    Navigator.pushReplacementNamed(context, nameRoute, arguments: arguments);
  }

  static void back(context) {
    Navigator.of(context).pop();
  }

  static Map<String, dynamic> getArgs(BuildContext context) {
    return (ModalRoute.of(context)?.settings.arguments
            as Map<String, dynamic>?) ??
        {};
  }
}
