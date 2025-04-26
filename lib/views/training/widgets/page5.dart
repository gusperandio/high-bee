import 'package:flutter/material.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/separator/separator.dart';

class Page5 extends StatelessWidget {
  const Page5({super.key});

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
                  "Escolha seu estilo",
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
                  "Escolha o tipo de fonte para trazer aquele AR",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: PrimaryColors.carvaoColor,
                    fontFamily: 'Urbanist',
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "MAIS SÉRIO",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    color: PrimaryColors.carvaoColor,
                    fontFamily: 'Georgia',
                  ),
                ),
                Image.asset(
                  "assets/images/smile.png",
                  fit: BoxFit.cover,
                  width: 150,
                  height: 110,
                ),
                Separator(
                  color: Colors.black,
                  content: const Text(
                    "OU",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  size: 1,
                ),
                Text(
                  "MAIS DIVERTIDO",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    color: PrimaryColors.carvaoColor,
                    fontFamily: 'Nunito',
                  ),
                ),
                Image.asset(
                  "assets/images/stoner.png",
                  fit: BoxFit.cover,
                  width: 150,
                  height: 150,
                ),
              ],
            ),
          ),
        ),
      );
  }
}
