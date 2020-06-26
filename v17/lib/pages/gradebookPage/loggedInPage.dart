import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:v17/api/contentState.dart';
import 'package:v17/api/illuminate/illuminate.dart';
import 'package:v17/components/pageWithHeader.dart';
import 'package:v17/constants.dart';
import 'package:v17/pages/gradebookPage/classPage.dart';

import '../../api/illuminate/class.dart';
import '../../components/CustomListTile.dart';

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
        if (isCupertino(context))
          CupertinoSliverRefreshControl(
            onRefresh: loadGrades,
          ),
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
                Class currentClass =
                    widget.illuminateAPI.gradebook.classes[index];
                return CustomListTile(
                  title: currentClass.name,
                  titleTextStyle: TextStyle(
                    fontSize: 17,
                  ),
                  trailingWidget: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                    child: Container(
                      padding: Constants.isBright(context)
                          ? EdgeInsets.all(
                              8,
                            )
                          : null,
                      color: Constants.isBright(context) ? Colors.black : null,
                      child: Text(
                        currentClass.grade,
                        style: TextStyle(
                          color: currentClass.color,
                          fontSize: 17,
                          fontWeight: Constants.isBright(
                            context,
                          )
                              ? FontWeight.w800
                              : null,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () => goToClassPage(index),
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

  Future goToClassPage(int index) {
    return Navigator.of(context).push(
      platformPageRoute(
        context: context,
        builder: (c) => CupertinoScaffold(
          body: ClassPage(
            widget.illuminateAPI.gradebook.classes[index],
            widget.illuminateAPI,
          ),
        ),
      ),
    );
  }

  Future<void> loadGrades() async {
    setState(() {
      this.gradesContentState = ContentState.loading;
    });

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
