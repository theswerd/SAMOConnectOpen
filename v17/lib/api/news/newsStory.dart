import 'package:flutter/material.dart';
import 'package:v17/api/news/Category.dart';

class NewsStory {
  String title;
  String author;
  String authorLink;
  String category;
  String categoryURL;
  String url;
  String imageSRC;
  bool loadedFullStory;
  String body;
  DateTime posted;

  NewsStory({
    @required this.title,
    @required this.author,
    @required this.url,
    @required this.category,
    @required this.categoryURL,
    @required this.imageSRC,
    @required this.posted,
    this.loadedFullStory = false,
  });

  Color get categoryColor => categoryColors.containsKey(this.category)
      ? categoryColors[this.category]
      : Colors.blue;

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
    //Category(title: "Photos", code: "photo")
  ];
  
}

