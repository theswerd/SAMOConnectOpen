import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'color_loader_3.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart'as dom;
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';
class Story extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  final String header;
  final String link;
  Story({@required this.header,@required this.link});

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  _StoryState createState() => new _StoryState(header,link);
}

class _StoryState extends State<Story> with TickerProviderStateMixin {
String header;
String link;
double textSize = 20;
   _StoryState(this.header,this.link);
  @override

  Widget build(BuildContext context) {
    print("WIDGET HEADER");
    print(header);
    print("WIDGET LINK");
    print(link);
    
      return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: Text(header),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.format_size),
            splashColor: Colors.yellow,
            onPressed: (){
              setState(() {
                if(textSize==20){
                  textSize=25;
                }else{
                  textSize=20;
                }

              });
            },
            ),
          IconButton(
            icon: Icon(Icons.info_outline),
            splashColor: Colors.yellow,
            onPressed: (){
              showModalBottomSheet(
                backgroundColor: Colors.white,
                context: context,
                builder: (c){
                  return CupertinoActionSheet(
                    title: Text("Extra Info"),
                    actions: <Widget>[
                      CupertinoActionSheetAction(
                        child: Text("Official Website"),
                        onPressed: (){
                          launch(this.link);
                        },
                      ),
                      CupertinoActionSheetAction(
                        child: Text("Give us a good review?"),
                        onPressed: (){
                          LaunchReview.launch(
                            iOSAppId: "1465501734"
                          );
                        },
                      ),
                      //http://www.nphs.org/news/pdf/AttendanceCAEDCode.pdf
                    ],
                  );
                }
              );
            },
            padding: EdgeInsets.zero,
          )
        ],
        ),
        body: FutureBuilder(
          future:http.get(link),
          builder: (c,s){
            if(s.hasError){
          String error = "Network failure";
          if(s.error.runtimeType.toString()=="SocketException"){
            error = "Handshake Failure";
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("ERROR",style: TextStyle(color: Colors.black,fontSize: 25),),
              SizedBox(height: 10),
              Text(error,style: TextStyle(color: Colors.grey[600]),),
              
            ],
          );
        }
        if(s.connectionState!=ConnectionState.done){
          return Center(
            child: ColorLoader3(),
          );
        }else{
          print("SNAPSHOT DATA");
          print(s.data);
          http.Response theResponse =s.data;
          print("BODY::");
          print(theResponse.body);
          //omc-full-article
          var document = parse(theResponse.body);
          var article = document.getElementById("omc-full-article");
          var image = document.getElementsByClassName("featured-full-width-top wp-post-image");
          String imageURL = '';
          for (var item in image) {
            print("The IMAGE ITEM:");
            print(item.outerHtml.split("""\"""")[1]);
            imageURL = item.outerHtml.split("""\"""")[1];
          }
          print("THE ARTICLE EQUALS2:");
          print(article.children);
          List<dom.Element> paragraphs = article.children;
          List stringList  = [""];
          for (int i = 0; i < paragraphs.length; i++) {
            var item = paragraphs[i];
            if(item.localName=="p"){
            print("ITEM EQALZZZ");
            print(item.text);

            if(item.text!=null||item.text==""){
            stringList.add(item.text);
            }else{
            stringList.add('\n');

            }
            
            }else{
              paragraphs.removeAt(i);
            }
          } 
          stringList.insert(0, "");
          print("IMAGE:::::");
          print(image[0].attributes["src"]);
          FutureBuilder imageWidget =FutureBuilder(
            future: http.get(image[0].attributes["src"]),
            builder: (c,s){
              if(s.hasError){
                return Container(height: 0,);
              }if(s.connectionState!=ConnectionState.done){
                return Center(child: ColorLoader3(),);
              }else{
                return Image.memory(s.data.bodyBytes,fit: BoxFit.fitWidth,alignment: Alignment.center,semanticLabel: "Story Image",width: MediaQuery.of(context).size.width,);
              }
            },
          );
          return 
            ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: stringList.length,
            itemBuilder: (c,i){
              if(i==0){
                return Center(
                  child: imageWidget,
                  
                );
              }else{
                return Padding(child:Text(stringList[i],style: TextStyle(color: Colors.black,fontSize: textSize),),padding: EdgeInsets.symmetric(horizontal:15),);
              }
            },
            separatorBuilder: (c,i){
              return Container(height: 10,);
            },
          );
          
        }

        },
        )
    );
  }
}