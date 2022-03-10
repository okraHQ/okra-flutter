import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:okra_widget/models/okra_handler.dart';
import 'package:okra_widget/raw/okra_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Web extends StatefulWidget {
  final Map<String, dynamic> okraOptions;
  final String shortUrl;
  final useShort;
  Function(String data) onSuccess;
  Function(String message) onError;
  Function(String message) onClose;
  Function(String message) beforeClose;

   Web({Key key,
    this.okraOptions,
    this.shortUrl,
    this.useShort,
    this.onError,
    this.beforeClose,
    this.onClose,
    this.onSuccess})
      : super(key: key);

  @override
  _WebState createState() => _WebState();
}

class _WebState extends State<Web> {
  WebViewController _controller;
  bool isLoading = true;
  OkraHandler okraHandler = new OkraHandler(false, false, false, true, false, "");

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      WebView(

          // initialUrl: "https://mobile.okra.ng/",
          initialUrl: widget.useShort
              ?
              Uri.dataFromString(
                buildOkraWidgetWithShortUrl(
                  widget.shortUrl,
                ),
                mimeType: 'text/html',
              ).toString()
              :
              Uri.dataFromString(
                mBuildOkraWidgetWithOptions(
                  widget.okraOptions,
                ),
                mimeType: 'text/html',
              ).toString(),
          onPageFinished: (response) {
            setState(() {isLoading = false;});
            // String jsonOptions = json.encode(widget.okraOptions);
            // _controller.evaluateJavascript("openOkraWidget('$jsonOptions')");
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
                  // okraHandler =
                  //     new OkraHandler(true, true, false, false, false, message.message);
                  if(widget.onSuccess !=null) {
                    widget.onSuccess(message.message);
                  }
                }),
            JavascriptChannel(
                name: 'FlutterOnError',
                onMessageReceived: (JavascriptMessage message) {
                  // okraHandler =
                  //     new OkraHandler(true, false, true, false, false, jsonDecode(message.message)["data"]["error"].toString());
                  if(widget.onError !=null) {
                    widget.onError(jsonDecode(message.message)["data"]["error"].toString());
                  }
                }),
            JavascriptChannel(
                name: 'FlutterOnClose',
                onMessageReceived: (JavascriptMessage message) {
                  // okraHandler =
                  // new OkraHandler(true, false, false, true, false, message.message);
                  if(widget.onClose !=null) {
                    widget.onClose(message.message);
                  }
                  Navigator.pop(context);
                }),
            JavascriptChannel(
                name: 'FlutterBeforeClose',
                onMessageReceived: (JavascriptMessage message) {
                  // okraHandler =
                  // new OkraHandler(true, false, false, false, true, message.message);
                  if(widget.beforeClose !=null) {
                    widget.beforeClose(message.message);
                  }
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
