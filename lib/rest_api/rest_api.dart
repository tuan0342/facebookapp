import "dart:convert";
import "dart:io";

import "package:facebook_app/util/common.dart";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'package:http_parser/http_parser.dart';

class ApiFailException implements Exception {}

class UnauthorizationException implements Exception {}

class FileData {
  final String fieldName;
  final File file;
  final String type;
  final String subType;

  FileData(
      {required this.fieldName,
      required this.file,
      required this.type,
      required this.subType});
}

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

Future<http.Response> postWithFormDataMethod({
  required String endpoind,
  Map<String, String>? body,
  Map<String, String>? headers,
  Map<String, String>? params,
  List<FileData>? files,
}) async {
  try {
    var uri = getUri(endpoind: endpoind, params: params);

    var request = http.MultipartRequest('POST', uri);
    if (headers != null) {
      request.headers.addAll(headers);
    }

    if (body != null) {
      request.fields.addAll(body);
    }

    if (files != null) {
      await Future.forEach(
        files,
        (file) async => {
          request.files.add(await http.MultipartFile.fromPath(
            file.fieldName,
            file.file.path,
            contentType: MediaType(file.type, file.subType),
          ))
        },
      );
    }

    var responseStream = await request.send();

    final response = await http.Response.fromStream(responseStream);
    return response;
  } catch (err) {
    debugPrint("get err: $err");
    throw ApiFailException();
  }
}
