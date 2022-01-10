import 'package:flutter/material.dart';
import 'package:news_app/common/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JoinMailList extends StatefulWidget {
  final String url = 'https://kamat.org/b/Feeds.aspx?SiteID=123';
  //'https://manage.kmail-lists.com/subscriptions/subscribe?a=WkuMfY&g=VzKJMJ';
  _JoinMailListState createState() => _JoinMailListState(url: url);
}

class _JoinMailListState extends State<JoinMailList> {
  var url;

  _JoinMailListState({
    this.url,
  });
  final _key = UniqueKey();
  bool _isLoading = true;
  //late WebViewController _controller;
  bool status = false;

  void readResponse() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    /* setState(() {
      _controller
          .evaluateJavascript('document.documentElement.innerHTML')
          .then((value) async {
        if (value.contains("You've Been Subscribed")) {
          status = true;
        } else {
          status = false;
        }
        sharedPreferences.setBool('isSubscribed', status);
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        if (status) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/news', (Route<dynamic> route) => false);
          return Future.value(false);
        }
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: ThemesData.BACKGROUND_COLOR,
        appBar: AppBar(
          title: Text(
            'Subscribe ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.transparent,
          toolbarHeight: 88,
        ),
        /*body: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: WebView(
                key: _key,
                onWebViewCreated: (controller) {
                  _controller = controller;
                },
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: url,
                onPageFinished: (_) {
                  readResponse();
                  setState(() {
                    _isLoading = false;
                  });
                },
              ),
            ),
            _isLoading
                ? Container(
                    color: ThemesData.BACKGROUND_COLOR,
                    child: Center(
                      child: CircularProgressIndicator(
                          //color: Color(0xFFFC7C54),
                          ),
                    ),
                  )
                : Stack(),
          ],
        ),*/
      ),
    );
  }
}
