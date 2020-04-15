import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:v17/api/news/NewsAPI.dart';
import 'package:v17/api/news/newsStory.dart';
import 'package:v17/components/newStoryButton.dart';
import 'package:v17/components/pageWithHeader.dart';

class AuthorPage extends StatefulWidget {

  String authorName;
  String authorURL;


  AuthorPage({
    @required this.authorName,
    @required this.authorURL,
  });

  @override
  _AuthorPageState createState() => _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage> {
  List<NewsStory> stories;

  bool hasLoaded;

  @override
  void initState() {
    super.initState();
    hasLoaded = false;

    getArtistStories();

  }

  @override
  Widget build(BuildContext context) {
    return PageWithHeader(
      title: this.widget.authorName,
      body: <Widget>[
        SliverList(delegate: SliverChildListDelegate([
        ...(hasLoaded?List.generate((this.stories??[]).length, (index) => NewsStoryButton(story: this.stories[index])):[Padding(
          padding: EdgeInsets.only(top: 36),
          child: Center(child: PlatformCircularProgressIndicator(),),
        
        )])
        ]))
      ],
    );
  }

  void getArtistStories()async{
    List<NewsStory> authorStories = await NewsAPI.getArtistStories(widget.authorURL);
    setState(() {
      this.stories = authorStories;
      this.hasLoaded = true;
    });
    
  }

  
}