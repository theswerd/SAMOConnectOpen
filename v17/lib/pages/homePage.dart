import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mdi/mdi.dart';
import 'package:v17/constants.dart';
import 'package:v17/pages/gradesPage.dart';
import 'package:v17/pages/newsPage/newsPage.dart';
import 'package:v17/pages/schoolInfo.dart';
import 'package:v17/pages/settings/settingsPage.dart';

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
            return SchoolInfo();
          case 2:
            return GradesPage();
          case 3:
            return SettingsPage();
          default:
            return SettingsPage();
        }
      },
      iosTabs: (c) => CupertinoTabBarData(items: [
        BottomNavigationBarItem(
          icon: Icon(Mdi.newspaper),
          title: Text("News"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Mdi.school),
          title: Text("School Info"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Mdi.book),
          title: Text("Grades"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text("Settings"),
        ),
      ]),
      androidTabs: (c) => MaterialNavBarData(
        selectedItemColor: Constants.isBright(context)?Constants.primary:null,
        unselectedItemColor: Constants.isBright(context)?Constants.primary.withOpacity(.9):null,
        items: [
        BottomNavigationBarItem(
          icon: Icon(Mdi.newspaper),
          title: Text("News"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Mdi.school),
          title: Text("School Info"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Mdi.book),
          title: Text("Grades"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Mdi.accountSettings),
          title: Text("Settings"),
        ),
      ]),
    );
  }
}
