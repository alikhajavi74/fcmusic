// PubDev main package: https://pub.dev/packages/http

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import 'mfw_prints.dart';

// --------------------------------------------------------------------------------------------------------------------

// Response class:

class MResponse extends Equatable {
  final int statusCode;
  final String stringResponse;
  final dynamic decodedResponse;

  static MResponse initialObject = const MResponse(statusCode: 0, stringResponse: "noResponse");

  const MResponse({required this.statusCode, required this.stringResponse, this.decodedResponse = const {"Response": "noResponse"}});

  @override
  List<Object?> get props => [statusCode, stringResponse, decodedResponse];

  @override
  bool? get stringify => true;
}

// --------------------------------------------------------------------------------------------------------------------

// Request with get method:

Future<MResponse> mGet({required String url, String? bearerToken, int timeOutDurationSeconds = 10}) async {
  try {
    http.Response response = await http.get(Uri.parse(url), headers: {HttpHeaders.authorizationHeader: bearerToken ?? ""}).timeout(Duration(seconds: timeOutDurationSeconds));
    return MResponse(
      statusCode: response.statusCode,
      stringResponse: utf8.decode(response.bodyBytes),
      decodedResponse: jsonDecode(utf8.decode(response.bodyBytes)),
    );
  } on SocketException catch (e) {
    mPrintRed("Disconnected\nURL:$url\n$e");
    return const MResponse(statusCode: 500, stringResponse: "اتصال شما برقرار نیست");
  } on TimeoutException catch (e) {
    mPrintRed("TimeOut\nURL:$url\n$e");
    return const MResponse(statusCode: 500, stringResponse: "اتصال شما ضعیف است");
  } on HandshakeException catch (e) {
    mPrintRed("Handshake\nURL:$url\n$e");
    return MResponse(statusCode: 501, stringResponse: e.message);
  } catch (e) {
    mPrintRed("UnknownError\nURL:$url\n$e");
    return const MResponse(statusCode: 600, stringResponse: "خطای نامشخص");
  }
}

// --------------------------------------------------------------------------------------------------------------------

// Request with post method:

Future<MResponse> mPost({required String url, String? bearerToken, Object? body, int timeOutDurationSeconds = 10}) async {
  try {
    http.Response response = await http.post(Uri.parse(url), headers: {HttpHeaders.authorizationHeader: bearerToken ?? ""}, body: body).timeout(Duration(seconds: timeOutDurationSeconds));
    return MResponse(
      statusCode: response.statusCode,
      stringResponse: utf8.decode(response.bodyBytes),
      decodedResponse: jsonDecode(utf8.decode(response.bodyBytes)),
    );
  } on SocketException catch (e) {
    mPrintRed("Disconnected\nURL:$url\n$e");
    return const MResponse(statusCode: 500, stringResponse: "اتصال شما برقرار نیست");
  } on TimeoutException catch (e) {
    mPrintRed("TimeOut\nURL:$url\n$e");
    return const MResponse(statusCode: 500, stringResponse: "اتصال شما ضعیف است");
  } on HandshakeException catch (e) {
    mPrintRed("Handshake\nURL:$url\n$e");
    return MResponse(statusCode: 501, stringResponse: e.message);
  } catch (e) {
    mPrintRed("UnknownError\nURL:$url\n$e");
    return const MResponse(statusCode: 600, stringResponse: "خطای نامشخص");
  }
}

// --------------------------------------------------------------------------------------------------------------------

// Request with put method:

Future<MResponse> mPut({required String url, String? bearerToken, Object? body, int timeOutDurationSeconds = 10}) async {
  try {
    http.Response response = await http.put(Uri.parse(url), headers: {HttpHeaders.authorizationHeader: bearerToken ?? ""}, body: body).timeout(Duration(seconds: timeOutDurationSeconds));
    return MResponse(
      statusCode: response.statusCode,
      stringResponse: utf8.decode(response.bodyBytes),
      decodedResponse: jsonDecode(utf8.decode(response.bodyBytes)),
    );
  } on SocketException catch (e) {
    mPrintRed("Disconnected\nURL:$url\n$e");
    return const MResponse(statusCode: 500, stringResponse: "اتصال شما برقرار نیست");
  } on TimeoutException catch (e) {
    mPrintRed("TimeOut\nURL:$url\n$e");
    return const MResponse(statusCode: 500, stringResponse: "اتصال شما ضعیف است");
  } on HandshakeException catch (e) {
    mPrintRed("Handshake\nURL:$url\n$e");
    return MResponse(statusCode: 501, stringResponse: e.message);
  } catch (e) {
    mPrintRed("UnknownError\nURL:$url\n$e");
    return const MResponse(statusCode: 600, stringResponse: "خطای نامشخص");
  }
}

// --------------------------------------------------------------------------------------------------------------------

// Request with delete method:

Future<MResponse> mDelete({required String url, String? bearerToken, Object? body, int timeOutDurationSeconds = 10}) async {
  try {
    http.Response response = await http.delete(Uri.parse(url), headers: {HttpHeaders.authorizationHeader: bearerToken ?? ""}, body: body).timeout(Duration(seconds: timeOutDurationSeconds));
    return MResponse(
      statusCode: response.statusCode,
      stringResponse: utf8.decode(response.bodyBytes),
      decodedResponse: jsonDecode(utf8.decode(response.bodyBytes)),
    );
  } on SocketException catch (e) {
    mPrintRed("Disconnected\nURL:$url\n$e");
    return const MResponse(statusCode: 500, stringResponse: "اتصال شما برقرار نیست");
  } on TimeoutException catch (e) {
    mPrintRed("TimeOut\nURL:$url\n$e");
    return const MResponse(statusCode: 500, stringResponse: "اتصال شما ضعیف است");
  } on HandshakeException catch (e) {
    mPrintRed("Handshake\nURL:$url\n$e");
    return MResponse(statusCode: 501, stringResponse: e.message);
  } catch (e) {
    mPrintRed("UnknownError\nURL:$url\n$e");
    return const MResponse(statusCode: 600, stringResponse: "خطای نامشخص");
  }
}

// --------------------------------------------------------------------------------------------------------------------

// Upload file:

Future<MResponse> uploadSingleFileWithOtherInfo({required String requestMethodType, required String url, String? fileField, String? filePath, required Map<String, String> otherFields, required String bearerToken, int timeOutDurationSeconds = 20}) async {
  http.MultipartRequest multipartRequest = http.MultipartRequest(requestMethodType, Uri.parse(url));

  if (fileField != null && filePath != null) {
    String mimLookup = lookupMimeType(filePath, headerBytes: [0xFF, 0xD8])!; // image/jpeg
    List<String> mimeTypeData = mimLookup.split('/');
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(fileField, filePath, contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    multipartRequest.files.add(multipartFile);
  }

  multipartRequest.fields.addAll(otherFields);

  multipartRequest.headers[HttpHeaders.authorizationHeader] = bearerToken;

  try {
    http.StreamedResponse streamedResponse = await multipartRequest.send().timeout(Duration(seconds: timeOutDurationSeconds));
    http.Response response = await http.Response.fromStream(streamedResponse);
    return MResponse(
      statusCode: response.statusCode,
      stringResponse: utf8.decode(response.bodyBytes),
      decodedResponse: jsonDecode(utf8.decode(response.bodyBytes)),
    );
  } on SocketException catch (e) {
    mPrintRed("Disconnected\nURL:$url\n$e");
    return const MResponse(statusCode: 500, stringResponse: "اتصال شما برقرار نیست");
  } on TimeoutException catch (e) {
    mPrintRed("TimeOut\nURL:$url\n$e");
    return const MResponse(statusCode: 500, stringResponse: "اتصال شما ضعیف است");
  } on HandshakeException catch (e) {
    mPrintRed("Handshake\nURL:$url\n$e");
    return MResponse(statusCode: 501, stringResponse: e.message);
  } catch (e) {
    mPrintRed("UnknownError\nURL:$url\n$e");
    return const MResponse(statusCode: 600, stringResponse: "خطای نامشخص");
  }
}

Future<MResponse> uploadSingleFile({required String requestMethodType, required String url, required String filePath, required String field, required String bearerToken, int timeOutDurationSeconds = 20}) async {
  String mimLookup = lookupMimeType(filePath, headerBytes: [0xFF, 0xD8])!; // image/jpeg
  List<String> mimeTypeData = mimLookup.split('/');
  http.MultipartRequest multipartRequest = http.MultipartRequest(requestMethodType, Uri.parse(url));
  http.MultipartFile multipartFile = await http.MultipartFile.fromPath(field, filePath, contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
  multipartRequest.files.add(multipartFile);

  multipartRequest.headers[HttpHeaders.authorizationHeader] = bearerToken;

  try {
    http.StreamedResponse streamedResponse = await multipartRequest.send().timeout(Duration(seconds: timeOutDurationSeconds));
    http.Response response = await http.Response.fromStream(streamedResponse);
    return MResponse(
      statusCode: response.statusCode,
      stringResponse: utf8.decode(response.bodyBytes),
      decodedResponse: jsonDecode(utf8.decode(response.bodyBytes)),
    );
  } on SocketException catch (e) {
    mPrintRed("Disconnected\nURL:$url\n$e");
    return const MResponse(statusCode: 500, stringResponse: "اتصال شما برقرار نیست");
  } on TimeoutException catch (e) {
    mPrintRed("TimeOut\nURL:$url\n$e");
    return const MResponse(statusCode: 500, stringResponse: "اتصال شما ضعیف است");
  } on HandshakeException catch (e) {
    mPrintRed("Handshake\nURL:$url\n$e");
    return MResponse(statusCode: 501, stringResponse: e.message);
  } catch (e) {
    mPrintRed("UnknownError\nURL:$url\n$e");
    return const MResponse(statusCode: 600, stringResponse: "خطای نامشخص");
  }
}

// --------------------------------------------------------------------------------------------------------------------

// Handle server errors:

String handleError(dynamic errorDecodedResponse) {
  StringBuffer finalString = StringBuffer();
  if (errorDecodedResponse is Map) {
    finalString.write(handleErrorMap(errorDecodedResponse));
  } else if (errorDecodedResponse is List) {
    finalString.write(handleErrorList(errorDecodedResponse));
  } else if (errorDecodedResponse is String) {
    finalString.write(errorDecodedResponse);
  } else {
    finalString.write("Unknown Error #handleError");
  }
  return removeLastVerticalTabs(finalString.toString());
}

String handleErrorMap(Map errorMap) {
  StringBuffer finalString = StringBuffer();

  for (var value in errorMap.values) {
    if (value is List) {
      finalString.write(handleErrorList(value));
    } else if (value is Map) {
      finalString.write(handleErrorMap(value));
    } else {
      finalString.write(value.toString());
      finalString.write("\n");
    }
  }

  return finalString.toString();
}

String handleErrorList(List errorList) {
  StringBuffer finalString = StringBuffer();

  for (var value in errorList) {
    if (value is List) {
      finalString.write(handleErrorList(value));
    } else if (value is Map) {
      finalString.write(handleErrorMap(value));
    } else {
      finalString.write(value.toString());
      finalString.write("\n");
    }
  }

  return finalString.toString();
}

String removeLastVerticalTabs(String text) {
  List<String> characters = text.split("");
  while (characters.last == "\n") {
    characters.removeLast();
  }
  return characters.join();
}

// --------------------------------------------------------------------------------------------------------------------
