import 'dart:async';

import 'package:news_app/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen2 extends StatefulWidget {
  final url;
  WebviewScreen2({this.url, Key? key}) : super(key: key);

  @override
  _WebviewScreen2State createState() => _WebviewScreen2State();
}

class _WebviewScreen2State extends State<WebviewScreen2> {
  final _key = UniqueKey();
  int _stackToView = 1;

  void _handleLoad(String value) {
    setState(() {
      _stackToView = 0;
    });
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemesData.BACKGROUND_COLOR,
        title: Text(
          "News",
          style: ThemesData.setHeadingSize(),
        ),
      ),
      body: _body(),
    );
  }

  _body() {
    return (widget.url != null && widget.url.isNotEmpty)
        ? IndexedStack(
            index: _stackToView,
            children: [
              Builder(
                builder: (BuildContext context) {
                  return WebView(
                    initialUrl: widget.url,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                    },
                    onPageStarted: _handleLoad,
                    gestureNavigationEnabled: true,
                  );
                },
              ),
              Column(
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
                    'Fetching Details...',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              )
            ],
          )
        : Container(
            alignment: Alignment.center,
            child: Text(
              "Invalid URL",
              style: ThemesData.setHeadingSize(),
            ),
          );
  }
}
