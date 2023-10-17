import 'dart:convert';

import 'package:flutter/material.dart';
import "package:facebook_app/util/common.dart";
import 'package:http/http.dart' as http;

void HandleResponse({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch(response.statusCode) {
    case 200:
      onSuccess();
      break;
    default:
      showSnackBar(context, jsonDecode(response.body)['Message']);
  }
}