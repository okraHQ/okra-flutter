import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:okra_widget/models/okra_handler.dart';
import 'package:okra_widget/utils/okra_options.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Web extends StatefulWidget {
  final OkraOptions okraOptions;

  const Web({Key key, this.okraOptions})
      : assert(okraOptions != null),
        super(key: key);

  @override
  _WebState createState() => _WebState();
}

class _WebState extends State<Web> {
  WebViewController _controller;
  bool isLoading = true;
  OkraHandler okraHandler = new OkraHandler(false, false, false, true, "");

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      WebView(
          initialUrl: "https://v2-mobile.okra.ng/mobile.html",
          onPageFinished: (response) {
            setState(() {isLoading = false;});
            String jsonOptions = jsonEncode(widget.okraOptions.toJson());
            print("jsonOptions  $jsonOptions");
            _controller.evaluateJavascript("openOkraWidget('$jsonOptions')");
          },
          javascriptMode: JavascriptMode.unrestricted,
          gestureRecognizers: [
            Factory(() => VerticalDragGestureRecognizer()),
            Factory(() => TapGestureRecognizer()),
          ].toSet(),
          javascriptChannels: Set.from([
            JavascriptChannel(
                name: 'FlutterOnSuccess',
                onMessageReceived: (JavascriptMessage message) {
                  okraHandler =
                      new OkraHandler(true, true, false, false, message.message);
                }),
            JavascriptChannel(
                name: 'FlutterOnError',
                onMessageReceived: (JavascriptMessage message) {
                  okraHandler =
                      new OkraHandler(true, false, true, false,  message.message);
                }),
            JavascriptChannel(
                name: 'FlutterOnClose',
                onMessageReceived: (JavascriptMessage message) {
                  Navigator.pop(context, okraHandler);
                })
          ]),
          onWebViewCreated: (webViewController) {
            _controller = webViewController;
          }),
      isLoading ? Center( child: CircularProgressIndicator(),)
          : Container(width: 0, height: 0,  color: Colors.transparent),
    ]);
  }
}
