import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/bullet_point/bullet_point.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

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
                  "Fotos e Imagens",
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
                  "Formato de como é exibido as imagens de \ncapa e cada publicação",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: PrimaryColors.carvaoColor,
                    fontFamily: 'Urbanist',
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SvgPicture.asset("assets/svg/rules/cape_rule.svg", height: 340),
                BulletPoint(
                  text: 'Não é permitido deixar sem capa',
                  sizeFont: 16,
                ),
                BulletPoint(
                  text: 'É opcional imagens adicionais',
                  sizeFont: 16,
                ),
                BulletPoint(
                  text: 'É possível adicionar legenda em cada foto adicionada',
                  sizeFont: 16,
                ),
              ],
            ),
          ),
        ),
      );
  }
}
