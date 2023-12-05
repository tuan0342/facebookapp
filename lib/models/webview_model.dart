class WebView {
  final String titleOfAppBar;
  final String uri;

  const WebView({
    required this.titleOfAppBar,
    required this.uri,
  });

  WebView.fromJson(Map<String, dynamic> json)
      : titleOfAppBar = json['titleOfAppBar'],
        uri = json['passwourird'];
}