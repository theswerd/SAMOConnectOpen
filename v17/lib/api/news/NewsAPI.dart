import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:v17/api/news/newsStory.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;

class NewsAPI {
  static Future<List<NewsStory>> getLatestNews(String category,
      {int page = 0}) async {
    try {
      Response latestNews = await get(
          "https://www.thesamohi.com/category/$category" +
              (page > 0 ? "/page/$page" : ""));
      dom.Document document = parse(latestNews.body);
      List<dom.Element> articlesHTML =
          document.getElementsByClassName("omc-blog-one");
      List newsStories = articlesHTML.map((e) {
        DateTime posted;
        try {
          posted = DateFormat("MMMM d, yyyy").parse(e.children[3].text
              .split("|")
              .first
              .replaceFirst("Published on ", "")
              .replaceFirst("th", "")
              .replaceFirst("nd", "")
              .replaceFirst("rd", "")
              .trim());
        } catch (e) {
          posted = DateTime.now().subtract(Duration(
              hours: 24 *
                  7 *
                  52 *
                  3 /*Three Years back so they are at the bottom */));
        }

        return NewsStory(
            category: e.children.first.text,
            categoryURL: e.children.first.children.first.attributes['href'],
            originCategory: category,
            url: e.children[1].attributes['href'],
            imageSRC: e.children[1].children.first.attributes['src'],
            description: e.children[4].text.trim(),
            title: e.children[2].children.first.text.trim(),
            author:
                e.children[3].children.last.text.replaceFirst("by ", "").trim(),
            posted: posted);
      }).toList();

      return newsStories;
    } catch (e) {
      return [];
    }
  }

  static Future<List<NewsStory>> getArtistStories(String artistURL) async {
    try {
      Response latestNews = await get(artistURL);
      dom.Document document = parse(latestNews.body);
      dom.Element main = document.getElementById("omc-main");
      List<NewsStory> newsStories = [];
      for (dom.Element story in main.children) {
        if (story.localName == "article") {
          DateTime posted;
          try {
            posted = DateFormat("MMMM d, yyyy").parse(story
                .children.last.children[1].text
                .split("|")
                .first
                .replaceFirst("th", "")
                .replaceFirst("nd", "")
                .replaceFirst("rd", "")
                .trim());
          } catch (e) {
            posted = DateTime.now().subtract(Duration(
                hours: 24 *
                    7 *
                    52 *
                    3 /*Three Years back so they are at the bottom */));
          }

          newsStories.add(NewsStory(
              title: story.children.last.children.first.text,
              url: story.children.last.children.first.children.first
                  .attributes['href'],
              imageSRC: story.children.first.children.last.children.first
                  .attributes['src'],
              category: story.children.first.children.first.text,
              originCategory:
                  story.children.first.children.first.text.toLowerCase(),
              categoryURL:
                  story.children.first.children.first.attributes['href'],
              author: story.children.last.children[1].children.last.text
                  .replaceFirst("by", "")
                  .trim(),
              description: story.children.last.children[2].text,
              posted: posted));
        }
      }
      return newsStories;
    } catch (e) {
      return [];
    }
  }
}
