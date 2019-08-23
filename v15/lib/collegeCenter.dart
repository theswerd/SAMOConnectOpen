import 'package:cloud_firestore/cloud_firestore.dart';
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

import 'constants.dart';

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
             Constants.showInfoBottomSheet(
               [
                 Constants.officialWebsiteAction(context, "http://www.samohi.smmusd.org/collegecenter/"),
                 Constants.ratingAction(context),
                
               ],
               context);
            
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
     body: FutureBuilder<QuerySnapshot>(
       future: Firestore.instance.collection("college").document("teachers").collection("teachers").getDocuments(),
       builder: (c,s){
         if(s.hasError){
           return Center(child: Text("Network Error"),);
         }else
         if(s.connectionState!=ConnectionState.done){
           return Center(child: ColorLoader3(),);
         }else{
           List<DocumentSnapshot> documents = s.data.documents;
           return ListView.separated(
             itemCount: documents.length,
             separatorBuilder: (c,i)=>Container(height: 25,),
             itemBuilder: (c,i){
               Map theCurrentDocument = documents[i].data;
               return Container(
                 padding: EdgeInsets.symmetric(horizontal: 30),
                 child: RaisedButton(
                   splashColor: Colors.redAccent[400],
                   color: Colors.white,
                   elevation: 15,
                   padding: EdgeInsets.all(15),
                   child: Column(
                     children: <Widget>[
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                          Text(theCurrentDocument["name"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          Text("Ext: "+theCurrentDocument["ext"],style: TextStyle(fontSize: 19,fontWeight: FontWeight.normal,color: Colors.grey[700]),),
                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           CupertinoButton(
                             padding: EdgeInsets.zero,
                             child: Text(theCurrentDocument["email"],style: TextStyle(fontSize: 19),),
                             onPressed: (){
                               showCupertinoModalPopup(
                                 context: context,
                                 builder:(c){
                                   return CupertinoActionSheet(
                                     cancelButton: Constants.cancelAction(context),
                                    title: Text(theCurrentDocument["name"]+"'s email is "+theCurrentDocument["email"]),
                                    actions: <Widget>[
                                      CupertinoActionSheetAction(
                                        isDefaultAction: true,
                                        child: Text("Share"),
                                        onPressed: (){
                                          Share.share(theCurrentDocument["name"]+"'s email is "+theCurrentDocument["email"]+". \n\nWant to find out more about the college center? Check it out on the new SAMOHI App -- https://samoconnect.page.link/SamoConnect");
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      CupertinoActionSheetAction(
                                        isDefaultAction: false,
                                        child: Text("Copy"),
                                        onPressed: (){
                                          Clipboard.setData(ClipboardData(text: theCurrentDocument["email"]));
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                   );
                                 }
                               );
                             },
                           ),
                           FloatingActionButton(
                             mini: true,
                             backgroundColor: Colors.indigoAccent[700],
                             child: Icon(Icons.link),
                             onPressed: (){
                               launch(theCurrentDocument["url"]);
                             },
                           )
                         ],
                       )
                     ],
                   ),
                   onPressed: (){

                   },
                 ),
               );
             },
           );
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
                   onTap: (){
                     launch(linkList[i]["url"]);
                   },
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