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
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.id,
    this.name,
  });

  int id;
  Name name;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: Name.fromJson(json["name"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name.toJson(),
  };
}

class Name {
  Name({
    this.tk,
    this.ru,
    this.en,
  });

  String tk;
  String ru;
  String en;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
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
