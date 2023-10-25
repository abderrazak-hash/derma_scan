import 'package:derm_ai_scan/providers.dart';
import 'package:derm_ai_scan/screens/dermai_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const DermAiApp());
}

class DermAiApp extends StatelessWidget {
  const DermAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DermaiScreen(),
      ),
    );
  }
}
