import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_evaluation/data/model/base/error_response.dart';

class ApiErrorHandler {
  static dynamic getMessage(error) {
    dynamic errorDescription = "";
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              errorDescription = "Request to API server was cancelled";
              break;
            case DioErrorType.connectTimeout:
              errorDescription = "Connection timeout with API server";
              break;
            case DioErrorType.other:
              errorDescription =
                  "Connection to API server failed due to internet connection";
              break;
            case DioErrorType.receiveTimeout:
              errorDescription =
                  "Receive timeout in connection with API server";
              break;
            case DioErrorType.response:
              switch (error.response!.statusCode) {
                case 400:
                  Map map = error.response!.data;
                  print(map["message"]);
                  if (map["message"] is String) {
                    debugPrint("400: " + map["message"]);
                    errorDescription = map["message"].toString();
                  } else if (map["message"] is Map<String, dynamic>) {
                    Map<String, dynamic> object = map["message"];
                    if (object["password"] is List<dynamic>) {
                      List<dynamic> list = object["password"];
                      if (list.isNotEmpty) {
                        if (list[0] is String) {
                          debugPrint("400: " + list[0]);
                          errorDescription = list[0];
                        } else {
                          debugPrint("400: Something went wrong!!!!!!!!");
                          errorDescription = "Something went wrong";
                        }
                      }
                    } else if (object["email"] is List<dynamic>) {
                      List<dynamic> list = object["email"];
                      if (list.isNotEmpty) {
                        if (list[0] is String) {
                          debugPrint("400: " + list[0]);
                          errorDescription = list[0];
                        } else {
                          debugPrint("400: Something went wrong!!!!!!!!");
                          errorDescription = "Something went wrong";
                        }
                      }
                    } else if (object["username"] is List<dynamic>) {
                      List<dynamic> list = object["username"];
                      if (list.isNotEmpty) {
                        if (list[0] is String) {
                          debugPrint("400: " + list[0]);
                          errorDescription = list[0];
                        } else {
                          debugPrint("400: Something went wrong!!!!!!!!");
                          errorDescription = "Something went wrong";
                        }
                      }
                    } else if (object["city"] is List<dynamic>) {
                      List<dynamic> list = object["city"];
                      if (list.isNotEmpty) {
                        if (list[0] is String) {
                          debugPrint("400: " + list[0]);
                          errorDescription = list[0];
                        } else {
                          debugPrint("400: Something went wrong!!!!!!!!");
                          errorDescription = "Something went wrong";
                        }
                      }
                    }
                  } else {
                    debugPrint("400: Something went wrong!!!!!!!!");
                    errorDescription = "Something went wrong";
                  }
                  break;
                case 401:
                  debugPrint("401: Unauthorized !");
                  errorDescription = "Unauthorized, Login to continue!";
                  break;
                case 404:
                  debugPrint("404: Page Not Found !");
                  errorDescription = "Something went wrong!";
                  break;
                case 405:
                  debugPrint("405: Invalid Method Type !");
                  errorDescription = "Something went wrong!";
                  break;
                case 500:
                case 503:
                  errorDescription = error.response!.statusMessage;
                  break;
                default:
                  ErrorResponse errorResponse =
                      ErrorResponse.fromJson(error.response!.data);
                  if (errorResponse.errors != null &&
                      errorResponse.errors!.length > 0)
                    errorDescription = errorResponse;
                  else
                    errorDescription =
                        "Failed to load data - status code: ${error.response!.statusCode}";
              }
              break;
            case DioErrorType.sendTimeout:
              errorDescription = "Send timeout with server";
              break;
          }
        } else {
          errorDescription = "Unexpected error occured";
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = "is not a subtype of exception";
    }
    return errorDescription;
  }
}
