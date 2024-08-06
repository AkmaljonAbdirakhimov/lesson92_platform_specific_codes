import 'package:flutter/services.dart';

class BatteryLife {
  static const platform = MethodChannel('uz.najottalim.platform/battery');

  static Future<String> getBatteryLife() async {
    String batteryLevel = 'Unknown battery level.';

    try {
      // platform.invokeMethod - native tomondagi kerakli funksiyani chaqiradi
      final result =
          await platform.invokeMethod<int>('battareyaniFoiziniOlaqol');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    return batteryLevel;
  }
}
