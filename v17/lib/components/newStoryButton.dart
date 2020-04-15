import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mdi/mdi.dart';
import 'package:v17/api/news/newsStory.dart';
import 'package:v17/constants.dart';
import 'package:v17/pages/newsPage/newsStoryPage.dart';


class NewsStoryButton extends StatelessWidget {
  const NewsStoryButton({
    Key key,
    @required this.story,
  }) : super(key: key);

  final NewsStory story;

  @override
  Widget build(BuildContext context) {
    Expanded imageSection = Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.only(
            left: isMaterial(context) ? 0 : 8,
            right: isMaterial(context) ? 8 : 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(story.imageSRC, loadingBuilder:
              (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
                child: PlatformCircularProgressIndicator());
          }),
        ),
      ),
    );

    return PlatformWidget(android: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20.0, vertical: 8),
        child: RaisedButton(
          color: Constants.isBright(context)
              ? Colors.white
              : Colors.grey[800],
          padding: EdgeInsets.symmetric(
              vertical: 17.0, horizontal: 16),
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (c) => NewsStoryPage(story))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(story.author,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      Text(story.timeAgo,
                          style: TextStyle(
                              color: Constants.isBright(context)
                                  ? Colors.grey[800]
                                  : Colors.grey[200],
                              fontSize: 14))
                    ],
                  ),
                  IconButton(
                    icon: Icon(Mdi.share),
                    onPressed: () {},
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  imageSection,
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.start,
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          story.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          story.description ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    }, ios: (context) {
      return Container(
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(context).push(
                CupertinoPageRoute(
                    builder: (c) => NewsStoryPage(story))),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: <Widget>[
                        Chip(
                          label: Text(
                            story.category,
                            style:
                                TextStyle(color: Colors.white),
                          ),
                          backgroundColor: story.categoryColor,
                        ),
                        Text(story.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Constants
                                    .lightMBlackDarkMWhite(
                                        context),
                                height: 1.4,
                                fontSize: 20))
                      ],
                    ),
                  ),
                  imageSection
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}