import 'package:flutter/material.dart';
import 'dart:async';

import 'package:high_bee/components/styles/colors.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime expiryTime;

  const CountdownTimer({super.key, required this.expiryTime});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late Duration _remainingTime;

  @override
  void initState() {
    super.initState();
    _calculateRemainingTime();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _calculateRemainingTime();
    });
  }

  void _calculateRemainingTime() {
    final now = DateTime.now();
    setState(() {
      _remainingTime = widget.expiryTime.difference(now);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime() {
    final int days = _remainingTime.inDays;
    final int hours = _remainingTime.inHours.remainder(24);
    final int minutes = _remainingTime.inMinutes.remainder(60);
    final int seconds = _remainingTime.inSeconds.remainder(60);

    return 'Expira em: ${days}d ${hours}h ${minutes}m ${seconds}s';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PrimaryColors.carvaoColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        _formatTime(),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
