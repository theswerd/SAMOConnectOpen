import 'package:flutter/material.dart';
import 'package:v17/api/news/Category.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsStory {
  String title;
  String description;
  String author;
  String authorLink;
  String category;
  String categoryURL;
  String url;
  String imageSRC;
  bool loadedFullStory;
  String body;
  DateTime posted;
  String originCategory;

  NewsStory({
    @required this.title,
    @required this.description,
    @required this.author,
    @required this.url,
    @required this.category,
    @required this.originCategory,
    @required this.categoryURL,
    @required this.imageSRC,
    @required this.posted,
    this.loadedFullStory = false,
  });

  Color get categoryColor => categoryColors.containsKey(this.category)
      ? categoryColors[this.category]
      : Colors.blue;

  String get timeAgo => timeago.format(this.posted);

  static Map<String, Color> categoryColors = {
    "News": Colors.blueAccent,
    "Sports": Colors.indigoAccent,
    "Opinion": Colors.lightBlueAccent,
    "ae": Colors.cyanAccent,
    "feature": Colors.tealAccent,
    "photo": Colors.deepPurpleAccent
  };
  static List<Category> categories = [
    Category(title: "News", code: "news"),
    Category(title: "Sports", code: "Sports"),
    Category(title: "Opinion", code: "Opinion"),
    Category(title: "A & E", code: "ae"),
    Category(title: "Feature", code: "feature"),
    Category(title: "Photography", code: "photo")
  ];
}
