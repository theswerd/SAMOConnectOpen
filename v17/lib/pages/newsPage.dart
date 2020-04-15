import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v17/api/news/NewsAPI.dart';
import 'package:v17/api/news/newsStory.dart';
import 'package:v17/components/pageWithHeader.dart';
import 'package:v17/constants.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  bool hasLoadedInitially;
  bool hasLoadedPreferences;
  SharedPreferences sharedPreferences;
  List<String> preferences;
  List<NewsStory> newsStories = [];
  @override
  void initState() {
    super.initState();
    this.hasLoadedInitially = false;

    loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return PageWithHeader(title: "News", body: [
      if (this.hasLoadedInitially)
        PlatformWidget(
          ios: (c) => CupertinoSliverRefreshControl(
            onRefresh: () async {
              reGetNews();
            },
          ),
          android: (c) => SliverToBoxAdapter(
            child: Container(),
          ),
        ),
      if (!this.hasLoadedInitially)
        PlatformWidget(
          ios: (c) => SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.all(50),
                  child: CupertinoActivityIndicator())),
          android: (c) => SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Center(child: CircularProgressIndicator()))),
        ),
      if (this.hasLoadedInitially)
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 45,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: NewsStory.categories.length,
                    itemBuilder: (c, i) {
                      bool selected = this
                            .preferences
                            .contains(NewsStory.categories[i].code);
                      return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ChoiceChip(
                        label: Text(NewsStory.categories[i].title),
                        labelStyle: TextStyle(color: selected?Colors.white:Colors.black),
                        
                        selectedColor: NewsStory.categoryColors
                                .containsKey(NewsStory.categories[i].title)
                            ? NewsStory
                                .categoryColors[NewsStory.categories[i].title]
                            : Colors.blue,
                        backgroundColor: Constants.isBright(context)?null:Colors.grey[600],
                        selected: selected,
                        onSelected: (v) {
                          if(v){
                            this.preferences.add(NewsStory.categories[i].code);
                          }else{
                            this.preferences.remove(NewsStory.categories[i].code);
                          }
                          setState(() {
                            
                          });
                        },
                      ),
                    );
                    },
                  ),
                ),
              ),
              ...List.generate(
                this.newsStories.length,
                (index) {
                  NewsStory story = this.newsStories[index];
                  return Container(
                    child: Material(
                      color: Colors.transparent,
                      child: GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Chip(
                                      label: Text(
                                        story.category,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: story.categoryColor,
                                    ),
                                    Text(story.title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Constants.lightMBlackDarkMWhite(
                                                    context),
                                            height: 1.4,
                                            fontSize: 20))
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(story.imageSRC,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CupertinoActivityIndicator(),
                                      );
                                    }),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        )
    ]);
  }

  void getNews(String preference) async {
    newsStories.addAll(await NewsAPI.getLatestNews(preference));
    newsStories.sort((a, b) => a.posted.isAfter(b.posted) ? 0 : 1);
    setState(() {
      hasLoadedInitially = true;
    });
  }

  void reGetNews() async {
    setState(() {
      this.newsStories = [];
    });
    for (String preference in this.preferences) {
      getNews(preference);
      setState(() {});
    }
    return;
  }

  void loadPreferences() async {
    this.sharedPreferences = await SharedPreferences.getInstance();
    this.preferences = sharedPreferences.getStringList("newsPreferences") ??
        ["news", "sports"];
    for (String preference in this.preferences) {
      getNews(preference);
    }
  }
}
