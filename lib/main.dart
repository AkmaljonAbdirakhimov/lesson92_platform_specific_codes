import 'package:flutter/material.dart';
import 'package:lesson92_platform_specific_codes/screens/shake_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ShakeScreen(),
    );
  }
}
