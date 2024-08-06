import 'package:flutter/material.dart';
import 'package:lesson92_platform_specific_codes/services/platform/battery_life.dart';

class BatteryLifeScreen extends StatefulWidget {
  const BatteryLifeScreen({super.key});

  @override
  State<BatteryLifeScreen> createState() => _BatteryLifeScreenState();
}

class _BatteryLifeScreenState extends State<BatteryLifeScreen> {
  String? batteryLife;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () async {
                batteryLife = await BatteryLife.getBatteryLife();
                setState(() {});
              },
              child: const Text('Get Battery Level'),
            ),
            if (batteryLife != null) Text(batteryLife!),
          ],
        ),
      ),
    );
  }
}
