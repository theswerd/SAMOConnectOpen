import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class BulletinPage extends StatefulWidget {
  static String tag = "Bulletin-Page";
  @override
  _BulletinPageState createState() => _BulletinPageState();
}

class _BulletinPageState extends State<BulletinPage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text("Bulletin"),),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (c){
          print("It thihks it worksedd");
        },
        onPageFinished: (c){
        
          print("OT TTHINKS ITS DONEEEEEEEE");
        },
        initialUrl: "http://www.samohi.smmusd.org/BB.pdf",
      )
    );
  }
}
