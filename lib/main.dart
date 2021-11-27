

import 'dart:io';

import "package:flutter/material.dart";
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  await Permission.camera.request();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebViewApp(),
    );
  }
}
    class WebViewApp extends StatefulWidget {
    @override
    _WebViewAppState createState() => new _WebViewAppState();
    }

    class _WebViewAppState extends State<WebViewApp> {
    late InAppWebViewController _webViewController;
    CookieManager _cookieManager = CookieManager.instance();

    @override
    void initState() {
    super.initState();
    }

    @override
    void dispose() {
    super.dispose();
    }
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(title: Text("transformationgym")),
          body: Container(
          child: Column(children: <Widget>[
          Expanded(
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse("https://transformationgym.in/")),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                //javaScriptCanOpenWindowsAutomatically: true,
                mediaPlaybackRequiresUserGesture: false,
              ),
              android: AndroidInAppWebViewOptions(supportMultipleWindows: true)),
            onWebViewCreated: (InAppWebViewController controller) {
              _webViewController = controller;
            },
            androidOnPermissionRequest: (InAppWebViewController controller, String origin, List<String> resources) async {
              return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
            },
            ),
          ),
          ]),
          ),
      );
  }
}