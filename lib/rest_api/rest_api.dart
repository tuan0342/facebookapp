import "dart:convert";

import "package:facebook_app/util/common.dart";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class ApiFailException implements Exception {}

class UnauthorizationException implements Exception {}

Future<http.Response> postMethod({
  required String endpoind,
  Object? body,
  Map<String, String>? headers,
  Map<String, String>? params,
}) async {
  try {
    final response = await http.post(
      getUri(endpoind: endpoind, params: params),
      body: jsonEncode(body ?? <String, dynamic>{}),
      headers: headers ??
          <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
    );

    return response;
  } catch (err) {
    debugPrint("get err: $err");
    throw ApiFailException();
  }
}

Future<http.Response> getMethod({
  required String endpoind,
  Map<String, dynamic>? params,
  Map<String, String>? headers,
}) async {
  try {
    final response = await http.get(
      getUri(endpoind: endpoind, params: params),
      headers: headers ??
          <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
    );
    return response;
  } catch (err) {
    debugPrint("get err: $err");
    throw ApiFailException();
  }
}

Future<http.Response> putMethod({
  required String endpoind,
  Object? body,
  Map<String, String>? headers,
}) async {
  try {
    final response = await http.put(
      getUri(endpoind: endpoind),
      body: jsonEncode(body ?? <String, dynamic>{}),
      headers: headers ??
          <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
    );

    return response;
  } catch (err) {
    debugPrint("get err: $err");
    throw ApiFailException();
  }
}

Future<http.Response> deleteMethod({
  required String endpoind,
  Object? body,
  Map<String, String>? headers,
}) async {
  try {
    final response = await http.delete(
      getUri(endpoind: endpoind),
      body: jsonEncode(body ?? <String, dynamic>{}),
      headers: headers ??
          <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
    );
    return response;
  } catch (err) {
    debugPrint("get err: $err");
    throw ApiFailException();
  }
}

Future<http.Response> patchMethod({
  required String endpoind,
  Object? body,
  Map<String, String>? headers,
}) async {
  try {
    final response = await http.patch(
      getUri(endpoind: endpoind),
      body: jsonEncode(body ?? <String, dynamic>{}),
      headers: headers ??
          <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
    );
    return response;
  } catch (err) {
    debugPrint("get err: $err");
    throw ApiFailException();
  }
}
