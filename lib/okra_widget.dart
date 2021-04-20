
import 'dart:async';

import 'package:flutter/services.dart';

class OkraWidget {
  static const MethodChannel _channel =
      const MethodChannel('okra_widget');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> get testFunction async {
    final String version = await _channel.invokeMethod('testFunction');
    return version;
  }

  static Future<void> get initHover async {
    return await _channel.invokeMethod('initHover');
  }

  static Future<bool>  checkPermissions(permissionType) async {
    return await _channel.invokeMethod('permissionOn',{"text":permissionType});
  }
  static Future<void>  askForPermissions(permissionType) async {
    return await _channel.invokeMethod('switchPermissionOn',{"text":permissionType});
  }
  static Future<void>  initOptions(options) async {
    return await _channel.invokeMethod('initOptions',{"text":options});
  }
  static Future<void>  openUSSD(json) async {
    return await _channel.invokeMethod('openUSSD',{"text":json});
  }
  static Future<void>  startUSSDPayment(json) async {
    return await _channel.invokeMethod('startUSSDPayment',{"text":json});
  }
}
