import 'package:derm_ai_scan/screens/auth/auth_screen.dart';
import 'package:derm_ai_scan/screens/home_screen.dart';
import 'package:derm_ai_scan/services/auth_service.dart';
import 'package:flutter/material.dart';


class DermaiScreen extends StatelessWidget {
  const DermaiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomeScreen();
        } else if (snapshot.hasError) {
          return const AuthScreen();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center();
        } else {
          return const AuthScreen();
        }
      },
    );
  }
}
