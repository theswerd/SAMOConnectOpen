import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v17/constants.dart';
import './pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if (!sharedPreferences.containsKey("Material")) {
    runApp(
      MyApp(),
    );
  } else {
    if (sharedPreferences.getBool("Material")) {
      runApp(
        MyApp(
          targetPlatform: TargetPlatform.android,
        ),
      );
    } else {
      runApp(
        MyApp(
          targetPlatform: TargetPlatform.iOS,
        ),
      );
    }
  }
}

class MyApp extends StatelessWidget {
  final TargetPlatform targetPlatform;

  MyApp({
    this.targetPlatform,
  });
  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      initialPlatform: this.targetPlatform,
      builder: (c) => PlatformApp(
        title: 'SAMOHI',
        ios: (c) => CupertinoAppData(
          theme: CupertinoThemeData(
            primaryContrastingColor: Constants.primary,
          ),
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
        ),
        android: (c) => MaterialAppData(
          theme: ThemeData(
            primaryColor: Constants.primary,
            accentColor: Constants.primary,
            iconTheme: IconThemeData(color: Constants.primary),
          ),
          darkTheme: ThemeData.dark().copyWith(accentColor: Constants.primary),
        ),
        home: HomePage(),
      ),
    );
  }
}
