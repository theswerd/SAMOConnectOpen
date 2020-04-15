import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:v17/constants.dart';
import './pages/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      builder: (c) => PlatformApp(
        title: 'SAMOHI',
        ios: (c) => CupertinoAppData(theme: CupertinoThemeData()),
        android: (c) => MaterialAppData(
          theme: ThemeData(
            primaryColor: Constants.primary,
            accentColor: Constants.primary,
            iconTheme: IconThemeData(color: Constants.primary),
          ),
          darkTheme: ThemeData.dark(),
        ),
        home: HomePage(),
      ),
    );
  }
}
