import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/common/theme.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemesData.width = MediaQuery.of(context).size.width;
    ThemesData.height = MediaQuery.of(context).size.height;
    ThemesData.setScreenRatio(ThemesData.height, ThemesData.width);

    Timer(Duration(seconds: 4), () {
      Navigator.pushNamedAndRemoveUntil(
          context, '/news', (Route<dynamic> route) => false);
    });

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/Ellipse 7.png',
                    ),
                    Image.asset(
                      'assets/Ellipse 6.png',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/Ellipse 8.png',
                    ),
                    Image.asset(
                      'assets/Ellipse 5.png',
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 8),
                  width: 95,
                  height: 90,
                  child: Image.asset('assets/image 7.png'),
                ),
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: Column(
                    children: [
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          'Patron ',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          'Retail Tech News ',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset('assets/Ellipse 1.png'),
                    Image.asset('assets/Ellipse 4.png'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset('assets/Ellipse 3.png'),
                    Image.asset('assets/Ellipse 2.png'),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
