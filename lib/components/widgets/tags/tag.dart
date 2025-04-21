import 'package:flutter/material.dart';
import 'package:high_bee/components/styles/colors.dart';

class Tag extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  const Tag._internal({
    required this.title,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
  });

  factory Tag.infoHigh({required String title}) {
    return Tag._internal(
      title: title,
      backgroundColor: SecondaryColors.primary,
      borderColor: Colors.transparent,
      textColor: Colors.white,
    );
  }

  factory Tag.infoLow({required String title}) {
    return Tag._internal(
      title: title,
      backgroundColor: const Color(0xFFE5F3F3),
      borderColor: Colors.transparent,
      textColor: SecondaryColors.primary,
    );
  }

  factory Tag.successHigh({required String title}) {
    return Tag._internal(
      title: title,
      backgroundColor: SecondaryColors.success,
      borderColor: Colors.transparent,
      textColor: Colors.white,
    );
  }

  factory Tag.successLow({required String title}) {
    return Tag._internal(
      title: title,
      backgroundColor: const Color(0xFFECF7F2),
      borderColor: const Color(0xFFcfe0da),
      textColor: SecondaryColors.success,
    );
  }

  factory Tag.warningHigh({required String title}) {
    return Tag._internal(
      title: title,
      backgroundColor: SecondaryColors.warning,
      borderColor: Colors.transparent,
      textColor: Colors.white,
    );
  }

  factory Tag.warningLow({required String title}) {
    return Tag._internal(
      title: title,
      backgroundColor: const Color(0xFFFFF6E6),
      borderColor: const Color(0xFFE6E4D8),
      textColor: SecondaryColors.warning,
    );
  }

  factory Tag.dangerHigh({required String title}) {
    return Tag._internal(
      title: title,
      backgroundColor: SecondaryColors.danger,
      borderColor: Colors.transparent,
      textColor: Colors.white,
    );
  }

  factory Tag.dangerLow({required String title}) {
    return Tag._internal(
      title: title,
      backgroundColor: const Color(0xFFFEEDED),
      borderColor: const Color(0xFFe5d6d8),
      textColor: SecondaryColors.danger,
    );
  }

  factory Tag.blackHigh({required String title}) {
    return Tag._internal(
      title: title,
      backgroundColor: const Color(0xFF0B2574),
      borderColor: Colors.transparent,
      textColor: Colors.white,
    );
  }

  factory Tag.blackLow({required String title}) {
    return Tag._internal(
      title: title,
      backgroundColor: const Color(0xFFEBF2FE),
      borderColor: const Color(0xFFCAD6DB),
      textColor: const Color(0xFF0B2574),
    );
  }

  factory Tag.defHigh({required String title}) {
    return Tag._internal(
      title: title,
      backgroundColor: PrimaryColors.highBeeColor,
      borderColor: Colors.transparent,
      textColor: Colors.white,
    );
  }

  factory Tag.defLow({required String title}) {
    return Tag._internal(
      title: title,
      backgroundColor: const Color(0xFFEBF2FE),
      borderColor: const Color(0xFFCAD6DB),
      textColor: PrimaryColors.highBeeColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 8, vertical: 0), 
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        title,
        style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w800),
      ),
    );
  }
}
