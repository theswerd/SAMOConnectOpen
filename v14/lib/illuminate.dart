import 'package:flutter/material.dart';
import 'color_loader_3.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:html/dom.dart'as dom;
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:launch_review/launch_review.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';


class Illuminate extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
 static String tag = "illuminate";
  Illuminate();

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  _IlluminateState createState() => new _IlluminateState();
}

class _IlluminateState extends State<Illuminate> with TickerProviderStateMixin {

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent[700],
        title: Text("Illuminate"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            color: Colors.white,
            splashColor: Colors.yellowAccent,
            onPressed: (){
              
            },
          )
        ],
      ),
      key: scaffoldKey,
      body: FutureBuilder(
        future:http.post("https://smmusd.illuminatehc.com/login_check",headers: {"cookie":"__cfduid=d95d00a3f9ad2849da154aeabcedaf3651561156057; _ga=GA1.2.657570029.1561156057; _gid=GA1.2.215629583.1561584153; PHPSESSID=l41idjhuc18h2oj9sp3khat765"},body: {"_username":"595537", "_password":"123456"}),
        builder: (c,s){
          if(s.hasError){
            return Center(child: Text("Network Handshake Error, Check your connection"),);
          }
          if(s.connectionState!=ConnectionState.done){
            return Center(child: ColorLoader3(),);
          }else{
            //print(s.data.body);
            dom.Document document = parse(s.data.body);
            print(document.body.innerHtml);
            http.Response response = s.data;
            return FutureBuilder(
              future:http.post("https://smmusd.illuminatehc.com/student-path",headers:{"cookies":response.headers["set-cookie"].toString()}),
              builder:(c,s){
                if(s.hasError){
                  return Text(s.error.toString());
                }
                if(s.connectionState!=ConnectionState.done){
                  return Center(child: ColorLoader3(),);
                }else{
                  http.Response innerResponse = s.data;
                  print("Headers:");
                  print(innerResponse.headers);
                  print("Body:");
                  dom.Document innerDoc =parse(innerResponse.body);
                  print(innerDoc.body);
                  return Text(innerDoc.body.innerHtml);
                }
              }
            );
          }
        },
      ),
    );
  }
              
                
}