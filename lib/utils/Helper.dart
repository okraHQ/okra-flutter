import 'dart:io';

import 'package:device_info/device_info.dart';

class Helper{
  static Future<String> getDeviceUUID() async {
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        identifier = build.androidId;  //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor;  //UUID for iOS
      }
    }catch(ex){

    }
    return identifier;
  }
}