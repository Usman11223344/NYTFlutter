import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  int maxCharactersPerLine = 200;

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint("--> ${options.method} ${options.baseUrl}${options.path}");
    debugPrint("Data ${options.data}");
    debugPrint("Query Params ${options.queryParameters}");
    debugPrint("Headers: ${options.headers.toString()}");
    debugPrint("<-- END HTTP");

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    debugPrint(
        "<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.baseUrl}${response.requestOptions.path}");

    String responseAsString = response.data.toString();

    debugPrint(responseAsString);

    // if (responseAsString.length > maxCharactersPerLine) {
    //   print("testing");
    //   int iterations = (responseAsString.length / maxCharactersPerLine).floor();
    //   for (int i = 0; i <= iterations; i++) {
    //     int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
    //     if (endingIndex > responseAsString.length) {
    //       endingIndex = responseAsString.length;
    //     }
    //     debugPrint(
    //         responseAsString.substring(i * maxCharactersPerLine, endingIndex));
    //   }
    // } else {
    //   print("objectttttttttt");
    //   debugPrint(response.data);
    // }

    debugPrint("<-- END HTTP");

    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    debugPrint(
        "ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.baseUrl}${err.requestOptions.path}");
    return super.onError(err, handler);
  }
}
