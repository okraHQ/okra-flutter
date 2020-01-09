import 'dart:core';

import 'package:okra_widget/models/Enums.dart';

class OkraOptions{

  bool isWebview;
  String key = "";
  String token;
  List<Product> products = [];
  Environment env;
  String uuid = "";
  String imei = "";
  String clientName;
  String webhook;

  OkraOptions(bool isWebview, String key, String token, List<Product> products, Environment environment, String clientName){
    this.isWebview = isWebview;
    this.key = key;
    this.token = token;
    this.products = products;
    this.env = environment;
    this.clientName = clientName;
  }

  Map<String, dynamic> toMap() {
    return {
      'isWebview': isWebview,
      'key': key,
      'token': token,
      'products': products,
      'env': env,
      'clientName': clientName,
    };
  }


}
