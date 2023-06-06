import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_evaluation/data/model/response/search_model.dart';
import 'package:flutter_evaluation/provider/articles_provider.dart';
import 'package:flutter_evaluation/screens/articles_cell.dart';
import 'package:provider/provider.dart';
import '../data/model/response/articles.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class Articles extends StatefulWidget {
  String? type;
  List<SearchData>? articles;
  // ignore: use_key_in_widget_constructors
  Articles({this.type, this.articles});

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  @override
  void initState() {
    super.initState();

    if (widget.articles == null) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        getArticles(context);
      });
    }
  }

  Future<void> getArticles(BuildContext context) async {
    switch (widget.type) {
      case "Viewed":
        await Provider.of<ArticlesProvider>(context, listen: false)
            .getMostViewed(context: context);
        break;
      case "Shared":
        await Provider.of<ArticlesProvider>(context, listen: false)
            .getMostShared(context: context);
        break;
      case "Emailed":
        await Provider.of<ArticlesProvider>(context, listen: false)
            .getMostEmailed(context: context);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final articlesList = Provider.of<ArticlesProvider>(context).articlesList;
    final preloadedArticles = widget.articles;
    final isLoading = Provider.of<ArticlesProvider>(context).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Articles"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: preloadedArticles == null
                  ? articlesList.length
                  : widget.articles!.length,
              itemBuilder: (BuildContext context, int index) {
                return ArticlesCell(
                  article:
                      preloadedArticles == null ? articlesList[index] : null,
                  searchArticle: preloadedArticles != null
                      ? preloadedArticles[index]
                      : null,
                );
              },
            ),
    );
  }
}
