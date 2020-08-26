import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mdi/mdi.dart';
import 'package:v17/constants.dart';
import 'package:v17/pages/gradebookPage/gradesPage.dart';
import 'package:v17/pages/newsPage/newsPage.dart';
import 'package:v17/pages/staffDirectory/staffDirectory.dart';
import 'package:v17/pages/settings/settingsPage.dart';
import 'package:v17/pages/schoolinfo/schoolinfo.dart';

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
            return StaffDirectory();
          case 2:
            return Info();
          case 3:
            return GradesPage();
          case 4:
            return SettingsPage();
          default:
            return SettingsPage();
        }
      },
      iosTabs: (c) => CupertinoTabBarData(items: [
        BottomNavigationBarItem(
          icon: Icon(Mdi.newspaper),
          title: Text(
            "News",
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Mdi.teach),
          title: Text(
            "Staff Directory",
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Mdi.school),
          title: Text(
            "School Info",
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Mdi.book),
          title: Text(
            "Grades",
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text(
            "Settings",
          ),
        ),
      ]),
      androidTabs: (c) => MaterialNavBarData(
          selectedItemColor:
              Constants.isBright(context) ? Constants.primary : Colors.white,
          unselectedItemColor: Constants.isBright(context)
              ? Constants.primary.withOpacity(.9)
              : Colors.white70,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Mdi.newspaper),
              title: Text(
                "News",
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Mdi.teach),
              title: Text(
                "Staff Directory",
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Mdi.school,
              ),
              title: Text(
                "School Info",
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Mdi.book,
              ),
              title: Text(
                "Grades",
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Mdi.accountSettings,
              ),
              title: Text(
                "Settings",
              ),
            ),
          ]),
    );
  }
}
