import 'package:derm_ai_scan/constants.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: mainClr,
        strokeWidth: 6,
      ),
    );
  }
}
