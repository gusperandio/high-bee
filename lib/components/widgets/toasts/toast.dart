import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:high_bee/components/enum/enums.dart';
import 'package:high_bee/components/styles/colors.dart';

class Toast {
  static void show(
    BuildContext context,
    String message, Color danger, {
    Color backgroundColor = Colors.red,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: backgroundColor),
    );
  }
}
