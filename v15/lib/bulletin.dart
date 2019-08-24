import 'package:flutter/material.dart';
import 'color_loader_3.dart';
import 'constants.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class BulletinPage extends StatefulWidget {
  static String tag = "Bulletin-Page";
  @override
  _BulletinPageState createState() => _BulletinPageState();
}

class _BulletinPageState extends State<BulletinPage> {
  @override
  Widget build(BuildContext context) {
    
    return WebviewScaffold(
      appBar: AppBar(
        backgroundColor: Constants.baseColor,
        title: Text("Daily Bulletin"),
      ),
      allowFileURLs: true,
      url: "www.samohi.smmusd.org/BB.pdf",
    );
    }
}
