import 'package:flutter/material.dart';
import '../data/model/base/api_response.dart';
import '../data/model/base/error_response.dart';
import '../data/model/response/search_model.dart';
import '../data/repository/search_repo.dart';

class SearchProvider with ChangeNotifier {
  final SearchRepo searchRepo;
  SearchProvider({required this.searchRepo});

  bool _isLoading = false;
  late List<SearchData> _articles = [];

  bool get isLoading => _isLoading;
  List<SearchData> get articlesList => _articles;

  Future searchArticles({
    required BuildContext context,
    required String query,
    required Function callback,
  }) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await searchRepo.searchArticles(query);
    _isLoading = false;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> articlesData = apiResponse.response!.data;
      final rootModel = SearchBaseModel.fromJson(articlesData);
      if (rootModel.response != null) {
        if (rootModel.response!.docs != null) {
          _articles = rootModel.response!.docs!;
          callback(_articles);
        }
      }

      notifyListeners();
    } else {
      String? errorMessage;
      if (apiResponse.error is String) {
        debugPrint(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        debugPrint(errorResponse.errors![0].message);
        errorMessage = errorResponse.errors![0].message;
      }
      if (errorMessage != null) {
        debugPrint(errorMessage);
      }
      notifyListeners();
    }
  }
}
