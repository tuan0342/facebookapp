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
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();  
    uriOfWebView = widget.webView.uri;
    controller = WebViewController()
                    ..setJavaScriptMode(JavaScriptMode.disabled)
                    ..setNavigationDelegate(
                      NavigationDelegate(
                        onPageStarted: (String url) {
                          setState(() {
                            loadingPercentage = 0;
                          });
                        },
                        onProgress: (int progress) {
                          setState(() {
                            loadingPercentage = progress;
                          });
                        },
                        onPageFinished: (String url) {
                          setState(() {
                            loadingPercentage = 100;
                          });
                        },
                      )
                    )
                    ..loadRequest(Uri.parse(uriOfWebView));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(title: widget.webView.titleOfAppBar),
      body: Stack(
          children: [
            WebViewWidget(
              controller: controller,
            ),
            if (loadingPercentage < 100)
              LinearProgressIndicator(
                value: loadingPercentage / 100.0,
              ),
          ],
        )
    );
  }
}

