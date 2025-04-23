import 'package:flutter/material.dart';
import 'package:high_bee/components/styles/colors.dart';

enum Variant { def, black, info, success, warning, danger }

class ToastStyle {
  final Color background;
  final Color textColor;

  ToastStyle({required this.background, required this.textColor});
}

class ToastStyles {
  static final Map<Variant, ToastStyle> style = {
    Variant.success: ToastStyle(
      background: SecondaryColors.success,
      textColor: Colors.white,
    ),
    Variant.warning: ToastStyle(
      background: SecondaryColors.warning,
      textColor: Colors.black,
    ),
    Variant.danger: ToastStyle(
      background: SecondaryColors.danger,
      textColor: Colors.white,
    ),
    Variant.info: ToastStyle(
      background: PrimaryColors.carvaoColor,
      textColor: Colors.white,
    ),
  };
}

class Toast {
  static void show(
    BuildContext context,
    String message, {
    required Variant variant,
    Duration? duration,
  }) {
    final style = ToastStyles.style[variant]!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: style.textColor,
            fontFamily: 'Urbanist',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: style.background,
      ),
    );
  }
}
