import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class GridPage2 extends StatefulWidget {
  @override
  _GridPage2State createState() => _GridPage2State();
}

class _GridPage2State extends State<GridPage2> {
  @override
  Widget build(BuildContext context) {
    var count = loadRSSFeed();
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: loadRSSFeed(),
          builder: (context, AsyncSnapshot snapshot) {
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
              // return ListView.builder(
              //   itemCount: snapshot.data.length,
              //   itemBuilder: (context, index) {
              //     return ElevatedButton(
              //       child: Text(snapshot.data[index]),
              //       onPressed: () {},
              //     );
              //   },
              // );

              return GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return Center(
                    child: Container(
                      margin: EdgeInsets.all(8),
                      width: 200,
                      child: ElevatedButton(
                        child: Text(snapshot.data[index]),
                        onPressed: () {},
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future loadRSSFeed() async {
    http.Response response = await http
        .get(Uri.parse("https://newslogic.io/a/Feeds.aspx?siteID=126"));

    if (response.statusCode == 200) {
      print(response.body);

      dom.Document document = parser.parse(response.body);
      var length = document.children[0]
          .getElementsByTagName('channel')[0]
          .getElementsByTagName('item')
          .length;
      Set author = new Set();
      for (var i = 0; i < length; i++) {
        var item = document.children[0]
            .getElementsByTagName('channel')[0]
            .getElementsByTagName('item')[i]
            .children;
        author.add(item[4].text);
      }
      print('Author: ' + author.toString());
      return author.toList();
    }
  }
}
