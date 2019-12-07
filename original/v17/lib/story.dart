import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'color_loader_3.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart'as dom;
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';
import 'constants.dart';
class Story extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  final String header;
  final String link;
  final String by;
  final String when;
  final String imageURL;
  Story({@required this.header,@required this.link,@required this.by, @required this.when, @required this.imageURL});

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  _StoryState createState() => new _StoryState(header,link,by,when, imageURL);
}

class _StoryState extends State<Story> with TickerProviderStateMixin {
String header;
String link;
String by;
String when;
String imageURL;
   _StoryState(this.header,this.link,this.by,this.when, this.imageURL);
  @override

  Widget build(BuildContext context) {

    
      return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: Text("The SAMOHI News"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share,color: Colors.white,),
            splashColor: Colors.yellowAccent,
            onPressed: (){
              Share.share("Check out The SAMOHI News article: \""+header+"\" here: "+this.link);
            },
          ),
          IconButton(
            icon: Icon(Icons.info_outline),
            splashColor: Colors.yellow,
            onPressed: (){
              Constants.showInfoBottomSheet(
                [
                      CupertinoActionSheetAction(
                        child: Text("View on Website"),
                        onPressed: (){
                          launch(this.link);
                        },
                      ),
                    ],context);
            })
        ],
        ),
        body: FutureBuilder(
          future:http.get(link),
          builder: (c,s){
            if(s.connectionState!=ConnectionState.done){
              return Center(child: ColorLoader3());
            }else if(s.hasError){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(child: Text("Sorry, we are having trouble accessing this page", textAlign: TextAlign.center,)),
                  FlatButton(
                    child: Text("Click here to view on The SAMOHI website"),
                    onPressed: (){
                      launch(this.link);
                    },
                  ),
                ],
              );
            }else{
              dom.Document theDoc = parse(s.data.body);
              List<dom.Element> articleParts = theDoc.getElementById("omc-full-article").children;
              articleParts.removeAt(0);
              articleParts.removeAt(0);
              List paragraphs= [];
              for (int i = 0; i < articleParts.length; i++) {
                dom.Element articlePart = articleParts[i];
                if(articlePart.children.length==1){
                  paragraphs.add(articlePart.children[0].innerHtml);
                }
              }
              String paragraphStr = paragraphs.join("\n\n");
              paragraphStr = paragraphStr.replaceAll("&nbsp;", "");
              return ListView(
                children: <Widget>[
                  FutureBuilder(
                    future: http.get(this.imageURL),
                    builder: (c,s){
                      if(s.connectionState!=ConnectionState.done){
                        return Container(
                          child: Center(child: ColorLoader3()),
                          height: MediaQuery.of(context).size.width-50,
                          width: MediaQuery.of(context).size.width,
                        );
                      }else if(s.hasError){
                        print("WE got an error?");
                        print(s.error);
                        return Container(height: 0);
                      }else{
                        return Image.memory(s.data.bodyBytes, height: MediaQuery.of(context).size.width-50, width: MediaQuery.of(context).size.width, fit: BoxFit.cover);
                      }
                    },
                  ),
                  
                  Text(header, textAlign: TextAlign.center, style: TextStyle(fontSize: 26),),
                  Divider(height: 20,),
                  Text(by, textAlign: TextAlign.center, style: TextStyle(fontSize: 24),),
                  Divider(height: 10),
                  Container(
                    padding: EdgeInsets.all(30),
                    child: Text(paragraphStr, style: TextStyle(fontSize: 20),),
                  )
                  
                ],
              );
            }
          }
        )
    );
  }
}