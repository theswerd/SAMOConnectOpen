import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class TopBar extends StatelessWidget {
  TopBar(
    this.title, {
    this.trailing,
    this.leading,
  });
  final String title;
  final Widget trailing;
  final Widget leading;
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (c) => CupertinoSliverNavigationBar(
        largeTitle: Text(this.title),
        leading: this.leading,
        trailing: this.trailing != null
            ? Material(
                child: this.trailing,
                type: MaterialType.transparency,
              )
            : null,
      ),
      android: (c) => SliverAppBar(
        leading: this.leading,
        floating: true,
        title: Text(
          this.title,
        ),
        actions: [
          this.trailing ?? Container(),
        ],
      ),
    );
  }
}
