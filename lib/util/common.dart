import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
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
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), duration: Duration(milliseconds: timeShow),));
}

Future<String?> getDeviceId() async{
  if (Platform.isAndroid) {
        AndroidId android = const AndroidId();
        return await android.getId();
      } else {
        final DeviceInfoPlugin plugin = DeviceInfoPlugin();
        final iosInfo = plugin.iosInfo;
        return iosInfo.toString();
      }
}