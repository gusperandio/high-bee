import 'package:flutter/material.dart';

class CannabisStageGuide extends StatelessWidget {
  const CannabisStageGuide({super.key});

  @override
  Widget build(BuildContext context) {
    final stages = [
      {'icon': '🌱', 'title': 'Semente', 'period': '0 a 7 dias'},
      {'icon': '🌿', 'title': 'Plântula', 'period': '8 a 19 dias'},
      {'icon': '🍁', 'title': 'Vegetativo', 'period': '20 a 54 dias'},
      {'icon': '💐', 'title': 'Floração', 'period': '55 a 80 dias'},
      {'icon': '🥦', 'title': 'BUD VIBE', 'period': '80 a 119 dias'},
      {'icon': '🧊', 'title': 'ICE', 'period': 'Mais de 120 dias'},
      {'icon': '🌀', 'title': 'THC HIGH', 'period': '1 ano'},
      {'icon': '🧬', 'title': 'CBD MASTER', 'period': '2 anos'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Text(
            'Sua TAG muda conforme o tempo que está utilizando o aplicativo',
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        ...stages.map(
          (stage) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              children: [
                Text(
                  stage['icon']!,
                  style: const TextStyle(fontFamily: 'Urbanist', fontSize: 28),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stage['title']!,
                      style: const TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      stage['period']!,
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
