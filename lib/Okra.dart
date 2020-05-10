library okra_widget;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:okra_widget/utils/Helper.dart';
import 'models/OkraHandler.dart';
import 'utils/OkraOptions.dart';
import 'view/web.dart';

class Okra {
  static Future<OkraHandler> create(
      BuildContext context, OkraOptions okraOptions) async {
    String uuid = await Helper.getDeviceUUID();
    okraOptions.uuid = uuid;
    String imei = await Helper.getDeviceIMEI();
    okraOptions.imei = imei == "Permission Denied" ? "null" : imei;
    return await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                new Web(okraOptions: okraOptions)));
  }
}