import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:okra_widget/utils/helper.dart';
import 'models/okra_handler.dart';
import'dart:io' show Platform;
import 'models/okra_handler.dart';
import 'view/web.dart';

// class Okra {
//   static Future<OkraHandler> create(
//     BuildContext context, Map<String, dynamic> okraOptions) async {
//
//     AndroidDeviceInfo androidDeviceInfo;
//     IosDeviceInfo iosDeviceInfo;
//
//     if(Platform.isAndroid) {
//        androidDeviceInfo = await Helper.getAndroidInfo();
//     }else {
//        iosDeviceInfo = await Helper.getIosInfo();
//     }
//
//     okraOptions["uuid"] =  Platform.isAndroid ? androidDeviceInfo.androidId : iosDeviceInfo.identifierForVendor;
//     String deviceName = Platform.isAndroid ? androidDeviceInfo.brand : iosDeviceInfo.name;
//     String deviceModel = Platform.isAndroid ? androidDeviceInfo.model : iosDeviceInfo.model;
//     okraOptions["deviceInfo"] = {
//        "deviceName" : deviceName,
//        "deviceModel" : deviceModel,
//        "longitude" : 0,
//        "latitude" :  0,
//        "platform" : Platform.isAndroid ? "android" : "ios"
//     };
//
//     okraOptions["source"] = "flutter";
//     okraOptions["isWebview"] = true;
//
//     return await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (BuildContext context) => Web(okraOptions: okraOptions),
//       ),
//     );
//   }
// }

class Okra {
  Okra._();
  static Future<void> buildWithOptions(
      BuildContext context, {
        @required String key,
        @required String token,
        @required List<String> products,
        @required String environment,
        @required String clientName,
        Color color,
        String limit,
        bool isCorporate,
        String connectMessage,
        String callback_url,
        String redirect_url,
        String logo,
        String widget_success,
        String widget_failed,
        String currency,
        bool noPeriodic,
        String exp,
        String success_title,
        String success_message,
        Map<String, Object> guarantors,
        Map<String, Object> filters,
        @required Function(String data) onSuccess,
        @required Function(String message) onError,
      }) async {

    AndroidDeviceInfo androidDeviceInfo;
    IosDeviceInfo iosDeviceInfo;

    if(Platform.isAndroid) {
      androidDeviceInfo = await Helper.getAndroidInfo();
    }else {
      iosDeviceInfo = await Helper.getIosInfo();
    }

    Map<String, dynamic> okraOptions = new Map();
    okraOptions["key"] = key;
    okraOptions["token"] = token;
    okraOptions["products"] = products;
    okraOptions["environment"] = environment;
    okraOptions["clientName"] = clientName;
    okraOptions["color"] = color;
    okraOptions["limit"] = limit;
    okraOptions["isCorporate"] = isCorporate;
    okraOptions["connectMessage"] = connectMessage;
    okraOptions["callback_url"] = callback_url;
    okraOptions["redirect_url"] = redirect_url;
    okraOptions["logo"] = logo;
    okraOptions["widget_success"] = widget_success;
    okraOptions["widget_failed"] = widget_failed;
    okraOptions["currency"] = currency;
    okraOptions["noPeriodic"] = noPeriodic;
    okraOptions["exp"] = exp;
    okraOptions["success_title"] = success_title;
    okraOptions["success_message"] = success_message;

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

    OkraHandler res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Web(okraOptions: okraOptions),
      ),
    );

    if (res.isSuccessful) {
      onSuccess(res.data);
    } else {
      onError(res.data);
    }
  }
}