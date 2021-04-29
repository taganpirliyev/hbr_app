import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:hbr_app/helper/news.dart';
import 'package:hbr_app/models/news_model.dart';

class NewsView extends StatefulWidget {
  final String sid;
  NewsView({this.sid});

/*
  String get sid => null;
*/

  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  bool _loading = true;
  List<NewsModel> results = new List<NewsModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsView();
  }

  getNewsView() async {
    NewsViewClass newsClass = NewsViewClass();
    await newsClass.getNews(widget.sid);
    results = newsClass.news;
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
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
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
                        height: 600,
                        child: ListView.builder(
                            itemCount: results.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return NewsTile(
                                id: results[index].id,
                                image: results[index].image,
                                title: results[index].title,
                                content: results[index].content,
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
  String image;
  Content title, content;
  int id;
  NewsTile({
    this.id,
    @required this.title,
    this.content,
    @required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(18, 0, 10, 10),
            child: Text(
              title.en,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
          ),
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                image,
                width: 350,
                height: 175,
                fit: BoxFit.cover,
              )),
          Html(
            data: content.en,
            style: {
          "p": Style(
          padding: const EdgeInsets.all(15),
          fontSize: FontSize.larger,
          ),
            },
          )
        ],
      ),
    );
  }
}
