import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class TopBar extends StatelessWidget {
  TopBar(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (c) =>CupertinoSliverNavigationBar(largeTitle: Text(this.title)),
      android: (c) => SliverAppBar(
        floating: true,
        title: Text(this.title),
      ),
    );
  }
}
