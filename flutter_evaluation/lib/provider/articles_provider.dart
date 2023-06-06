import 'package:flutter/material.dart';
import 'package:flutter_evaluation/data/repository/articles_repo.dart';

import '../Database/database_helper.dart';
import '../data/model/base/api_response.dart';
import '../data/model/base/error_response.dart';
import '../data/model/response/articles.dart';
import 'dart:io';

class ArticlesProvider with ChangeNotifier {
  final ArticlesRepo articlesRepo;
  ArticlesProvider({required this.articlesRepo});

  bool _isLoading = false;
  late List<Article> _articles = [];

  bool get isLoading => _isLoading;
  List<Article> get articlesList => _articles;

  final dbHelper = DatabaseHelper();

  Future<bool> isInternetConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  void _insertMostViewed(Article article) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: article.title,
      DatabaseHelper.columnId: article.id,
      DatabaseHelper.columnDate: article.publishedDate
    };
    await dbHelper.insertMostViewed(row);
  }

  void _insertMostShared(Article article) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: article.title,
      DatabaseHelper.columnId: article.id,
      DatabaseHelper.columnDate: article.publishedDate
    };
    await dbHelper.insertMostShared(row);
  }

  void _insertMostEmailed(Article article) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: article.title,
      DatabaseHelper.columnId: article.id,
      DatabaseHelper.columnDate: article.publishedDate
    };
    await dbHelper.insertMostEmailed(row);
  }

  Future getMostEmailed({
    required BuildContext context,
  }) async {
    await dbHelper.init();

    bool isConnected = await isInternetConnected();

    if (isConnected) {
      _isLoading = true;
      notifyListeners();

      ApiResponse apiResponse = await articlesRepo.getMostEmailed();
      _isLoading = false;

      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        Map<String, dynamic> articlesData = apiResponse.response!.data;
        final rootModel = ArticlesBaseModel.fromJson(articlesData);
        if (rootModel.articles != null) {
          _articles = rootModel.articles!;
          await dbHelper.deleteMostEmailed();
          for (var article in _articles) {
            _insertMostEmailed(article);
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
    } else {
      List<Article> mapArticles = [];
      final dbArticles = await dbHelper.getMostEmailed();
      for (final dbArticle in dbArticles) {
        final mapArticle = Article.fromJson(dbArticle);
        mapArticles.add(mapArticle);
        _articles = mapArticles;
        notifyListeners();
      }
    }
  }

  Future getMostShared({
    required BuildContext context,
  }) async {
    await dbHelper.init();

    bool isConnected = await isInternetConnected();

    if (isConnected) {
      _isLoading = true;
      notifyListeners();
      ApiResponse apiResponse = await articlesRepo.getMostShared();
      _isLoading = false;

      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        Map<String, dynamic> articlesData = apiResponse.response!.data;
        final rootModel = ArticlesBaseModel.fromJson(articlesData);
        if (rootModel.articles != null) {
          _articles = rootModel.articles!;
          await dbHelper.deleteMostShared();
          for (var article in _articles) {
            _insertMostShared(article);
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
    } else {
      List<Article> mapArticles = [];
      final dbArticles = await dbHelper.getMostShared();
      for (final dbArticle in dbArticles) {
        final mapArticle = Article.fromJson(dbArticle);
        mapArticles.add(mapArticle);
        _articles = mapArticles;
        notifyListeners();
      }
    }
  }

  Future getMostViewed({
    required BuildContext context,
  }) async {
    await dbHelper.init();

    bool isConnected = await isInternetConnected();

    if (isConnected) {
      _isLoading = true;
      notifyListeners();
      ApiResponse apiResponse = await articlesRepo.getMostViewed();
      _isLoading = false;

      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        Map<String, dynamic> articlesData = apiResponse.response!.data;
        final rootModel = ArticlesBaseModel.fromJson(articlesData);
        if (rootModel.articles != null) {
          _articles = rootModel.articles!;
          await dbHelper.deleteMostViewed();
          for (var article in _articles) {
            _insertMostViewed(article);
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
    } else {
      List<Article> mapArticles = [];
      final dbArticles = await dbHelper.getMostViewed();
      for (final dbArticle in dbArticles) {
        final mapArticle = Article.fromJson(dbArticle);
        mapArticles.add(mapArticle);
        _articles = mapArticles;
        notifyListeners();
      }
    }
  }
}
