import 'dart:convert';

import 'package:flutter/material.dart';
import "package:facebook_app/util/common.dart";
import 'package:http/http.dart' as http;

void handleResponse({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  debugPrint("status code: ${response.statusCode}");
  switch(response.statusCode) {
    case 200:
      onSuccess();
      break;
    default:
      showSnackBar(context: context, msg: "other status code: ${response.statusCode}");
  }
}