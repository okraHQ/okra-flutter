import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:okra_widget/models/OkraHandler.dart';
import 'package:okra_widget/utils/OkraOptions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Web extends StatefulWidget {

  final OkraOptions okraOptions;

  const Web({
    Key key,
    this.okraOptions
  })  : assert(okraOptions != null), super(key: key);

  @override
  _WebState createState() => _WebState();
}


class _WebState extends State<Web> {

  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    
    

    return WebView(
      initialUrl : "https://mobile.okra.ng",
      onPageFinished: (response){
        String jsonOptions = jsonEncode(widget.okraOptions.toJson());
        _controller.evaluateJavascript("openOkraWidget('$jsonOptions')");
      },
      javascriptMode : JavascriptMode.unrestricted,
      javascriptChannels: Set.from([
        JavascriptChannel(
            name: 'FlutterOnSuccess',
            onMessageReceived: (JavascriptMessage message) {
              Navigator.pop(context, new OkraHandler(true, true, false, message.message));
            }),
        JavascriptChannel(
            name: 'FlutterOnError',
            onMessageReceived: (JavascriptMessage message) {
              Navigator.pop(context, new OkraHandler(true, false, true, message.message));
            }),
        JavascriptChannel(
            name: 'FlutterOnClose',
            onMessageReceived: (JavascriptMessage message) {
              Navigator.pop(context, new OkraHandler(true, false, false, message.message));
            })
      ]),
      onWebViewCreated: (webViewController){_controller = webViewController;}
    );
  }
}