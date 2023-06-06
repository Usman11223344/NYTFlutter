import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_evaluation/data/datasource/api_error_handler.dart';
import 'package:flutter_evaluation/data/datasource/dio_client.dart';
import 'package:flutter_evaluation/data/model/base/api_response.dart';
import 'package:flutter_evaluation/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticlesRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  ArticlesRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> getMostEmailed() async {
    try {
      Map<String, dynamic> queryParams = {
        "api-key": AppConstants.appKey,
      };
      Response response = await dioClient.get(
        AppConstants.emailedURI,
        queryParameters: queryParams,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getMostShared() async {
    try {
      Map<String, dynamic> queryParams = {
        "api-key": AppConstants.appKey,
      };
      Response response = await dioClient.get(
        AppConstants.sharedURI,
        queryParameters: queryParams,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getMostViewed() async {
    try {
      Map<String, dynamic> queryParams = {
        "api-key": AppConstants.appKey,
      };
      Response response = await dioClient.get(
        AppConstants.viewedURI,
        queryParameters: queryParams,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
