import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Uri getUri({required String endpoind, Map<String, dynamic>? params}) {
  String queryParameters = "";
  params?.forEach((key, value) {
    queryParameters += '$key=$value&';
  });
  return Uri.parse('${dotenv.env['BACKEND_URL']}/$endpoind?$queryParameters');
}

void showSnackBar({required BuildContext context,required String msg, int timeShow = 4000}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), duration: Duration(microseconds: timeShow),));
}