import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lesson92_platform_specific_codes/services/platform/shake.dart';

class ShakeScreen extends StatefulWidget {
  const ShakeScreen({super.key});

  @override
  State<ShakeScreen> createState() => _ShakeScreenState();
}

class _ShakeScreenState extends State<ShakeScreen> with WidgetsBindingObserver {
  int counter = 0;

  @override
  void initState() {
    super.initState();

    Shake.shakeEvent().listen((_) {
      setState(() {
        counter++;
      });
    });

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    print(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shake Counter"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Shake count:',
              style: TextStyle(fontSize: 24),
            ), // Text
            Text(
              '$counter',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ), // Center
    );
  }
}
