import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatelessWidget {
  final String url;
  WebviewPage({this.url});

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: url,
    );
  }
}