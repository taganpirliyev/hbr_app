import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:hbr_app/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:hbr_app/global.dart' as globals;


/*class News {
  List<NewsModel> news = [];

  Future<void> getNews(newsUrl) async {
*//*
    String url = "http://192.168.30.111:8000/api/posts";
*//*

    var response = await http.get(Uri.parse(newsUrl));
    var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    globals.nextUrl = jsonData['next'];
    globals.previousUrl = jsonData['previous'];
    print(globals.previousUrl);
*//*
    var previous = jsonData ['previous'];
*//*
    if (jsonData['count'] > 0) {
      jsonData["results"].forEach((element) {
        if (element["id"] != "") {
*//*
          print(element['next']);
*//*
          NewsModel newsModel = NewsModel(
            id: element['id'],
            image: element['image'],
            title: Content(en: element['title']['tk']),
          );
          news.add(newsModel);
        }
      });
    }
  }
}*/

class NewsViewClass {
  List<NewsModel> news = [];
  Future<void> getNews(String sid) async {
/*
    print(sid);
*/

    var response =
        await http.get(Uri.parse("http://192.168.30.111:8000/api/posts/$sid"));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(utf8.decode(response.bodyBytes));

      if (jsonData["id"] != 0) {
/*
        print(jsonData['content']['tk']);
*/

        NewsModel newsModel = NewsModel(
          id: jsonData['id'],
          image: jsonData['image'],
          title: Content(en: jsonData['title']['tk']),
          content: Content(en: jsonData['content']['tk']),
        );
        news.add(newsModel);
      }
    }
  }
}

class CategoryViewClass {
  List<NewsModel> news = [];

  Future<void> getNews(String cid) async {
    var response = await http.get(
        Uri.parse("http://192.168.30.111:8000/api/categories/$cid/posts/"));
    var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    globals.nextCatUrl = jsonData['next'];
    globals.previousCatUrl = jsonData['previous'];
    if (jsonData['count'] > 0) {
      jsonData["results"].forEach((element) {
        if (element["id"] != "") {
/*
          print(element['next']);
*/
          NewsModel newsModel = NewsModel(
            id: element['id'],
            image: element['image'],
            title: Content(en: element['title']['tk']),

            /* title: element.id['title'],
              content: element.id['content'],
              image: element.id['image'],*/
          );
          news.add(newsModel);
        }
      });
    }
  }
}

class CertViewClass {
  List<NewsModel> news = [];

  Future<void> getNews(newsUrl) async {
/*
    String url = "http://192.168.30.111:8000/api/posts";
*/

    var response =
        await http.get(Uri.parse("http://192.168.30.111:8000/api/cert/"));
    var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    globals.nextUrl = jsonData['next'];
    globals.previousUrl = jsonData['previous'];
    print(globals.previousUrl);

    if (jsonData['count'] > 0) {
      jsonData["results"].forEach((element) {
        if (element["id"] != "") {
/*
          print(element['next']);
*/
          NewsModel newsModel = NewsModel(
              id: element['id'],
              title: Content(en: element['title']['en']),
              content: Content(en: element['content']['en'])

              /* title: element.id['title'],
              content: element.id['content'],
              image: element.id['image'],*/
              );
          news.add(newsModel);
        }
      });
    }
  }
}

class LawsViewClass {
  List<NewsModel> news = [];

  Future<void> getNews(newsUrl) async {
/*
    String url = "http://192.168.30.111:8000/api/posts";
*/

    var response =
        await http.get(Uri.parse("http://192.168.30.111:8000/api/laws/"));
    var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    globals.nextUrl = jsonData['next'];
    globals.previousUrl = jsonData['previous'];
    print(globals.previousUrl);

    if (jsonData['count'] > 0) {
      jsonData["results"].forEach((element) {
        if (element["id"] != "") {
/*
          print(element['next']);
*/
          NewsModel newsModel = NewsModel(
              id: element['id'],
              title: Content(en: element['title']['en']),
              content: Content(en: element['content']['en'])

              /* title: element.id['title'],
              content: element.id['content'],
              image: element.id['image'],*/
              );
          news.add(newsModel);
        }
      });
    }
  }
}

class OrdersViewClass {
  List<NewsModel> news = [];

  Future<void> getNews(newsUrl) async {
/*
    String url = "http://192.168.30.111:8000/api/posts";
*/

    var response =
        await http.get(Uri.parse("http://192.168.30.111:8000/api/orders/"));
    var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    print(jsonData['count']);
    if (jsonData['count'] != 0) {
      jsonData["results"].forEach((element) {
        if (element["count"] != 0) {
/*
          print(element['next']);
*/
          NewsModel newsModel = NewsModel(
              id: element['id'],
              title: Content(en: element['title']['en']),
              content: Content(en: element['content']['en'])

              /* title: element.id['title'],
              content: element.id['content'],
              image: element.id['image'],*/
              );
          news.add(newsModel);
        }
      });
    } else { Container(child: Text("Sargyt Yok", style: TextStyle(fontSize: 20)),);}
  }
}

class FaqViewClass {
  List<NewsModel> news = [];

  Future<void> getNews(newsUrl) async {
/*
    String url = "http://192.168.30.111:8000/api/posts";
*/

    var response =
        await http.get(Uri.parse("http://192.168.30.111:8000/api/faq/"));
    var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    globals.nextUrl = jsonData['next'];
    globals.previousUrl = jsonData['previous'];
    print(globals.previousUrl);

    if (jsonData['count'] > 0) {
      jsonData["results"].forEach((element) {
        if (element["id"] != "") {
/*
          print(element['next']);
*/
          NewsModel newsModel = NewsModel(
              id: element['id'],
              title: Content(en: element['title']['en']),
              content: Content(en: element['content']['en'])

              /* title: element.id['title'],
              content: element.id['content'],
              image: element.id['image'],*/
              );
          news.add(newsModel);
        }
      });
    }
  }
}

class AboutViewClass {
  List<NewsModel> news = [];

  Future<void> getNews(newsUrl) async {
/*
    String url = "http://192.168.30.111:8000/api/posts";
*/

    var response =
        await http.get(Uri.parse("http://192.168.30.111:8000/api/about/"));
    var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    globals.nextUrl = jsonData['next'];
    globals.previousUrl = jsonData['previous'];
    print(globals.previousUrl);

    if (jsonData['count'] > 0) {
      jsonData["results"].forEach((element) {
        if (element["id"] != "") {
/*
          print(element['next']);
*/
          NewsModel newsModel = NewsModel(
              id: element['id'],
              title: Content(en: element['title']['en']),
              content: Content(en: element['content']['en'])

              /* title: element.id['title'],
              content: element.id['content'],
              image: element.id['image'],*/
              );
          news.add(newsModel);
        }
      });
    }
  }
}

class ContactsViewClass {
  List<NewsModel> news = [];

  Future<void> getNews(newsUrl) async {
/*
    String url = "http://192.168.30.111:8000/api/posts";
*/

    var response =
        await http.get(Uri.parse("http://192.168.30.111:8000/api/contacts/"));
    var jsonData = jsonDecode(response.body);
    globals.nextUrl = jsonData['next'];
    globals.previousUrl = jsonData['previous'];
    print(globals.previousUrl);

    if (jsonData['count'] > 0) {
      jsonData["results"].forEach((element) {
        if (element["id"] != "") {
/*
          print(element['next']);
*/
          NewsModel newsModel = NewsModel(
              id: element['id'],
              title: Content(en: element['title']['en']),
              content: Content(en: element['content']['en'])

              /* title: element.id['title'],
              content: element.id['content'],
              image: element.id['image'],*/
              );
          news.add(newsModel);
        }
      });
    }
  }
}
