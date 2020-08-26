import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter/cupertino.dart';

class Policy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (c) => CupertinoNavigationBar(
        middle: Text("Samohi Policy"),
      ),
      android: (c) => AppBar(centerTitle: true, title: Text("Samohi Policy")),
    );
  }
}
