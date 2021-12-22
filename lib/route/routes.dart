import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/grid_view.dart';
import 'package:news_app/screens/grid_view2.dart';
import 'package:news_app/screens/news_screen.dart';
import 'package:news_app/screens/splash_screen.dart';
import 'package:news_app/screens/webview_screen-2.dart';
import 'package:news_app/screens/webview_screen.dart';
import 'package:news_app/screens/webview_screen_3.dart';

Map<String, WidgetBuilder> routes = {
  '/': (BuildContext context) => Splash(),
};
Route<dynamic> getRoute(RouteSettings settings) {
  if (settings.name == "/news") {
    return _buildRoute(settings, NewScreen());
  } else if (settings.name == "/webview") {
    return _buildRoute(
      settings,
      WebviewScreen2(
        url: (settings != null && settings.arguments != null)
            ? settings.arguments as String
            : null,
      ),
    );
  } else if (settings.name == "/grid") {
    return _buildRoute(
      settings,
      GridPage(),
    );
  } else if (settings.name == "/grid2") {
    return _buildRoute(
      settings,
      GridPage2(),
    );
  } else if (settings.name == "/joinmaillist") {
    return _buildRoute(settings, JoinMailList());
  } else {
    return _buildRoute(settings, NewScreen());
    ;
  }
}

MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
  return MaterialPageRoute(settings: settings, builder: (_) => builder);
}
