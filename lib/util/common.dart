import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:facebook_app/my_widgets/images_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Uri getUri({required String endpoind, Map<String, dynamic>? params}) {
  String queryParameters = "";
  params?.forEach((key, value) {
    queryParameters += '$key=$value&';
  });
  return Uri.parse('${dotenv.env['BACKEND_URL']}/$endpoind?$queryParameters');
}

void showSnackBar(
    {required BuildContext context, required String msg, int timeShow = 3000}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg),
    duration: Duration(milliseconds: timeShow),
  ));
}

Future<String?> getDeviceId() async {
  if (Platform.isAndroid) {
    AndroidId android = const AndroidId();
    return await android.getId();
  } else {
    final DeviceInfoPlugin plugin = DeviceInfoPlugin();
    final iosInfo = plugin.iosInfo;
    return iosInfo.toString();
  }
}

String getDifferenceTime(DateTime firstTime, DateTime secondTime) {
  Duration subtime = firstTime.difference(secondTime);
  if (subtime.inDays >= 7) {
    return "${(subtime.inDays / 7).round()} tuần trước";
  } else if (subtime.inDays > 0) {
    return "${subtime.inDays} ngày trước";
  } else if (subtime.inHours > 0) {
    return "${subtime.inHours} giờ trước";
  } else if (subtime.inMinutes > 0) {
    return "${subtime.inMinutes} phút trước";
  }
  return "Vừa xong";
}

void showPopupList(
    {required BuildContext context, required List<String> images}) async {
  final result = await showDialog(
      context: context,
      builder: (_) => ImagesDialog(
            images: images,
            index: 0,
          ));
  debugPrint(result);
}

const String INTERACTPOST = "interact post";
const String ACCEPTFRIEND = "accept friend";
const String REQUESTFRIEND = "request friend";

String? mapNotiDataToStringRoute(Map<String, dynamic> map) {
  switch (map["type"]) {
    case INTERACTPOST:
      final postId = map["postId"];
      return "/authenticated/postDetail/$postId";
    case ACCEPTFRIEND:
      final uid = map["friendId"];
      return "/authenticated/friends/$uid";
    case REQUESTFRIEND:
      return "/authenticated/1";
    default:
      return null;
  }
}
