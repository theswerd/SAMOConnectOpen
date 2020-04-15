import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mdi/mdi.dart';
import 'package:v17/pages/newsPage.dart';
import 'package:v17/pages/settingsPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformTabScaffold(
      tabController: PlatformTabController(),
      bodyBuilder: (c, i) {
        switch (i) {
          case 0:
            return NewsPage();

          case 1:
            return SettingsPage();
          default:
            return SettingsPage();
        }
      },
      iosTabs: (c) => CupertinoTabBarData(items: [
        BottomNavigationBarItem(icon: Icon(Mdi.newspaper)),
        BottomNavigationBarItem(icon: Icon(Icons.settings))
      ]),
      androidTabs: (c) => MaterialNavBarData(
        
        items: [
        BottomNavigationBarItem(
          icon: Icon(Mdi.newspaper),
          title: Text("News"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Mdi.accountSettings),
          title: Text("Settings"),
        ),
      ]),
    );
  }
}
