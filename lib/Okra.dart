library okra_widget;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:okra_widget/utils/Helper.dart';
import 'utils/okra_options.dart';
import 'view/web.dart';

class Okra {
  static void create(BuildContext context, OkraOptions okraOptions) {
    Helper.getDeviceUUID().then((uuid) {
      okraOptions.uuid = uuid;
      Helper.getDeviceIMEI().then((imei) {
        okraOptions.imei = imei == "Permission Denied" ? "null" : imei;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    Web(okraOptions: okraOptions)));
      });
    });
  }
}
