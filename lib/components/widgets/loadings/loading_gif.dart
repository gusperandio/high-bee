import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return  Lottie.asset('assets/lottie/loading.json',
                      width: size, height: size, fit: BoxFit.contain);
  }
}