import 'package:flutter/material.dart';
import 'package:flutter_evaluation/data/model/response/articles.dart';
import 'package:flutter_evaluation/data/model/response/search_model.dart';

// ignore: must_be_immutable
class ArticlesCell extends StatelessWidget {
  Article? article;
  SearchData? searchArticle;

  // ignore: use_key_in_widget_constructors
  ArticlesCell({this.article, this.searchArticle});

  @override
  Widget build(BuildContext context) {
    String getTitle() {
      String returnValue = "";
      if (article != null) {
        returnValue = article!.title ?? "";
      } else if (searchArticle != null) {
        returnValue = searchArticle!.docAbstract ?? "";
      }
      return returnValue;
    }

    String getDate() {
      String returnValue = "";
      if (article != null) {
        returnValue = article!.publishedDate ?? "";
      } else if (searchArticle != null) {
        returnValue = searchArticle!.pubDate ?? "";
      }
      return returnValue;
    }

    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 16, bottom: 5),
            child: Text(
              getTitle(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              getDate(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Divider(
            height: 2,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
