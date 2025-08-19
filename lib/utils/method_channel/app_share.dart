import 'dart:io';

import 'package:flutter/services.dart';

class AppShare {
  Future<void> shareFile() async {
    if (Platform.isIOS) {
      const channel = MethodChannel("ios_channel");
      try {
        await channel.invokeMethod("shareFile", "https://apps.apple.com/in/app/Dhanraj-Trading/id6749827410");
      } catch (e) {
        print("Error sharing image: $e");
      }
    } else {
      const channel = MethodChannel("android_channel");
      try {
        await channel.invokeMethod("shareFile", "https://play.google.com/store/apps/details?id=dhanraj.trading");
      } catch (e) {
        print("Error sharing image: $e");
      }
    }
  }
}
