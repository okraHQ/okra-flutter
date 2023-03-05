import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:okra_widget_official/models/okra_handler.dart';
import 'package:okra_widget_official/raw/okra_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

// #enddocregion platform_imports
class Web extends StatefulWidget {
  final Map<String, dynamic>? okraOptions;
  final String? shortUrl;
  final useShort;
  final Function(String data)? onSuccess;
  final Function(String message)? onError;
  final Function(String message)? onClose;
  final Function(String message)? beforeClose;

  Web(
      {Key? key,
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
  late final WebViewController _controller;
  double loadingPercentage = 0;
  String _initialUrl = '';

  bool isLoading = true;
  OkraHandler okraHandler =
      new OkraHandler(false, false, false, true, false, "");

  @override
  void initState() {
    super.initState();

    setInitialUrl(callback: initWebviewController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          WebViewWidget(
            controller: _controller,
            gestureRecognizers: [
              Factory(() => VerticalDragGestureRecognizer()),
              Factory(() => TapGestureRecognizer()),
            ].toSet(),
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(width: 0, height: 0, color: Colors.transparent),
        ]),
      ),
    );
  }

  void setInitialUrl({required void Function() callback}) {
    _initialUrl = widget.useShort
        ? Uri.dataFromString(
            buildOkraWidgetWithShortUrl(
              widget.shortUrl,
            ),
            mimeType: 'text/html',
          ).toString()
        : Uri.dataFromString(
            mBuildOkraWidgetWithOptions(
              widget.okraOptions!,
            ),
            mimeType: 'text/html',
          ).toString();
    callback();
  }

  void initWebviewController() {
    if (kDebugMode) {
      print(widget.shortUrl);
    }

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              loadingPercentage = progress.toDouble();
              debugPrint('WebView is loading (progress : $progress%)');
            });
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
            setState(() {
              loadingPercentage = 100;
            });
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            setState(() {
              isLoading = false;
            });
            // String jsonOptions = json.encode(widget.okraOptions);
            // _controller.evaluateJavascript("openOkraWidget('$jsonOptions')");
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
                Page resource error:
                code: ${error.errorCode}
                description: ${error.description}
                errorType: ${error.errorType}
                isForMainFrame: ${error.isForMainFrame}
            ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('<unwanted-url-here>')) {
            //   debugPrint('blocking navigation to ${request.url}');
            //   return NavigationDecision.prevent;
            // }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'FlutterOnSuccess',
        onMessageReceived: (JavaScriptMessage message) {
          // okraHandler =
          //     new OkraHandler(true, true, false, false, false, message.message);
          if (widget.onSuccess != null) {
            widget.onSuccess!(message.message);
          }
        },
      )
      ..addJavaScriptChannel(
        'FlutterOnError',
        onMessageReceived: (JavaScriptMessage message) {
          // okraHandler =
          //     new OkraHandler(true, false, true, false, false, jsonDecode(message.message)["data"]["error"].toString());
          if (widget.onError != null) {
            widget.onError!(
                jsonDecode(message.message)["data"]["error"].toString());
          }
        },
      )
      ..addJavaScriptChannel(
        'FlutterOnClose',
        onMessageReceived: (JavaScriptMessage message) {
          // okraHandler =
          // new OkraHandler(true, false, false, true, false, message.message);
          if (widget.onClose != null) {
            widget.onClose!(message.message);
          }
          Navigator.pop(context);
        },
      )
      ..addJavaScriptChannel(
        'FlutterBeforeClose',
        onMessageReceived: (JavaScriptMessage message) {
          // okraHandler =
          // new OkraHandler(true, false, false, false, true, message.message);
          if (widget.beforeClose != null) {
            widget.beforeClose!(message.message);
          }
        },
      )
      ..loadRequest(Uri.parse('$_initialUrl'));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }
}
