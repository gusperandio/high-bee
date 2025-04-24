import 'package:flutter/material.dart';

class AgeAlert extends StatelessWidget {
  const AgeAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              size: 40,
              color: Colors.orange,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Atenção: uso permitido apenas para maiores de 18 anos',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Este aplicativo é voltado à divulgação de informações sobre o universo da cannabis. O acesso é restrito a maiores de idade pelos seguintes motivos:',
                    style: TextStyle(fontFamily: 'Urbanist', fontSize: 13),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '• Alinhamento com leis e regulamentações sobre o tema;\n'
                    '• Prevenção de acesso precoce a conteúdos sensíveis;\n'
                    '• Compromisso com a educação e a ciência;\n'
                    '• Responsabilidade com o debate público e a formação de opinião.',
                    style: TextStyle(fontFamily: 'Urbanist', fontSize: 13),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Se você ainda não completou 18 anos, pedimos que aguarde até atingir a maioridade para acessar este conteúdo de forma segura e legal.',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
