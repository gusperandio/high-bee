import 'package:flutter/material.dart';
import 'package:high_bee/components/styles/colors.dart';

class BulletPoint extends StatelessWidget {
  final String text;
  final double sizeFont;

  const BulletPoint({super.key, required this.text, required this.sizeFont});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.circle, size: 6, color: PrimaryColors.carvaoColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: sizeFont,
                  color: PrimaryColors.carvaoColor,
                  fontFamily: 'Urbanist'),
            ),
          ),
        ],
      ),
    );
  }
}
