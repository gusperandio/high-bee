import 'package:flutter/material.dart';
import 'package:high_bee/components/styles/colors.dart';

class Tag extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Widget? startContent;
  final Widget? endContent;

  const Tag._internal({
    required this.title,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    this.startContent,
    this.endContent,
  });

  factory Tag.infoHigh({
    required String title,
    Widget? startContent,
    Widget? endContent,
  }) {
    return Tag._internal(
      title: title,
      backgroundColor: SecondaryColors.primary,
      borderColor: Colors.transparent,
      textColor: Colors.white,
      startContent: startContent,
      endContent: endContent,
    );
  }

  factory Tag.infoLow({
    required String title,
    Widget? startContent,
    Widget? endContent,
  }) {
    return Tag._internal(
      title: title,
      backgroundColor: const Color(0xFFE5F3F3),
      borderColor: Colors.transparent,
      textColor: SecondaryColors.primary,
      startContent: startContent,
      endContent: endContent,
    );
  }

  factory Tag.successHigh({
    required String title,
    Widget? startContent,
    Widget? endContent,
  }) {
    return Tag._internal(
      title: title,
      backgroundColor: SecondaryColors.success,
      borderColor: Colors.transparent,
      textColor: Colors.white,
      startContent: startContent,
      endContent: endContent,
    );
  }

  factory Tag.successLow({
    required String title,
    Widget? startContent,
    Widget? endContent,
  }) {
    return Tag._internal(
      title: title,
      backgroundColor: const Color(0xFFECF7F2),
      borderColor: const Color(0xFFcfe0da),
      textColor: SecondaryColors.success,
      startContent: startContent,
      endContent: endContent,
    );
  }

  factory Tag.warningHigh({
    required String title,
    Widget? startContent,
    Widget? endContent,
  }) {
    return Tag._internal(
      title: title,
      backgroundColor: SecondaryColors.warning,
      borderColor: Colors.transparent,
      textColor: Colors.white,
      startContent: startContent,
      endContent: endContent,
    );
  }

  factory Tag.warningLow({
    required String title,
    Widget? startContent,
    Widget? endContent,
  }) {
    return Tag._internal(
      title: title,
      backgroundColor: const Color(0xFFFFF6E6),
      borderColor: const Color(0xFFE6E4D8),
      textColor: SecondaryColors.warning,
      startContent: startContent,
      endContent: endContent,
    );
  }

  factory Tag.dangerHigh({
    required String title,
    Widget? startContent,
    Widget? endContent,
  }) {
    return Tag._internal(
      title: title,
      backgroundColor: SecondaryColors.danger,
      borderColor: Colors.transparent,
      textColor: Colors.white,
      startContent: startContent,
      endContent: endContent,
    );
  }

  factory Tag.dangerLow({
    required String title,
    Widget? startContent,
    Widget? endContent,
  }) {
    return Tag._internal(
      title: title,
      backgroundColor: const Color(0xFFFEEDED),
      borderColor: const Color(0xFFe5d6d8),
      textColor: SecondaryColors.danger,
      startContent: startContent,
      endContent: endContent,
    );
  }

  factory Tag.blackHigh({
    required String title,
    Widget? startContent,
    Widget? endContent,
  }) {
    return Tag._internal(
      title: title,
      backgroundColor: const Color(0xFF0B2574),
      borderColor: Colors.transparent,
      textColor: Colors.white,
      startContent: startContent,
      endContent: null,
    );
  }

  factory Tag.blackLow({
    required String title,
    Widget? startContent,
    Widget? endContent,
  }) {
    return Tag._internal(
      title: title,
      backgroundColor: const Color(0xFFEBF2FE),
      borderColor: const Color(0xFFCAD6DB),
      textColor: const Color(0xFF0B2574),
      startContent: startContent,
      endContent: endContent,
    );
  }

  factory Tag.defHigh({
    required String title,
    Widget? startContent,
    Widget? endContent,
  }) {
    return Tag._internal(
      title: title,
      backgroundColor: PrimaryColors.highBeeColor,
      borderColor: Colors.transparent,
      textColor: Colors.white,
      startContent: startContent,
      endContent: endContent,
    );
  }

  factory Tag.defLow({
    required String title,
    Widget? startContent,
    Widget? endContent,
  }) {
    return Tag._internal(
      title: title,
      backgroundColor: const Color(0xFFEBF2FE),
      borderColor: const Color(0xFFCAD6DB),
      textColor: PrimaryColors.highBeeColor,
      startContent: startContent,
      endContent: endContent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 4,
        children: [
          if (startContent != null) startContent!,
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w800,
            ),
          ),
          if (endContent != null) endContent!,
        ],
      ),
    );
  }
}
