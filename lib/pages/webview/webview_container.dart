import 'package:facebook_app/models/webview_model.dart';
import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  final WebView webView;
  const WebViewContainer({super.key, required this.webView});

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  late String uriOfWebView;
  var controller;

  @override
  void initState() {
    super.initState();  
    uriOfWebView = widget.webView.uri;
    controller = WebViewController()
                    ..setJavaScriptMode(JavaScriptMode.disabled)
                    ..loadRequest(Uri.parse(uriOfWebView));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(title: widget.webView.titleOfAppBar),
      body: SafeArea(
        child: WebViewWidget(controller: controller)
      ),
    );
  }
}

