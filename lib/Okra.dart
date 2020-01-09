library okra_widget;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:okra_widget/utils/Helper.dart';
import 'utils/OkraOptions.dart';
import 'view/web.dart';

class Okra {
    static void create(BuildContext context, OkraOptions okraOptions){
        Helper.getDeviceUUID().then((uuid){
            okraOptions.uuid = uuid;
            Helper.getDeviceIMEI().then((imei){
                okraOptions.imei = imei == "Permission Denied" ? "null" : imei;
                Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new Web(okraOptions: okraOptions)));
            });
        });
    }
}