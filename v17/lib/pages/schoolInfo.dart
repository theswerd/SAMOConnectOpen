import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:v17/constants.dart';

class SchoolInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        PlatformWidget(
          ios: (c) => CupertinoSliverNavigationBar(
            middle: Text("School Information"),
            largeTitle: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CupertinoTextField(
                prefix: Icon(Icons.search),
                clearButtonMode: OverlayVisibilityMode.editing,
              ),
            ),
          ),
          android: (c) => SliverAppBar(
            title: Text("School Information"),
            bottom: PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 50),
                child: Card(
                    margin: EdgeInsets.all(10),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: "Search school information",
                          border: InputBorder.none,
                        ),
                      ),
                    ))),
          ),
        ),
      ],
    );
  }
}
