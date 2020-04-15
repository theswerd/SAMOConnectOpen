import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mdi/mdi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v17/api/news/NewsAPI.dart';
import 'package:v17/api/news/newsStory.dart';
import 'package:v17/components/newStoryButton.dart';
import 'package:v17/components/pageWithHeader.dart';
import 'package:v17/constants.dart';
import 'package:v17/pages/newsPage/newsStoryPage.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  bool hasLoadedInitially;
  bool hasLoadedPreferences;
  bool currentlyLoading;
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
          ios: (c) => CupertinoSliverRefreshControl(onRefresh: resetNews),
          android: (c) => SliverToBoxAdapter(child: Container()),
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
      if (this.hasLoadedInitially) newsBody(context)
    ]);
  }

  SliverList newsBody(BuildContext context) {
    return SliverList(
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
                  bool selected =
                      this.preferences.contains(NewsStory.categories[i].code);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ChoiceChip(
                      label: Text(NewsStory.categories[i].title),
                      labelStyle: TextStyle(
                          color: selected ? Colors.white : Colors.black),
                      selectedColor: NewsStory.categoryColors
                              .containsKey(NewsStory.categories[i].title)
                          ? NewsStory
                              .categoryColors[NewsStory.categories[i].title]
                          : Colors.blue,
                      backgroundColor:
                          Constants.isBright(context) ? null : Colors.grey[600],
                      selected: selected,
                      onSelected: (v) {
                        if (v) {
                          this.preferences.add(NewsStory.categories[i].code);

                          this.sharedPreferences.setStringList(
                              "newsPreferences", this.preferences);
                          getNews(NewsStory.categories[i].code);
                        } else {
                          this.preferences.remove(NewsStory.categories[i].code);
                          this.sharedPreferences.setStringList(
                              "newsPreferences", this.preferences);

                          removeNewsCategory(NewsStory.categories[i].code);
                        }
                        setState(() {});
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          ...(this.newsStories.isNotEmpty
              ? List.generate(
                  this.newsStories.length,
                  (index) {
                    NewsStory story = this.newsStories[index];

                    return NewsStoryButton(story: story);
                  },
                )
              : [
                  (this.currentlyLoading
                      ? CupertinoActivityIndicator()
                      : Text(
                          "Please select a news category",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ))
                ])
        ],
      ),
    );
  }

  void getNews(String preference) async {
    setState(() {
      currentlyLoading = true;
    });
    newsStories.addAll(await NewsAPI.getLatestNews(preference));
    newsStories.sort((a, b) => a.posted.isAfter(b.posted) ? 0 : 1);
    setState(() {
      hasLoadedInitially = true;
      currentlyLoading = false;
    });
  }

  void removeNewsCategory(String preference) {
    newsStories.removeWhere((element) =>
        element.originCategory.toLowerCase() == preference.toLowerCase());
    setState(() {});
  }

  Future<bool> resetNews() async {
    setState(() {
      this.newsStories = [];
    });
    for (String preference in this.preferences) {
      getNews(preference);
      setState(() {});
    }
    return true;
  }

  void loadPreferences() async {
    this.sharedPreferences = await SharedPreferences.getInstance();
    this.preferences =
        sharedPreferences.getStringList("newsPreferences") ?? ["news"];

    if(this.preferences.isEmpty)
      preferences.add("news");
    for (String preference in this.preferences) {
      getNews(preference);
    }
  }
}
