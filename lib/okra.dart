import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:okra_widget/raw/okra_html.dart';
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
        String app_id,
        List<String> products,
        String environment,
        String clientName,
        String color,
        int limit,
        bool isCorporate,
        bool payment,
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
        String chargeType,
        int chargeAmount,
        String chargeNote,
        String chargeCurrency,
        Map<String, Object> guarantors,
        Map<String, Object> filters,
        Function(String data) onSuccess,
        Function(String message) onError,
        Function(String message) onClose,
        Function(String message) beforeClose,
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
    okraOptions["app_id"] = app_id;
    okraOptions["env"] = environment;
    okraOptions["clientName"] = clientName ?? "";
    okraOptions["color"] = color ?? "#3AB795";
    okraOptions["limit"] = limit ?? 24;
    okraOptions["isCorporate"] = isCorporate ?? false;
    okraOptions["payment"] = payment ?? false;
    okraOptions["connectMessage"] = connectMessage;
    okraOptions["callback_url"] = callback_url ?? "";
    okraOptions["redirect_url"] = redirect_url ?? "";
    okraOptions["logo"] = logo ?? "";
    okraOptions["widget_success"] = widget_success ?? "";
    okraOptions["widget_failed"] = widget_failed ?? "";
    okraOptions["currency"] = currency ?? "NGN";
    okraOptions["noPeriodic"] = noPeriodic ?? false;
    okraOptions["exp"] = exp ?? "";
    okraOptions["success_title"] = success_title ?? "";
    okraOptions["success_message"] = success_message ?? "";
    okraOptions["charge"] = {
      "type": chargeType ?? "",
      "amount": chargeAmount ?? "",
      "note":  chargeNote ?? "",
      "currency": chargeCurrency ?? ""
    };

    okraOptions["uuid"] =  Platform.isAndroid ? androidDeviceInfo.androidId : iosDeviceInfo.identifierForVendor;
    String deviceName = Platform.isAndroid ? androidDeviceInfo.brand : iosDeviceInfo.name;
    String deviceModel = Platform.isAndroid ? androidDeviceInfo.model : iosDeviceInfo.model;
    okraOptions["deviceInfo"] = "";
    // okraOptions["deviceInfo"] = {
    //   "deviceName" : deviceName,
    //   "deviceModel" : deviceModel,
    //   "longitude" : 0,
    //   "latitude" :  0,
    //   "platform" : Platform.isAndroid ? "android" : "ios"
    // };

    for (String p in products) {
      int i = products.indexOf(p);
      products[i] =  "'$p'";
    }
    okraOptions["products"] = products;

    okraOptions["source"] = "flutter";
    okraOptions["isWebview"] = true;
    print(products);
    print(mBuildOkraWidgetWithOptions(okraOptions));

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Web(
          okraOptions: okraOptions,
          useShort: false,
          onClose: onClose,
          onError: onError,
          onSuccess: onSuccess,
        ),
      ),
    );

  }

  static Future<void> buildWithShortUrl(
      BuildContext context, {
        String shortUrl,
        Function(String data) onSuccess,
        Function(String message) onError,
        Function(String message) onClose,
        Function(String message) beforeClose,
      }) async {


    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Web(
          shortUrl: shortUrl,
          useShort: true,
          onClose: onClose,
          onError: onError,
          onSuccess: onSuccess,
        ),
      ),
    );
  }
}