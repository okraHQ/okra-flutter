library okra_widget;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'utils/OkraOptions.dart';
import 'view/web.dart';

class Okra {
    static void create(BuildContext context, OkraOptions okraOptions){
        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new Web(okraOptions: okraOptions)));
    }
}
