import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final Color color;
  final Widget content;
  final double size;

  const Separator({
    super.key,
    required this.color,
    required this.content,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: size,
            color: color,
            endIndent: 8,
          ),
        ),
        content,
        Expanded(
          child: Divider(
            thickness: size,
            color: color,
            indent: 8,
          ),
        ),
      ],
    );
  }
}
