import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/bullet_point/bullet_point.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: PrimaryColors.claudeColor,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Text(
                  "Título da publicação",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    color: PrimaryColors.carvaoColor,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Formato de como é exibido o título da sua publicação",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: PrimaryColors.carvaoColor,
                    fontFamily: 'Urbanist',
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SvgPicture.asset(
                  "assets/svg/rules/title_rule.svg",
                  height: 340,
                ),
                const SizedBox(height: 15),
                BulletPoint(
                  text: 'Não é permitido deixar sem título',
                  sizeFont: 16,
                ),
              ],
            ),
          ),
        ),
      );
  }
}
