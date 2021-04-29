import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hbr_app/helper/news.dart';
import 'package:hbr_app/models/news_model.dart';

class OrdersView extends StatefulWidget {
  OrdersView();

  @override
  _OrdersViewState createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  bool _loading = true;
  List<NewsModel> results = new List<NewsModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrdersView();
  }

  getOrdersView() async {
    OrdersViewClass newsClass = OrdersViewClass();
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
                'SARGYT',
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
          Container(
            padding: EdgeInsets.fromLTRB(18, 0, 10, 10),
            child: Text(
              title.en,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Html(
            data: content.en,
          )
        ],
      ),
    );
  }
}
