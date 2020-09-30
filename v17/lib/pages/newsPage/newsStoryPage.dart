import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:http/http.dart';
import 'package:v17/api/news/newsStory.dart';
import 'package:v17/components/pageWithHeader.dart';
import 'package:v17/constants.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:v17/pages/newsPage/newsAuthorPage.dart';

class NewsStoryPage extends StatefulWidget {
  NewsStory story;

  NewsStoryPage(this.story);

  @override
  _NewsStoryPageState createState() => _NewsStoryPageState();
}

class _NewsStoryPageState extends State<NewsStoryPage> {
  String htmlData;
  bool loadedHTML;
  String authorURL;

  @override
  void initState() {
    super.initState();

    htmlData = "";
    loadedHTML = false;

    getStory();
  }

  @override
  Widget build(BuildContext context) {
    return PageWithHeader(
      title: widget.story.title,
      titleBig: false,
      body: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Image.network(
                widget.story.imageSRC,
                fit: BoxFit.fitWidth,
              ),
              loadedHTML
                  ? Html(
                      data: this.htmlData,
                      customEdgeInsets: (n) {
                        return EdgeInsets.symmetric(vertical: 8);
                      },
                      defaultTextStyle: TextStyle(
                          color: Constants.isBright(context)
                              ? Colors.black
                              : Colors.grey[300],
                          fontSize: 16),
                      padding: EdgeInsets.all(10),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: Center(child: PlatformCircularProgressIndicator()),
                    ),
              if (loadedHTML && authorURL != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PlatformButton(
                    child: Text("Read more by " + widget.story.author),
                    onPressed: () {
                      Navigator.of(context).push(platformPageRoute(
                          context: context,
                          builder: (c) => AuthorPage(
                              authorName: widget.story.author,
                              authorURL: this.authorURL)));
                    },
                  ),
                ),
              if (loadedHTML && widget.story.categoryURL != null)
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    Text(
                      "Read more ",
                      style: TextStyle(
                          color: Constants.lightMBlackDarkMWhite(context),
                          fontSize: 18),
                    ),
                    ActionChip(
                      label: Text(
                        widget.story.category,
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: widget.story.categoryColor,
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
              SizedBox(height: 75),
            ],
          ),
        )
      ],
    );
  }

  void getStory() async {
    Response response = await get(widget.story.url);
    dom.Document newsHTMLFull = parse(response.body);
    dom.Element articleHTML = newsHTMLFull.getElementById("omc-full-article");
    articleHTML.children.first.remove(); //REMOVE IMAGE FROM HTML

    String authorURL = articleHTML
        .getElementsByClassName("omc-authorbox")
        .first
        .children
        .last
        .children
        .first
        .attributes['href'];

    bool articleDone = false;
    for (dom.Element element in articleHTML.children) {
      if (articleDone) {
        element.remove();
        continue;
      } else {
        if (element.classes.contains("omc-authorbox")) {
          element.remove();
          articleDone = true;
          continue;
        }
      }
    }
    setState(() {
      this.authorURL = authorURL;
      this.htmlData = articleHTML.innerHtml;
      this.loadedHTML = true;
    });
  }
}
