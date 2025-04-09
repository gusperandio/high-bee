import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MSProvider {
  static T get<T>(BuildContext context) {
    return Provider.of<T>(context);
  }
}
