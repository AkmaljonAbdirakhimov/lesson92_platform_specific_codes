import 'package:flutter/services.dart';

/// Listens the shake event at [eventChannel] from the native code.
class Shake {
  static const eventChannel = EventChannel("uz.najottalim.platform/shake");

  static Stream<dynamic> shakeEvent() {
    return eventChannel.receiveBroadcastStream();
  }
}
