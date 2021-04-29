/*class NewsModel {
  String title;
  String content;
  String image;
  int id;

  NewsModel({this.id, this.title, this.content, this.image});
}*/

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  String next;
  dynamic previous;
  List<NewsModel> results;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<NewsModel>.from(json["results"].map((x) => NewsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class NewsModel {
  NewsModel({
    this.id,
    this.title,
    this.content,
    this.publishDate,
    this.image,
    this.views,
    this.source,
  });

  int id;
  Content title;
  Content content;
  DateTime publishDate;
  String image;
  int views;
  String source;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json["id"],
        title: Content.fromJson(json["title"]),
        content: Content.fromJson(json["content"]),
        publishDate: DateTime.parse(json["publish_date"]),
        image: json["image"],
        views: json["views"],
        source: json["source"] == null ? null : json["source"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title.toJson(),
        "content": content.toJson(),
        "publish_date": publishDate.toIso8601String(),
        "image": image,
        "views": views,
        "source": source == null ? null : source,
      };
}

class Content {
  Content({
    this.tk,
    this.ru,
    this.en,
  });

  String tk;
  String ru;
  String en;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        tk: json["tk"],
        ru: json["ru"],
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "tk": tk,
        "ru": ru,
        "en": en,
      };
}
