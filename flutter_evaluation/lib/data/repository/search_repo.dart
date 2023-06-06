import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_evaluation/data/datasource/api_error_handler.dart';
import 'package:flutter_evaluation/data/datasource/dio_client.dart';
import 'package:flutter_evaluation/data/model/base/api_response.dart';
import 'package:flutter_evaluation/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  SearchRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> searchArticles(String query) async {
    try {
      Map<String, dynamic> queryParams = {
        "q": query,
        "api-key": AppConstants.appKey,
      };
      Response response = await dioClient.get(
        AppConstants.searchURI,
        queryParameters: queryParams,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
