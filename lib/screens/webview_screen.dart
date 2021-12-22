import 'package:news_app/common/theme.dart';
import 'package:flutter/material.dart';

class WebviewScreen extends StatefulWidget {
  final String url;
  WebviewScreen({required this.url});

  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  // final flutterWebviewPlugin = new FlutterWebviewPlugin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return /* (widget.url != null && widget.url.isNotEmpty)
        ? WebviewScaffold(
            url: widget.url,
            appBar: AppBar(
              backgroundColor: ThemesData.BACKGROUND_COLOR,
              title: Text(
                "News",
                style: ThemesData.setHeadingSize(),
              ),
            ),
            initialChild:
                // Container(
                //   alignment: Alignment.center,
                //   child:
                Center(
              heightFactor: 40,
              widthFactor: 40,
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
                strokeWidth: 4,
              ),
            ),
            // ),
            scrollBar: true,
            withJavascript: true,
            displayZoomControls: true,
          )
        : */
        Container(
      alignment: Alignment.center,
      child: Text(
        "Invalid URL",
        style: ThemesData.setHeadingSize(),
      ),
    );
  }
}
