import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hbr_app/helper/news.dart';
import 'package:hbr_app/models/news_model.dart';

class FaqView extends StatefulWidget {
  FaqView();

  @override
  _FaqViewState createState() => _FaqViewState();
}

class _FaqViewState extends State<FaqView> {
  bool _loading = true;
  List<NewsModel> results = new List<NewsModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFaqView();

  }

  getFaqView() async {
    FaqViewClass newsClass = FaqViewClass();
    await newsClass.getNews(widget);
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
                'K',
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
              Text(
                'SS',
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
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          ExpansionTile(
            title: Text(
              title.en,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            children: [
              Html(
                data: content.en,
              )
            ],
          ),

        ],
      ),
    );
  }
}
