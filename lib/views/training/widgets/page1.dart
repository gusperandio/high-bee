import 'package:flutter/material.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/bullet_point/bullet_point.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: PrimaryColors.highBeeColor,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/marcadagua.png',
                  width: 180,
                  height: 140,
                ),
                SizedBox(height: 20),
                Text(
                  "Vamos começar seu treinamento!",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    color: PrimaryColors.carvaoColor,
                    fontFamily: 'Urbanist',
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Aqui você compartilha, aprende e se conecta com conteúdos confiáveis sobre cannabis.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: PrimaryColors.carvaoColor,
                    fontFamily: 'Urbanist',
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  "Vamos aprender sobre postar conteúdos!",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    color: PrimaryColors.carvaoColor,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                BulletPoint(text: 'Como é exibido títulos', sizeFont: 18),
                BulletPoint(text: 'Como é exibido a capa', sizeFont: 18),
                BulletPoint(text: 'Como fornecer o conteúdo', sizeFont: 18),
                BulletPoint(text: 'Escolha o estilo', sizeFont: 18),
                BulletPoint(
                  text: 'Como é exibido todo o conteúdo',
                  sizeFont: 18,
                ),
              ],
            ),
          ),
        ),
      );
  }
}