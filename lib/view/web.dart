import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:okra_widget_official/models/okra_handler.dart';
import 'package:okra_widget_official/raw/okra_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Web extends StatefulWidget {
  final Map<String, dynamic>? okraOptions;
  final String? shortUrl;
  final bool useShort;
  final Function(String data)? onSuccess;
  final Function(String message)? onError;
  final Function(String message)? onClose;
  final Function(String message)? beforeClose;

  Web(
      {Key? key,
      this.okraOptions,
      this.shortUrl,
      required this.useShort,
      this.onError,
      this.beforeClose,
      this.onClose,
      this.onSuccess})
      : super(key: key);

  @override
  _WebState createState() => _WebState();
}

class _WebState extends State<Web> {
  late WebViewController _controller;
  bool isLoading = true;
  OkraHandler okraHandler =
      new OkraHandler(false, false, false, true, false, "");

  @override
  Widget build(BuildContext context) {
    void onFlutterSuccess(JavaScriptMessage message) {
      if (widget.onSuccess != null) {
        widget.onSuccess!(message.message);
      }
    }

    void onFlutterError(JavaScriptMessage message) {
      if (widget.onError != null) {
        widget.onError!(jsonDecode(message.message)["data"]["error"]
            .toString());
      }
    }

    void onFlutterClose(JavaScriptMessage message) {
      if (widget.onClose != null) {
        widget.onClose!(message.message);
      }
      Navigator.pop(context);
    }

    void onFlutterBeforeClose(JavaScriptMessage message) {
      if (widget.beforeClose != null) {
        widget.beforeClose!(message.message);
      }
    }

    void onPageLoaded(String _) {
      setState(() {
        isLoading = false;
      });
    }

    String getUrl(bool useShort) {
      if(useShort) {
        return
          buildOkraWidgetWithShortUrl(
            widget.shortUrl,
          );

      } else return
        mBuildOkraWidgetWithOptions(
          widget.okraOptions!,
        );
    }

    print(getUrl(widget.useShort));
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel("FlutterOnSuccess", onMessageReceived: onFlutterSuccess)
      ..addJavaScriptChannel("FlutterOnError", onMessageReceived: onFlutterError)
      ..addJavaScriptChannel("FlutterOnClose", onMessageReceived: onFlutterClose)
      ..addJavaScriptChannel("FlutterBeforeClose", onMessageReceived: onFlutterBeforeClose)
      ..setNavigationDelegate( NavigationDelegate(onPageFinished: onPageLoaded) )
      ..loadHtmlString(getUrl(widget.useShort));
    return Stack(children: [
      WebViewWidget(controller: _controller),
      isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(width: 0, height: 0, color: Colors.transparent),
    ]);
  }
}
