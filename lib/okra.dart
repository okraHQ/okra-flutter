import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:okra_widget/utils/helper.dart';
import 'models/okra_handler.dart';
import 'utils/okra_options.dart';
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
      MaterialPageRoute(
        builder: (BuildContext context) => Web(okraOptions: okraOptions),
      ),
    );
  }
}
