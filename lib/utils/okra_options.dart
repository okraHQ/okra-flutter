import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:okra_widget/models/enums.dart';
import 'package:okra_widget/models/filter.dart';
import 'package:okra_widget/models/guarantor.dart';

class OkraOptions {
  // TODO: Attach purpose of this parameter
  bool isWebview;
  String key = "";
  String token;
  List<Product> products = [];
  String env;
  String uuid = "";
  String imei = "";
  String clientName;
  String webhook;
  String source = "flutter";

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
  // ignore: non_constant_identifier_names
  String widget_failed;
  String currency;
  String exp;
  // ignore: non_constant_identifier_names
  String success_title;
  // ignore: non_constant_identifier_names
  String success_message;
  Filter filter;

  OkraOptions({
    bool isWebview = true,
    @required String key,
    @required String token,
    @required List<Product> products,
    @required Environment environment,
    @required String clientName,
  }) {
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
      'env': env,
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
      'source': source,
      'widget_success': widget_success,
      'widget_failed' : widget_failed,
      'currency': currency,
      'exp': exp,
      'success_title': success_title,
      'success_message': success_message,
      'filter' : filter.toJson()
    };
  }

  List encondeListToJson(List<Product> list) {
    List jsonList = List();
    list.map((item) => jsonList.add(item.toString().split('.').last)).toList();
    return jsonList;
  }
}
