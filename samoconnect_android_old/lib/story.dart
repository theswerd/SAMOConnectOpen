import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'color_loader_3.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart'as dom;
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';
class Story extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  final String header;
  final String link;
  final String by;
  final String when;
  Story({@required this.header,@required this.link,@required this.by, @required this.when});

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  _StoryState createState() => new _StoryState(header,link,by,when);
}

class _StoryState extends State<Story> with TickerProviderStateMixin {
String header;
String link;
String by;
String when;
   _StoryState(this.header,this.link,this.by,this.when);
  @override

  Widget build(BuildContext context) {
    print("WIDGET HEADER");
    print(header);
    print("WIDGET LINK");
    print(link);
    
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
              Share.share("Check out The SAMOHI News article: \""+header+"\" on SAMO Connect -- https://samoconnect.page.link/SamoConnect");
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
          try {
            
          
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
                //header
                return Center(
                  child: imageWidget,
                  
                );
              }else if(i==1){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(header,style:TextStyle(color: Colors.black,fontSize: 27,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                    Container(height: 6,),
                    Text(when,style:TextStyle(color: Colors.grey[800],fontSize: 23,),textAlign: TextAlign.center,),
                    Container(height: 6,),
                    Text(by,style:TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
                  ],
                );
              }
              else{
                return Padding(child:Text(stringList[i],style: TextStyle(color: Colors.black,fontSize: 20),),padding: EdgeInsets.symmetric(horizontal:15),);
              }
            },
            separatorBuilder: (c,i){
              return Container(height: 10,);
            },
          );
          } catch (e) {
            return Container(height: 0,);
          }
        }

        },
        )
    );
  }
}