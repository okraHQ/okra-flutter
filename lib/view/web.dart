import 'dart:convert';
import 'dart:io';

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
  final Function(String message)? onEvent;

  Web({
    Key? key,
    this.okraOptions,
    this.shortUrl,
    required this.useShort,
    this.onError,
    this.beforeClose,
    this.onClose,
    this.onSuccess,
    this.onEvent,
  }) : super(key: key);

  @override
  _WebState createState() => _WebState();
}

class _WebState extends State<Web> {
  late WebViewController _controller;
  bool isLoading = true;
  OkraHandler okraHandler =
      new OkraHandler(false, false, false, true, false, "");

  void onFlutterSuccess(JavaScriptMessage message) {
    if (widget.onSuccess != null) {
      widget.onSuccess!(message.message);
    }
  }

  void onFlutterError(JavaScriptMessage message) {
    if (widget.onError != null) {
      widget.onError!(jsonDecode(message.message)["data"]["error"].toString());
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

  void onFlutterEvent(JavaScriptMessage message) {
    if (widget.onEvent != null) {
      widget.onEvent!(message.message);
    }
  }

  void onPageLoaded(String _) {
    setState(() {
      isLoading = false;
    });
  }

  String getUrl(bool useShort) {
    if (useShort) {
      return buildOkraWidgetWithShortUrl(
        widget.shortUrl,
        widget.okraOptions
      );
    } else
      return mBuildOkraWidgetWithOptions(
        widget.okraOptions!,
      );
  }

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel("FlutterOnSuccess",
          onMessageReceived: onFlutterSuccess)
      ..addJavaScriptChannel("FlutterOnError",
          onMessageReceived: onFlutterError)
      ..addJavaScriptChannel("FlutterOnClose",
          onMessageReceived: onFlutterClose)
      ..addJavaScriptChannel("FlutterBeforeClose",
          onMessageReceived: onFlutterBeforeClose)
      ..addJavaScriptChannel("FlutterOnEvent",
          onMessageReceived: onFlutterEvent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: onPageLoaded,
          onNavigationRequest: (NavigationRequest request) {
            if(Platform.isAndroid) {
              return NavigationDecision.prevent;
            }
            return  NavigationDecision.navigate;
          },
        ),
      )
      ..setUserAgent("Flutter;Webview")
      ..loadHtmlString(getUrl(widget.useShort));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null,
      body: SafeArea(
        child: Stack(children: [
          WebViewWidget(controller: _controller),
          isLoading
              ? Container(width: 0, height: 0, color: Colors.transparent)
              : Container(width: 0, height: 0, color: Colors.transparent),
        ]),
      ),
    );
  }
}
