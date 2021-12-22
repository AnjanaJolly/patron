import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/common/appBar.dart';
import 'package:news_app/common/theme.dart';
import 'package:webfeed/webfeed.dart';

class GridPage extends StatefulWidget {
  @override
  _GridViewState createState() => _GridViewState();
}

class _GridViewState extends State<GridPage> {
  final ScrollController _scrollController = new ScrollController();
  // var refreshKey = GlobalKey<RefreshIndicatorState>();
  // var cat = {};
  // Future<Null> _refresh() async {
  //   await Future.delayed(Duration(seconds: 2));
  //   refreshKey.currentState?.show();
  //   setState(() {
  //     // cat.addAll(other)
  //     loadRSSFeed();
  //   });
  // }

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
            automaticallyImplyLeading: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Hero(
              tag: 'Title',
              child: Text(
                'Patron Retail Tech News',
                style: ThemesData.appBarSize(),
              ),
            ),
          ),
          body: Container(
            child: FutureBuilder(
              future: getRss(),
              builder: (context, AsyncSnapshot<List> snapshot) {
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
                  return SingleChildScrollView(
                    controller: _scrollController,
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(16),
                          child: Text(
                            snapshot.data![index].dc,
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  getRss() async {
    var client = http.Client();
    var response = await client
        .get(Uri.parse('https://newslogic.io/a/Feeds.aspx?siteID=126'));
    print(response.body.length);
    var feed = response.body.substring(0, response.body.length - 518);
    var channel = RssFeed.parse(feed);
    print(channel.items!.first.media!.thumbnails);
    return channel.items;
  }
}
