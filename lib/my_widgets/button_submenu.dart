import 'package:facebook_app/models/webview_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonSubmenu extends StatelessWidget {
  final String title;
  final String icon;
  final String description;
  final String route;
  final WebView? webView;
  final Color? color;

  const ButtonSubmenu({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
    required this.route,
    this.webView,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          if (webView == null) {
            context.push(route);
          } else {
            context.push(route, extra: webView);
          }
        },
        child: Row(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Image.asset(icon, height: 35, width: 35)),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 13, 0, 5),
                  child: Text(
                    title,
                    style: TextStyle(color: color, fontSize: 18.0),
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 105, 105, 105)),
                )
              ],
            )),
          ],
        ));
  }
}
