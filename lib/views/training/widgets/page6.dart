import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/bullet_point/bullet_point.dart';

class Page6 extends StatelessWidget {
  const Page6({super.key});

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
                "Seu conteúdo final",
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
                "A ordem como é exibido também segue no mesmo formato na qual é preenchido",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: PrimaryColors.carvaoColor,
                  fontFamily: 'Urbanist',
                  fontStyle: FontStyle.italic,
                ),
              ),
              SvgPicture.asset("assets/svg/rules/all_content.svg", height: 340),
              const SizedBox(height: 15),
              BulletPoint(text: 'LEIA AS REGRAS!', sizeFont: 16),
              BulletPoint(text: 'Divirta-se', sizeFont: 16),
            ],
          ),
        ),
      ),
    );
  }
}
