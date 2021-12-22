// To parse this JSON data, do
//
//     final newsResponse = newsResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NewsResponse newsResponseFromJson(String str) =>
    NewsResponse.fromJson(json.decode(str));

String newsResponseToJson(NewsResponse data) => json.encode(data.toJson());

class NewsResponse {
  NewsResponse({
    required this.items,
  });

  List<Item> items;

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    required this.guid,
    required this.url,
    required this.title,
    required this.contentHtml,
    required this.summary,
    required this.datePublished,
    required this.author,
  });

  String guid;
  String url;
  String title;
  String contentHtml;
  String summary;
  DateTime datePublished;
  Author author;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        guid: json["guid"],
        url: json["url"],
        title: json["title"],
        contentHtml: json["content_html"] == null ? null : json["content_html"],
        summary: json["summary"],
        datePublished: DateTime.parse(json["date_published"]),
        author: Author.fromJson(json["author"]),
      );

  Map<String, dynamic> toJson() => {
        "guid": guid,
        "url": url,
        "title": title,
        "content_html": contentHtml == null ? null : contentHtml,
        "summary": summary,
        "date_published": datePublished.toIso8601String(),
        "author": author.toJson(),
      };
}

class Author {
  Author({
    required this.name,
  });

  String name;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
