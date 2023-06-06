class ArticlesBaseModel {
  String? status;
  int? numResults;
  List<Article>? articles;

  ArticlesBaseModel({
    this.status,
    this.numResults,
    this.articles,
  });

  factory ArticlesBaseModel.fromJson(Map<String, dynamic> json) =>
      ArticlesBaseModel(
        status: json["status"],
        numResults: json["num_results"],
        articles: json["results"] == null
            ? []
            : List<Article>.from(
                json["results"]!.map((x) => Article.fromJson(x))),
      );
}

class Article {
  int? id;
  String? publishedDate;
  String? title;

  Article({
    this.id,
    this.publishedDate,
    this.title,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json["id"],
        publishedDate: json["published_date"],
        title: json["title"],
      );
}
