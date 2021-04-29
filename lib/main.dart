import 'dart:convert';
import 'package:hbr_app/views/category_view2.dart';
import 'package:hbr_app/views/category_view3.dart';
import 'package:hbr_app/views/category_view4.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hbr_app/views/about_us.dart';
import 'package:hbr_app/views/category_view.dart';
import 'package:hbr_app/views/cert-tm.dart';
import 'package:hbr_app/views/contact_us.dart';
import 'package:hbr_app/views/faq_view.dart';
import 'package:hbr_app/views/laws_view.dart';
import 'package:hbr_app/views/news_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hbr_app/views/orders_view.dart';
import 'helper/news.dart';
import 'models/news_model.dart';
import 'global.dart' as globals;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<NewsModel> results = new List<NewsModel>();
  List<NewsModel> news = [];
  ScrollController _scrollController = new ScrollController();

  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews(globals.initialUrl);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.minScrollExtent) {
        getNews(globals.previousUrl);
      }
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        getNews(globals.nextUrl);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  getNews(url) async {
    Future<void> getNews(newsUrl) async {
      var response = await http.get(Uri.parse(newsUrl));
      var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      globals.nextUrl = jsonData['next'];
      globals.previousUrl = jsonData['previous'];
      print(globals.previousUrl);

      if (jsonData['count'] > 0) {
        jsonData["results"].forEach((element) {
          if (element["id"] != "") {
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
    await getNews(url);
    results = news;
    setState(() {
      _loading = false;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.green),
            backgroundColor: Colors.white,
            title: Row(
              children: [
                Text(
                  'DKG',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
                Text(
                  'HABARlar',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ],
            ),
            elevation: 10,
          ),
          drawer: Builder(
            builder: (context) => Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Center(
                        child: Stack(
                          children:[
                            /*Text(
                            'Salgylar',
                            style: TextStyle(
                              fontSize: 25,
                              foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 3
                              ..color = Colors.red[700],
                            ),
                          ),*/
                          Opacity(
                            opacity: 0.7,
                            child: Text(
                                'Salgylar',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )]
                        )),
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: AssetImage("lib/assets/green.jpg"),
                        fit: BoxFit.cover,
                      ),
/*
                      color: Colors.white24,
*/
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home_outlined, color: Colors.lightGreen,),
                    title: Text('Baş Sahypa'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.of(context).pop();
                      getNews(globals.initialUrl);
                      _scrollController
                          ?.jumpTo(_scrollController.position.minScrollExtent);
                    },
                  ),
                  ExpansionTile(
                    title: Text("Habarlar"),
                    leading: Icon(Icons.article_outlined, color: Colors.lightGreen,),
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 25.0),
                        title: Text('Gowşaklyklar'),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => CategoryView(
                                    cid: "1",
                                  )));
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 25.0),
                        title: Text('Ulgamlaryň Howpsuzlygy'),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => CategoryView2(
                                    cid: "2",
                                  )));
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 25.0),
                        title: Text('Zyýanly Programmalar'),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => CategoryView3(
                                    cid: "3",
                                  )));
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 25.0),
                        title: Text('Mobil Howpsuzlygy'),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => CategoryView4(
                                    cid: "4",
                                  )));
                        },
                      ),
                    ],
                  ),
                  ListTile(
                    leading: Icon(Icons.computer, color: Colors.lightGreen,),
                    trailing: Icon(Icons.keyboard_arrow_right,),
                    title: Text('CERT-TM'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => CertView()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.book_outlined, color: Colors.lightGreen,),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    title: Text('Namalar'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => LawsView()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.shopping_cart_outlined, color: Colors.lightGreen,),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    title: Text('Sargytlar'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => OrdersView()));
                    },
                  ),
                  ListTile(
                    title: Text('Köp Soralýan Soraglar'),
                    leading: Icon(Icons.question_answer_outlined, color: Colors.lightGreen,),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => FaqView()));
                    },
                  ),
                  ListTile(
                    title: Text('Habarlaşmak'),
                    leading: Icon(Icons.phone_android, color: Colors.lightGreen,),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ContactsView()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.account_balance_outlined, color: Colors.lightGreen,),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    title: Text('Biz Barada'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => AboutView()));
                    },
                  ),
                ],
              ),
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
                          height: 600,
                          padding: EdgeInsets.only(top: 16),
                          child: ListView.builder(
                              itemCount: results.length,
                              shrinkWrap: true,
                              controller: _scrollController,
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
                )),
    );
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
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: image,
                  width: 400,
                  height: 200,
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 16,
            ),
            Text(
              title.en,
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
