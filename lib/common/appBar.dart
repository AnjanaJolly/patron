import 'package:news_app/common/theme.dart';
import 'package:flutter/material.dart';

Widget customAppBar(String title) {
  return AppBar(
    automaticallyImplyLeading: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Hero(
      tag: 'Title',
      child: Text(
        title,
        style: ThemesData.appBarSize(),
      ),
    ),
  );
}
