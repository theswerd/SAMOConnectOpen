import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:package_info/package_info.dart';

class Constants {
  static Color primary = Color(0xff2B32B2);

  static String website = "https://samoconnect.page.link/SamoConnect";

  static Color lightMBlackDarkMWhite(context) {
    if (isMaterial(context)) {
      if (Theme.of(context) == null) {
        return CupertinoTheme.of(context).textTheme.navTitleTextStyle.color;
      } else {
        return Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : Colors.white;
      }
    } else {
      return CupertinoTheme.of(context).textTheme.navTitleTextStyle.color;
    }
  }

  static bool isBright(context) {
    if (isMaterial(context)) {
      return Theme.of(context).brightness == Brightness.light;
    } else {
      return CupertinoTheme.of(context)
              .textTheme
              .navTitleTextStyle
              .color
              .value ==
          Colors.black.value;
    }
  }

  static Future<String> packageVersion(context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    return (packageInfo.version + " (" + packageInfo.buildNumber + ")");
  }
}

class LocalStorageKeys {
  static String favoriteTeachers = "favoriteTeachers";
}

class SecureStorageKeys {
  static String storeLoginInfo = "storeLoginInfo";
  static String illuminatePassword = "illuminateP";
  static String illuminateUsername = "illuminateU";
}
