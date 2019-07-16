
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class OldMap extends StatelessWidget{

  static String tag = "OldMap";
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.limeAccent,);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent[700],
        title: Text("Old Map"),
        ),
      body: WebView(
        initialUrl: "https://api.mapbox.com/styles/v1/swerd/cjw4hcm3u1xkd1cnw1zswdrub.html?fresh=true&title=true&access_token=pk.eyJ1Ijoic3dlcmQiLCJhIjoiY2p3NGV3bzBnMWhnaDQ5cXZlMHgzZG5rNyJ9.d_agU8wGRZYZUHOmrrHBjQ#16.1/34.011844/-118.486192/0",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}