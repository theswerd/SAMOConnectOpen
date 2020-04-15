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
          posted = DateFormat("MMMM d, yyyy").parse(e.children[3].text.split("|").first.replaceFirst("Published on ", "").replaceFirst("th", "").replaceFirst("rd", "").trim());
        } catch (e) {
          posted = DateTime.now().subtract(Duration(hours: 24*7*52*3/*Three Years back so they are at the bottom */));
        }
         
        return NewsStory(
          category: e.children.first.text,
          categoryURL: e.children.first.children.first.attributes['href'],
          url: e.children[1].attributes['href'],
          imageSRC: e.children[1].children.first.attributes['src'],
          title: e.children[2].children.first.text.trim(),
          author: e.children[3].children.last.text,
          posted: posted
        );
      }).toList();

      return newsStories;
    } catch (e) {
      return [];
    }
  }
}
