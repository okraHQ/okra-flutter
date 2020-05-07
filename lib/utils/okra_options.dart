import 'dart:core';

import 'package:okra_widget/models/Enums.dart';
import 'package:okra_widget/models/Guarantor.dart';

class OkraOptions {
  bool isWebview;
  String key = "";
  String token;
  List<Product> products = [];
  Environment env;
  String uuid = "";
  String imei = "";
  String clientName;
  String webhook;

  String color;
  String limit;
  bool isCorporate;
  String connectMessage;
  Guarantor guarantors;
  // ignore: non_constant_identifier_names
  String callback_url;
  // ignore: non_constant_identifier_names
  String redirect_url;
  String logo;
  //filter: ${JSON.stringify(filter)},
  // ignore: non_constant_identifier_names
  String widget_success;
  String currency;
  String exp;
  // ignore: non_constant_identifier_names
  String success_title;
  // ignore: non_constant_identifier_names
  String success_message;

  OkraOptions(bool isWebview, String key, String token, List<Product> products,
      Environment environment, String clientName) {
    this.isWebview = isWebview;
    this.key = key;
    this.token = token;
    this.products = products;
    this.env = environment;
    this.clientName = clientName;
  }

  Map<String, dynamic> toJson() {
    return {
      'isWebview': isWebview,
      'key': key,
      'token': token,
      'products': encondeListToJson(products),
      'env': env.toString().split('.').last == "production_sandox"
          ? "production-sandbox"
          : env.toString().split('.').last,
      'clientName': clientName,
      'color': color,
      'limit': limit,
      'isCorporate': isCorporate,
      'connectMessage': connectMessage,
      'guarantors':
          guarantors != null ? guarantors.toJson() : Guarantor(false, "", 2),
      'callback_url': callback_url,
      'redirect_url': redirect_url,
      'logo': logo,
      'widget_success': widget_success,
      'currency': currency,
      'exp': exp,
      'success_title': success_title,
      'success_message': success_message,
    };
  }

  List encondeListToJson(List<Product> list) {
    List jsonList = List();
    list.map((item) => jsonList.add(item.toString().split('.').last)).toList();
    return jsonList;
  }
}
