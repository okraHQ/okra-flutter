import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:okra_widget/models/device_info.dart';
import 'package:okra_widget/utils/helper.dart';
import 'models/okra_handler.dart';
import 'utils/okra_options.dart';
import'dart:io' show Platform;
import 'view/web.dart';

class Okra {
  static Future<OkraHandler> create(
    BuildContext context, OkraOptions okraOptions) async {

    AndroidDeviceInfo androidDeviceInfo;
    IosDeviceInfo iosDeviceInfo;

    if(Platform.isAndroid) {
       androidDeviceInfo = await Helper.getAndroidInfo();
    }else {
       iosDeviceInfo = await Helper.getIosInfo();
    }


    okraOptions.uuid =  Platform.isAndroid ? androidDeviceInfo.androidId : iosDeviceInfo.identifierForVendor;
    String deviceName = Platform.isAndroid ? androidDeviceInfo.brand : iosDeviceInfo.name;
    String deviceModel = Platform.isAndroid ? androidDeviceInfo.model : iosDeviceInfo.model;

    okraOptions.deviceInfo = new DeviceInfo(deviceName, deviceModel, 0.0, 0.0, Platform.isAndroid ? "android" : "ios");
    //String imei = await Helper.getDeviceIMEI();
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Web(okraOptions: okraOptions),
      ),
    );
  }
}
