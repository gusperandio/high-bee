import 'package:flutter/material.dart';
import 'package:high_bee/views/competition/widgets/countdown_timer.dart';

class CompetitionPage extends StatelessWidget {
  const CompetitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CountdownTimer(expiryTime: DateTime.parse("2025-05-01T18:30:00Z")),
        Center(
          child: const Text(
            'Competition Page',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
