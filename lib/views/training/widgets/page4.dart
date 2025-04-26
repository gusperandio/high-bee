import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/bullet_point/bullet_point.dart';
import 'package:high_bee/components/widgets/separator/separator.dart';

class Page4 extends StatelessWidget {
  const Page4({super.key});

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
                  "Fornecendo conteúdo",
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
                  "Você pode utilizar o botão de colar o paragráfo",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: PrimaryColors.carvaoColor,
                    fontFamily: 'Urbanist',
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SvgPicture.asset(
                  "assets/svg/rules/copy_paste.svg",
                  height: 165,
                ),
                Separator(
                  color: Colors.black,
                  content: const Text(
                    "Ou tentar digitar",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  size: 1,
                ),
                SvgPicture.asset("assets/svg/rules/keyboards.svg", height: 100),
                BulletPoint(
                  text: 'Pode adicionar muitos parágrafos',
                  sizeFont: 16,
                ),
                BulletPoint(
                  text:
                      'É obrigatório informar pelo menos o primeiro parágrafo',
                  sizeFont: 16,
                ),
                BulletPoint(
                  text: 'Antes de postar, sempre verifique as regras!',
                  sizeFont: 16,
                ),
              ],
            ),
          ),
        ),
      );
  }
}
