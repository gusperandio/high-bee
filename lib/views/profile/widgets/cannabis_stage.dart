import 'package:flutter/material.dart';
import 'package:high_bee/components/widgets/tags/tag.dart';

class CannabisStage extends StatelessWidget {
  final String? stage;

  const CannabisStage({super.key, this.stage});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final createdDate = DateTime.parse(stage ?? now.toIso8601String());
    final days = now.difference(createdDate).inDays;

    if (days <= 7) {
      return Tag.defLow(title: '🌱 Semente');
    } else if (days <= 19) {
      return Tag.successLow(title: '🌿 Plântula');
    } else if (days <= 54) {
      return Tag.dangerLow(title: '🍁 Vegetativo');
    } else if (days <= 80) {
      return Tag.blackLow(title: '💐 Floração');
    } else if (days <= 120) {
      return Tag.successHigh(title: '🥦 BUD VIBE');
    } else if (days <= 365) {
      return Tag.blackHigh(title: '🧊 ICE');
    } else if (days <= 730) {
      return Tag.infoHigh(title: '🌀 THC HIGH');
    } else {
      return Tag.blackHigh(title: '🧬 CBD MASTER');
    }
  }
}
