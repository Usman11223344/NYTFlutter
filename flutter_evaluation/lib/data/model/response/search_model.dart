class SearchBaseModel {
  String? status;
  SearchResponse? response;

  SearchBaseModel({
    this.status,
    this.response,
  });

  factory SearchBaseModel.fromJson(Map<String, dynamic> json) =>
      SearchBaseModel(
        status: json["status"],
        response: json["response"] == null
            ? null
            : SearchResponse.fromJson(json["response"]),
      );
}

class SearchResponse {
  List<SearchData>? docs;

  SearchResponse({
    this.docs,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        docs: json["docs"] == null
            ? []
            : List<SearchData>.from(
                json["docs"]!.map((x) => SearchData.fromJson(x))),
      );
}

class SearchData {
  String? docAbstract;
  String? pubDate;
  String? id;

  SearchData({
    this.docAbstract,
    this.pubDate,
    this.id,
  });

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
        docAbstract: json["abstract"],
        pubDate: json["pub_date"],
        id: json["_id"],
      );
}
