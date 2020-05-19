import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:v17/api/illuminate/illuminate.dart';
import 'package:v17/components/pageWithHeader.dart';
import 'package:v17/constants.dart';

class LoggedInPage extends StatefulWidget {
  LoggedInPage(this.illuminateAPI);

  final IlluminateAPI illuminateAPI;

  @override
  _LoggedInPageState createState() => _LoggedInPageState();
}

class _LoggedInPageState extends State<LoggedInPage> {
  ContentState gradesContentState;
  @override
  void initState() {
    super.initState();
    loadGrades();
  }

  @override
  Widget build(BuildContext context) {
    return PageWithHeader(
      title: "Illuminate",
      trailing: isMaterial(context)
          ? FlatButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.directions_walk,
              ),
              label: Text(
                "Logout",
              ),
            )
          : null,
      leading: isCupertino(context)
          ? CupertinoButton(
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios),
                  Text(
                    "Logout",
                  ),
                ],
              ),
              onPressed: () {},
            )
          : null,
      body: [
        bodyContent(),
      ],
    );
  }

  Widget bodyContent() {
    switch (this.gradesContentState) {
      case ContentState.loading:
        return SliverFillRemaining(
          child: Center(
            child: PlatformCircularProgressIndicator(),
          ),
        );
      case ContentState.loaded:
        return SliverList(
          delegate: SliverChildListDelegate(
            List.generate(
              widget.illuminateAPI.gradebook.classes.length,
              (index) {
                return PlatformWidget(
                  ios: (c) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Divider(
                        height: 1,
                        color: Constants.lightMBlackDarkMWhite(context),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 16.0,
                          ),
                          child: Row(
                            children: [
                              Text(
                                widget.illuminateAPI.gradebook.classes[index]
                                    .name,
                                style: TextStyle(
                                  color:
                                      Constants.lightMBlackDarkMWhite(context),
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Text(
                                widget.illuminateAPI.gradebook.classes[index]
                                    .grade,
                                style: TextStyle(
                                  color: widget.illuminateAPI.gradebook
                                      .classes[index].color,
                                ),
                              ),
                              Icon(
                                CupertinoIcons.right_chevron,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: Constants.lightMBlackDarkMWhite(context),
                      ),
                    ],
                  ),
                  android: (c) => ListTile(
                    onTap: (){},
                    title: Text(
                      widget.illuminateAPI.gradebook.classes[index].name,
                      style: TextStyle(
                        color: Constants.lightMBlackDarkMWhite(context),
                      ),
                    ),
                    subtitle: Text(
                      widget.illuminateAPI.gradebook.classes[index].teacher,
                    ),
                    trailing: Text(
                      widget.illuminateAPI.gradebook.classes[index].grade,
                      style: TextStyle(
                        color:
                            widget.illuminateAPI.gradebook.classes[index].color,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
        break;
      case ContentState.error:
        return SliverFillRemaining(
          child: Center(
            child: Text(
              "We got an error",
            ),
          ),
        );
      default:
        return null;
    }
  }

  void loadGrades() async {
    this.gradesContentState = ContentState.loading;
    if (await widget.illuminateAPI.getGradebook()) {
      setState(() {
        this.gradesContentState = ContentState.loaded;
      });
    } else {
      setState(() {
        //TODO: BUILD OUT ERROR UI
        this.gradesContentState = ContentState.error;
      });
    }
  }
}

enum ContentState { loading, loaded, error, none }
