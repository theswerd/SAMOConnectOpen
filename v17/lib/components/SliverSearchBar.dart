import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SliverSearchBar extends StatefulWidget {
  const SliverSearchBar(
      {@required this.searchFunction,
      @required this.title,
      this.hintText = ""});

  final ValueChanged<String> searchFunction;
  final String title;
  final String hintText;

  @override
  _SliverSearchBarState createState() => _SliverSearchBarState();
}

class _SliverSearchBarState extends State<SliverSearchBar> {
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (c) => CupertinoSliverNavigationBar(
        middle: Text(this.widget.title),
        largeTitle: Padding(
          padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
          child: CupertinoTextField(
              prefix: Icon(Icons.search),
              clearButtonMode: OverlayVisibilityMode.editing,
              onChanged: this.widget.searchFunction),
        ),
      ),
      android: (c) => SliverAppBar(
        floating: true,
        title: Text(this.widget.title),
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
                    hintText: this.widget.hintText,
                    border: InputBorder.none,
                  ),
                  onChanged: this.widget.searchFunction),
            ),
          ),
        ),
      ),
    );
  }
}
