import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:okra_widget/okra_widget.dart';
import 'package:okra_widget/utils/helper.dart';
import 'models/okra_handler.dart';
import'dart:io' show Platform;
import 'view/web.dart';

class Okra {
  static Future<OkraHandler> create(
    BuildContext context, Map<String, dynamic> okraOptions) async {

    AndroidDeviceInfo androidDeviceInfo;
    IosDeviceInfo iosDeviceInfo;

    if(Platform.isAndroid) {
       androidDeviceInfo = await Helper.getAndroidInfo();
       okraOptions["isHybridUSSDEnabled"] = true;
       await OkraWidget.initHover;
    }else {
       iosDeviceInfo = await Helper.getIosInfo();
    }

    okraOptions["uuid"] =  Platform.isAndroid ? androidDeviceInfo.androidId : iosDeviceInfo.identifierForVendor;
    String deviceName = Platform.isAndroid ? androidDeviceInfo.brand : iosDeviceInfo.name;
    String deviceModel = Platform.isAndroid ? androidDeviceInfo.model : iosDeviceInfo.model;
    okraOptions["deviceInfo"] = {
       "deviceName" : deviceName,
       "deviceModel" : deviceModel,
       "longitude" : 0,
       "latitude" :  0,
       "platform" : Platform.isAndroid ? "android" : "ios"
    };

    okraOptions["source"] = "flutter";
    okraOptions["isWebview"] = true;
    if(Platform.isAndroid){
      await OkraWidget.initOptions(JsonEncoder().convert(okraOptions));
    }


    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Web(okraOptions: okraOptions),
      ),
    );
  }
}
