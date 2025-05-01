import 'package:flutter/material.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/views/competition/widgets/countdown_timer.dart';

class ElegantCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const ElegantCard({super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width * 0.8;

    return Center(
      child: Column(
        children: [
          Card(
            color: PrimaryColors.claudeColor,
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(imageUrl, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: cardWidth,
                  padding: const EdgeInsets.all(16),
                  child: CountdownTimer(
                    expiryTime: DateTime.parse("2025-05-05T18:30:00Z"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [Button.def(title: "Participar")]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
