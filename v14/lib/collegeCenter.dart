import 'package:flutter/material.dart';
import 'color_loader_3.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart'as dom;
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';

class CollegeCenter extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
 static String tag = "collegeCenter";
  CollegeCenter();

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  _CollegeCenterState createState() => new _CollegeCenterState();
}

class _CollegeCenterState extends State<CollegeCenter> with TickerProviderStateMixin {

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  IconButton shareButton = IconButton(
    icon: Icon(Icons.share),
    splashColor: Colors.yellowAccent,
    onPressed: (){
      Share.share("Want to go to college? You can see the College Center on SAMO Connect -- https://samoconnect.page.link/SamoConnect");
    },
  );
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     key: scaffoldKey,
     appBar: AppBar(
       backgroundColor: Colors.indigoAccent[700],
       title: Text("College Center"),
       actions: <Widget>[
         shareButton,
           IconButton(
           icon: Icon(MdiIcons.informationOutline),
           onPressed: (){
            showModalBottomSheet(
              context: context,
              builder: (c){
                return CupertinoActionSheet(
                  title: Text("Extra Info"),
                  actions: <Widget>[
                    CupertinoActionSheetAction(
                      child: Text("Official Website"),
                      onPressed: (){
                        launch("http://www.samohi.smmusd.org/collegecenter/");
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: Text("Give us a good review?"),
                      onPressed: (){
                        LaunchReview.launch(
                          iOSAppId: "1465501734"
                        );
                      },
                    )
                  ],
                );
              }
            );
           },
         ),
 
         IconButton(
           icon: Icon(MdiIcons.menu),
           onPressed: (){
            scaffoldKey.currentState.openEndDrawer();
           },
         ),
             ],
     ),
     body: FutureBuilder(
       future:http.get("http://www.samohi.smmusd.org/collegecenter/"),
       builder: (c,s){
         if(s.hasError){
           return Center(child: Text("HandShake Failure"),);
         }
         if(s.connectionState!=ConnectionState.done){
           return Center(child: ColorLoader3());
           }else{
             dom.Document document = parse(s.data.body);
             dom.Element p1 =document.body;
             dom.Element tableBody = p1.children[0].children[0].children[0].children[4].children[0].children[0].children[0];
             List<dom.Element> advisors =tableBody.children[1].children[0].children[0].children[0].children[0].children[1].children[0].children[0].children[2].children[1].children[0].children[0].children[0].children[0].children[0].children[0].children[1].children;
             List formattedAdvisors = [];
             for (var advisor in advisors) {
               print("NEW ADVISTOR");
               String advistorText = advisor.children[0].text;
               print(advistorText.split('\n')[0].trim());
               print(advistorText.split('\n')[1].trim());
               print(advistorText.split('\n')[2].trim().split('ext. ').last);
               print(advistorText.split('\n')[3].trim());
               var advisorMap = new Map();
               advisorMap["name"] = advistorText.split('\n')[0].trim();
               advisorMap["email"] = advistorText.split('\n')[1].trim();
               advisorMap["ext"] = advistorText.split('\n')[2].trim().split('ext. ').last;
               advisorMap["url"] = advistorText.split('\n')[3].trim();
               formattedAdvisors.add(advisorMap);
               //print(advistorText.split('\n').length);


             }
             return ListView.separated(
               itemCount: formattedAdvisors.length,
               itemBuilder: (c,i){
                 return Container(
                   padding: EdgeInsets.symmetric(horizontal: 20),
                   child: RaisedButton(
                     onPressed: (){},
                     highlightColor: Colors.white,
                     splashColor: Colors.white,
                     color: Colors.white,
                     padding: EdgeInsets.all(20),
                     elevation: 10,
                     child: Column(
                       children: <Widget>[
                         Row(children: <Widget>[
                           Text(formattedAdvisors[i]["name"],style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                           Expanded(child: Container(),),
                           Text("x"+formattedAdvisors[i]["ext"],style: TextStyle(color: Colors.grey[700],fontSize: 16,fontWeight: FontWeight.normal),),

                         ],),
                         Row(
                           children: <Widget>[
                             CupertinoButton(
                               padding: EdgeInsets.zero,
                               child: Text(formattedAdvisors[i]["email"]),
                               onPressed: (){
                                 Clipboard.setData(ClipboardData(text: formattedAdvisors[i]["email"]));
                                 showCupertinoModalPopup(
                                   context: context,
                                   builder: (c){
                                     return AlertDialog(
                                      title: Text("Copied!"),
                                      content: Text("Your advisors email has been copied to your clipboard."),
                                      actions: <Widget>[FlatButton(
                                        child: Text("OK"),
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },
                                      )],
                                     );
                                   }
                                 );
                               },
                             ),
                             Expanded(child: Container(),),
                             FloatingActionButton(
                               mini: true,
                               backgroundColor: Colors.indigoAccent[700],
                               child: Icon(Icons.link),
                               onPressed: (){
                                 launch(formattedAdvisors[i]["url"]);
                               },
                             )
                           ],
                         )
                       ],
                     ),
                   ),
                 );
               },
               separatorBuilder: (c,i){
                 return Container(height: 30,);
               },
             );
             //print(advisors);
             return Container(color: Colors.black,);
           }
       },
     ),
     endDrawer: Drawer(
       
       child: FutureBuilder(
         future:http.get("http://www.samohi.smmusd.org/collegecenter/"),
         builder: (c,s){
           if(s.connectionState!=ConnectionState.done){
             return Center(child: ColorLoader3(),);
           }else{
             http.Response response = s.data;
             dom.Document doc =parse(response.body);
             dom.Element p1 = doc.body;
             //GETS BODY SECTION
             dom.Element p2 = p1.children[0].children[0].children[0].children[4];
             //LIST
             dom.Element p3 = p2.children[0].children[0].children[0].children[1];

             //LIST DATA
             List<dom.Element>  p4 = p3.children[0].children[0].children[0].children[0].children[1].children[0].children[0].children[0].children[0].children[0].children[0].children[0].children[0].children[1].children[0].children;
             print("P4");
             print(p4);
             List linkList = [];
             for (dom.Element item in p4) {
              print(item.children[1].text.trim());
              print(item.children[1].innerHtml.trim().split('"')[1]);
              Map thisLink = new Map();
              thisLink["name"]=item.children[1].text.trim();
              thisLink["url"]=item.children[1].innerHtml.split('"')[1].trim();
              linkList.add(thisLink);
             }
             //linkList.insert(0, "");
             return ListView.separated(
               padding: EdgeInsets.zero,
               itemCount: linkList.length,
               separatorBuilder: (c,i){
                 return Divider(height: 1,);
               },
               itemBuilder: (c,i){
                 if(i==0){
                   return DrawerHeader(
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.indigoAccent[700]
          ),
          
          child: Image.asset("assets/logo.png"),
          padding: EdgeInsets.all(15),
        );    
                 }
                 Widget link = Container(color: Colors.white,);
                 if(linkList[i]["url"]!=null&&linkList[i]["url"]!=""){
                   link =FloatingActionButton(
                     mini: true,
                     backgroundColor: Colors.indigoAccent[700],
                     //hoverElevation: ,
                     child: Icon(Icons.link),
                     onPressed: (){
                       launch(linkList[i]["url"]);
                     },
                   );
                 }
                 return ListTile(
                   dense: false,
                   title: Text(linkList[i]["name"]),
                   trailing: link
                 );
               },
             );
             return Container(color: Colors.black,);
           }
         },
       ),
     ),
     //al: ,
    // endDrawer: DrawerAlignment.start,
   );
  }
}