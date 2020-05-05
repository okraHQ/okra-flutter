import 'dart:convert';

import 'package:flutter/material.dart';
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
            name: 'Mobile',
            onMessageReceived: (JavascriptMessage message) {
              Navigator.pop(context);
            })
      ]),
      onWebViewCreated: (webViewController){_controller = webViewController;},
      navigationDelegate: (action){
        Uri uri = Uri.parse(action.url);
        uri.queryParameters.forEach((key,value){
         if(key == "shouldClose" && value.toLowerCase() == 'true'){Navigator.pop(context);}}
        );
        return NavigationDecision.navigate;
      },
    );
  }
}
