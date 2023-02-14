import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:platform_device_id/platform_device_id.dart';

class Helper {
  static Future<String?> getDeviceUUID() async {
    String? deviceId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }

    return deviceId;
  }

  static Future<AndroidDeviceInfo?> getAndroidInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      return await deviceInfoPlugin.androidInfo;
    } catch (ex) {
      return null;
    }
  }

  static Future<IosDeviceInfo?> getIosInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      return await deviceInfoPlugin.iosInfo;
    } catch (ex) {
      return null;
    }
  }
}
