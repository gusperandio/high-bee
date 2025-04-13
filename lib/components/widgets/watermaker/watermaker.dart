import 'package:flutter/material.dart';
import 'package:high_bee/components/styles/colors.dart';

class Watermaker extends StatelessWidget {
  const Watermaker({super.key, this.dark = false});

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: dark ? Colors.black12 : PrimaryColors.highBeeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/marcadagua.png', width: 120, height: 80),
        ],
      ),
    );
  }
}
