import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hbr_app/helper/news.dart';
import 'package:hbr_app/models/news_model.dart';
import 'package:hbr_app/global.dart' as globals;

import 'news_view.dart';

class CategoryView3 extends StatefulWidget {
  final String cid;
  CategoryView3({this.cid});

  @override
  _CategoryView3State createState() => _CategoryView3State();
}


class _CategoryView3State extends State<CategoryView3> {
  bool _loading = true;
  List<NewsModel> results = new List<NewsModel>();
  List<NewsModel> catnews3 = [];
  ScrollController _scrollController = new ScrollController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCatView(globals.initialCat3Url);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.minScrollExtent) {
        getCatView(globals.previousCatUrl);
      }
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        getCatView(globals.nextCatUrl);
        print(globals.nextCatUrl);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  getCatView(url) async {
    Future<void> getNews(newsurl) async {
      var response = await http.get(
          Uri.parse(newsurl));
      var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      globals.nextCatUrl = jsonData['next'];
      print(globals.nextCatUrl);
      globals.previousCatUrl = jsonData['previous'];
      if (jsonData['count'] > 0) {
        jsonData["results"].forEach((element) {
          if (element["id"] != "") {
            NewsModel newsModel = NewsModel(
              id: element['id'],
              image: element['image'],
              title: Content(en: element['title']['tk']),
            );
            catnews3.add(newsModel);
          }
        });
      }
    }
    await getNews(url);
    results = catnews3;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.green),
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Text(
                'HABAR',
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
              Text(
                'lar',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ],
          ),
        ),
        body: _loading
            ? Center(
          child: Container(
            child: CircularProgressIndicator(),
          ),
        )
            : SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 16),
                  height: 650,
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: results.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return NewsTile(
                          image: results[index].image,
                          title: results[index].title,
                          id: results[index].id,
                        );
                      }),
                )
              ],
            ),
          ),
        ));
  }
}

class NewsTile extends StatelessWidget {
  final String image, sid;
  final Content title, content;
  final int id;
  const NewsTile({
    this.id,
    this.sid,
    @required this.title,
    this.content,
    @required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsView(
                  sid: id.toString(),
                  /* newsUrl: globals.newsIdUrl,*/
                )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: image,
                  width: 350,
                  height: 175,
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 8,
            ),
            Text(
              title.en,
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
