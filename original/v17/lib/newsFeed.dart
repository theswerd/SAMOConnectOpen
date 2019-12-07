import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:v17/color_loader_3.dart';
import 'package:v17/story.dart';
import 'constants.dart';

import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';

class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> with TickerProviderStateMixin {
  TabController newsTabController;
  String tab1str = "News";
  String tab2str = "Sports";
  String tab3str = "Opinion";
  String tab4str = "Feature";
  @override
  void initState() {
    super.initState();
    newsTabController = new TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        indicatorColor: Colors.indigoAccent[700],
        controller: newsTabController,
        tabs: <Widget>[
          Tab(child: Constants.basicText(tab1str)),
          Tab(child: Constants.basicText(tab2str)),
          Tab(child: Constants.basicText(tab3str)),
          Tab(child: Constants.basicText(tab4str))
        ],
      ),
      body: TabBarView(
        controller: newsTabController,
        children: <Widget>[
          newsFeedBuilder(tab1str),
          newsFeedBuilder(tab2str),
          newsFeedBuilder(tab3str),
          newsFeedBuilder(tab4str),
        ],
      ),
    );
  }

  Widget newsFeedBuilder(url) {
    return FutureBuilder(
      future: get("https://www.thesamohi.com/category/" + url),
      builder: (c, s) {
        if (s.connectionState != ConnectionState.done) {
          return Center(child: ColorLoader3());
        } else if (s.hasError) {
          return Center(
              child: Text("Sorry, we are having trouble connecting",
                  textAlign: TextAlign.center));
        } else {
          Response response = s.data;
          String body = response.body;
          dom.Document document = parse(body);
          List<dom.Element> posts =
              document.getElementsByClassName("omc-blog-one");
          double padding = 30;
          double imageWidth =
              (MediaQuery.of(context).size.width - (padding * 2)) / 3;
          double textWidth =
              ((MediaQuery.of(context).size.width - (padding * 2)) / 3) * 2;

          return ListView.separated(
            itemCount: posts.length,
            padding: EdgeInsets.all(padding),
            separatorBuilder: (c, i) => Divider(height: 25),
            itemBuilder: (c, i) {
              try {
                dom.Element post = posts[i];
                String url = post.children[1].attributes['href'];
                String title = post.children[2].text.trim();
                String description = post.children[4].text;
                String metadata = post.children[3].text;
                String publishedOn = metadata.split("|").first.trim();
                String writtenBy = metadata.split("|").last.trim();

                String imageURL = post
                    .getElementsByClassName("omc-image-blog-one")[0]
                    .attributes['src']
                    .toString();
                return FlatButton(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    title,
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.left,
                                  ),
                                  Container(height: 10),
                                  Text(writtenBy, textAlign: TextAlign.left, style: TextStyle(fontSize: 19),)
                                ],
                              ),
                              width: textWidth,
                              alignment: Alignment.topCenter,
                            ),
                            FutureBuilder(
                              future: get(imageURL),
                              builder: (c, s) {
                                if (s.connectionState != ConnectionState.done) {
                                  return Container(
                                    child: ColorLoader3(),
                                    height: imageWidth,
                                    width: imageWidth,
                                  );
                                } else if (s.hasError) {
                                  return Container();
                                } else {
                                  return Image.memory(
                                    s.data.bodyBytes,
                                    height: imageWidth,
                                    width: imageWidth,
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 20,
                      ),
                      Container(child: Text(description), padding: EdgeInsets.all(10)),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (c) => Story(
                              link: url,
                              by: writtenBy,
                              header: title,
                              when: publishedOn,
                              imageURL: imageURL,
                            ),
                        fullscreenDialog: true,
                        maintainState: true));
                  },
                );
              } catch (e) {
                return Container();
              }
            },
          );
        }
      },
    );
  }
}
