import 'package:flutter/material.dart';
import 'package:news_app/route/routes.dart';
import 'package:wiredash/wiredash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ignore: non_constant_identifier_names
  var PROJECT_ID = "bmw_anon-j8fmhd7";
  // ignore: non_constant_identifier_names
  var PROJECT_SECRET = "sa97vhi0i9ydgx3kogaj5ea3lx1ij3f4";
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: PROJECT_ID,
      secret: PROJECT_SECRET,
      theme: WiredashThemeData(brightness: Brightness.dark),
      navigatorKey: _navigatorKey,
      // options: WiredashOptionsData(
      //     showDebugFloatingEntryPoint: false,
      //   ),
      child: MaterialApp(
        theme: ThemeData(unselectedWidgetColor: Colors.white),
        // initialRoute: '/',
        // home: NewScreen(),
        navigatorKey: _navigatorKey,

        onGenerateRoute: getRoute,
        routes: routes,
      ),
    );
  }
}
