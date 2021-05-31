import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:okra_widget/models/okra_handler.dart';
import 'package:okra_widget/okra_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Web extends StatefulWidget {
  final Map<String, dynamic> okraOptions;

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
          initialUrl: "https://mobile.okra.ng/",
          onPageFinished: (response) {
            setState(() {isLoading = false;});
            String jsonOptions = json.encode(widget.okraOptions);
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
                name: 'FlutterCallFunction',
                onMessageReceived: (JavascriptMessage message) async {
                  print('Message -- ${message.message}');
                   Map<String, dynamic> data = json.decode(message.message);
                  var response =  await callFunction(data["targetFunc"],data["data"]);
                  Map<String, dynamic> jsonData = {"isSuccessfull":true,"args":[response]};
                  data.addAll(jsonData);
                  if(data["targetFunc"] == "openUSSD"){
                    data["data"] = "";
                  }
                  var jsonString = JsonEncoder().convert(data);
                 await _controller.evaluateJavascript("flutterResponseHandler('${jsonString}')");
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

callFunction(functionName,data) async {
  print('FUNCTION NAME -- $functionName');
  print('FUNCTION DATA -- $data');
  if (functionName == "hasUssdFeature") {
    return true;
  }else if(functionName == "permissionOn"){
   return await OkraWidget.checkPermissions(data);
} else if (functionName == "askForPermission"){
    await OkraWidget.askForPermissions(data);
    return "";
  }else if(functionName == "openUSSD"){
    await OkraWidget.openUSSD(data);
    return "";
  }else if(functionName == "startUSSDPayment"){
    await OkraWidget.startUSSDPayment(data);
    return "";
  }

}
