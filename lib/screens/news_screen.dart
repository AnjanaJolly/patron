import 'dart:math';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:news_app/common/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class NewScreen extends StatefulWidget {
  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  final ScrollController _scrollController = new ScrollController();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  var cat = {};
  bool _isSubscribed = false;
  var kMobileBreakpoint = 576;
  var kTabletBreakpoint = 1024;
  var kDesktopBreakPoint = 1366;

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
    refreshKey.currentState?.show();
    setState(() {
      // cat.addAll(other)
      loadRSSFeed();
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? status = preferences.getBool('isSubscribed');
    if (status == null) {
      setState(() {
        _isSubscribed = false;
      });
    } else {
      setState(() {
        _isSubscribed = status;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: ThemesData.BACKGROUND_COLOR,
          body: Container(
            width: ThemesData.width,
            height: 146 * ThemesData.widthRatio,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[Color(0xff141516), Color(0xff19202C)],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: false,
            toolbarHeight: 88,
            actions: [
              _isSubscribed
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(right: 16, bottom: 14, top: 30),
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        onPressed: () => _launchURL(
                            'https://manage.kmail-lists.com/subscriptions/subscribe?a=WkuMfY&g=VzKJMJ'),
                        color: Color(0xFFFC7C54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            "Subscribe",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
            ],
            automaticallyImplyLeading: true,
            backgroundColor: Colors.transparent,
            title: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  'Retail Tech News',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          body: Container(
            /*  decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image 6.png'), fit: BoxFit.fill),
            ),*/
            child: RefreshIndicator(
              key: refreshKey,
              onRefresh: _refresh,
              child: FutureBuilder(
                future: loadRSSFeed(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 16),
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        ),
                        Text(
                          'Fetching News Articles...',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    );
                  } else {
                    print((snapshot.data as dom.Document).children[0]);
                    int itemCount = (snapshot.data as dom.Document)
                        .children[0]
                        .getElementsByTagName('channel')[0]
                        .getElementsByTagName('item')
                        .length;
                    return LayoutBuilder(
                      builder: (context, dimens) {
                        if (dimens.maxWidth <= kMobileBreakpoint) {
                          return CustomGridView(
                              columnRatio: 6,
                              itemCount: itemCount,
                              snapshot: snapshot);
                        } else if (dimens.maxWidth > kMobileBreakpoint &&
                            dimens.maxWidth <= kTabletBreakpoint) {
                          return CustomGridView(
                              columnRatio: 4,
                              itemCount: itemCount,
                              snapshot: snapshot);
                        } else if (dimens.maxWidth > kTabletBreakpoint &&
                            dimens.maxWidth <= kDesktopBreakPoint) {
                          return CustomGridView(
                              columnRatio: 3,
                              itemCount: itemCount,
                              snapshot: snapshot);
                        } else {
                          return CustomGridView(
                              columnRatio: 3,
                              itemCount: itemCount,
                              snapshot: snapshot);
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Random random = new Random();

  Widget CustomGridView(
      {required int columnRatio,
      required int itemCount,
      required AsyncSnapshot snapshot}) {
    return StaggeredGridView.countBuilder(
      primary: false,
      crossAxisCount: 12,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        var item = (snapshot.data as dom.Document)
            .children[0]
            .getElementsByTagName('channel')[0]
            .getElementsByTagName('item')[index]
            .children;
        var list = (item[3].text).split(",")[1].trim().split(" ");
        //
        var dateString = "${list[0]} ${list[1]} ${list[2]}";
        return GestureDetector(
          onTap: () {
            if (kIsWeb)
              _launchURL((snapshot.data as dom.Document)
                  .children[0]
                  .getElementsByTagName('channel')[0]
                  .getElementsByTagName('item')[index]
                  .text
                  .trim()
                  .split("\n")[1]
                  .trim());
            else {
              Navigator.pushNamed(context, '/webview',
                      arguments: (snapshot.data as dom.Document)
                          .children[0]
                          .getElementsByTagName('channel')[0]
                          .getElementsByTagName('item')[index]
                          .text
                          .trim()
                          .split("\n")[1]
                          .trim())
                  .then((_) => setState(() {}));
            }
          },
          //

          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: ThemesData.CARD_COLOR,
                borderRadius: BorderRadius.circular(4),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6)
                ]),
            height: random.nextInt(75).toDouble() + 300,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  !((item[6].text.length > 5 && !item[6].text.contains("\n")))
                      ? Container(
                          height: 0,
                          width: 0,
                        )
                      : ClipRRect(
                          child: CachedNetworkImage(
                            imageUrl: (item[6].text.length > 5 &&
                                    !item[6].text.contains("\n"))
                                ? item[6].text.substring(0, item[6].text.length)
                                : "https://news.maxabout.com/wp-content/uploads/2018/06/Quick-Facts-BMW-G310GS.jpg",
                            height: 150,
                            width: 150,
                            fit: BoxFit.fill,
                            placeholder: (context, value) {
                              return Image.asset(
                                "assets/placeholder.png",
                                fit: BoxFit.cover,
                                height: 88 * ThemesData.heightRatio,
                                width: 88 * ThemesData.widthRatio,
                              );
                            },
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Text(
                      item[0].text,
                      // "abc",
                      style: TextStyle(
                          fontFamily: 'GilroyRegular',
                          color: const Color(0xffD9E2FF),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    item[5].text,
                    // "aaa",
                    style: TextStyle(
                        fontFamily: "GilroyRegular",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFD9E2FF)),
                    maxLines: ((item[6].text.length > 5 &&
                            !item[6].text.contains("\n")))
                        ? 2
                        : 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                ]),
          ),
        );
      },
      staggeredTileBuilder: (index) => StaggeredTile.fit(columnRatio),
    );
  }

  Widget gridView(AsyncSnapshot snapshot) {
    return GridView.builder(
      controller: _scrollController,
      shrinkWrap: true,
      itemCount: (snapshot.data as dom.Document)
          .children[0]
          .getElementsByTagName('channel')[0]
          .getElementsByTagName('item')
          .length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 4 / 3,
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        var item = (snapshot.data as dom.Document)
            .children[0]
            .getElementsByTagName('channel')[0]
            .getElementsByTagName('item')[index]
            .children;
        var list = (item[3].text).split(",")[1].trim().split(" ");
        //
        var dateString = "${list[0]} ${list[1]} ${list[2]}";
        return GestureDetector(
            onTap: () {
              if (kIsWeb)
                _launchURL((snapshot.data as dom.Document)
                    .children[0]
                    .getElementsByTagName('channel')[0]
                    .getElementsByTagName('item')[index]
                    .text
                    .trim()
                    .split("\n")[1]
                    .trim());
              else {
                Navigator.pushNamed(context, '/webview',
                        arguments: (snapshot.data as dom.Document)
                            .children[0]
                            .getElementsByTagName('channel')[0]
                            .getElementsByTagName('item')[index]
                            .text
                            .trim()
                            .split("\n")[1]
                            .trim())
                    .then((_) => setState(() {}));
              }
            },
            //
            child: newstab(item, list, dateString));
      },
    );
  }

  Widget newstab(item, list, dateString) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: ThemesData.CARD_COLOR,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          ((item[6].text.length > 5 && !item[6].text.contains("\n")))
              ? ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: (item[6].text.length > 5 &&
                            !item[6].text.contains("\n"))
                        ? item[6].text.substring(0, item[6].text.length)
                        : "https://news.maxabout.com/wp-content/uploads/2018/06/Quick-Facts-BMW-G310GS.jpg",
                    height: 150,
                    width: 150,
                    fit: BoxFit.fill,
                    placeholder: (context, value) {
                      return Image.asset(
                        "assets/placeholder.png",
                        fit: BoxFit.cover,
                        height: 88 * ThemesData.heightRatio,
                        width: 88 * ThemesData.widthRatio,
                      );
                    },
                  ),
                  borderRadius: BorderRadius.circular(4),
                )
              : Container(),
          SizedBox(
            height: 20,
          ),
          Flexible(
            child: Column(
              children: [
                Text(
                  item[0].text,
                  // "abc",
                  style: TextStyle(
                      fontFamily: 'GilroyRegular',
                      color: const Color(0xffD9E2FF),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  item[5].text,
                  // "aaa",
                  style: TextStyle(
                      fontFamily: "GilroyRegular",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFD9E2FF)),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                item[4].text,
                style: TextStyle(
                    color: const Color.fromRGBO(217, 226, 255, 0.6),
                    fontSize: 14,
                    fontFamily: "GilroyRegular"),
              ),
              Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                height: 4 * ThemesData.heightRatio,
                width: 4 * ThemesData.widthRatio,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(217, 226, 255, 0.6),
                    shape: BoxShape.circle),
              ),
              Text(
                // DateFormat("dd MMM yyyy")
                //     .format(DateTime.parse(
                //         "2012-02-27")),
                dateString,
                style: TextStyle(
                    color: const Color.fromRGBO(217, 226, 255, 0.6),
                    fontSize: 12,
                    fontFamily: "GilroyRegular"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  Future loadRSSFeed() async {
    print('loadRSSFeed');
    http.Response response = await http.get(
        Uri.parse("https://newslogic.io/a/Feeds.aspx?siteID=123"),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials":
              'true', // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token",
        });
//      await http.get("https://newslogic.io/a/Feeds.aspx?SiteID=12&limit=1");
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);

      dom.Document document = parse(response.body);

      /* print(
          'RSS FEed ${document.children[0].getElementsByTagName('channel')[0].getElementsByTagName('item')[0].text.trim().split("\n")[1].trim()}');*/
      return document;
    }
  }
}
