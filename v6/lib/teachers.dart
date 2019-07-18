

import 'package:flutter/material.dart';
import 'color_loader_3.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart' as mIcons;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' as s;
import 'package:launch_review/launch_review.dart';

class Teachers extends StatefulWidget {
  static String tag = "teachers";
  @override
  _TeachersState createState() => new _TeachersState();
}

class _TeachersState extends State<Teachers> {
  String _platformVersion = 'Unknown';
  Widget titleText =Text("Teachers");
  bool isSearching = false;
  Widget title =Text("Teachers");
  List<dom.Element> teachers = [];
  
  Widget searchButton = IconButton(
    icon: Icon(Icons.search),
    color: Colors.red,
    onPressed: (){

    },
  );
  Widget body = Container(color: Colors.white,);

  @override
  initState() {
    super.initState();
    setState(() {
       body = FutureBuilder(
           future:http.get("http://www.samohi.smmusd.org/Admin/staff.html"),
           builder: (c,s){
             if(s.hasError){
               return Center(
                 child: Text("Handshake Failure",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 20),)
                 );
             }
             if(s.connectionState!=ConnectionState.done){
               return Center(child:ColorLoader3());
             }else{
               http.Response response = s.data;
               String data = response.body;
               dom.Document doc = parse(data);
               teachers = doc.body.children[0].children[0].children[0].children.last.children[0].children.last.children[0].children;
               //teachers = doc.body.children[0].children[0].children[0].children[4].children[0].children[0].children[0].children[2].children[0].children[0].children[0].children;
               //teachers.removeAt(0); 
               return teacherListView(teachers);
             }
           },
         );

 
     //MOVE BODY BACK WHEN DONE
    });
  }
 @override
 Widget build(BuildContext context) {
     Widget infoButton =IconButton(
    icon: Icon(mIcons.MdiIcons.informationOutline),
    splashColor: Colors.yellow,
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
                  launch("http://www.samohi.smmusd.org/Admin/staff.html");
                },
              ),
              CupertinoActionSheetAction(
                child: Text("Make a suggestion"),
                onPressed: (){
                 Navigator.of(context).pop();
                 showCupertinoDialog(
                   context: context,
                   builder: (c){
                     TextEditingController sController =  TextEditingController();
                     return CupertinoAlertDialog(
                       title: Text("Suggestions"),
                       content: CupertinoTextField(
                         autofocus: true,
                         clearButtonMode: OverlayVisibilityMode.editing,
                         controller:sController,

                       ),
                       actions: <Widget>[
                         CupertinoButton(
                           child: Text("Submit"),
                           onPressed: (){
                            Navigator.of(context).pop();
                            Firestore.instance.collection("Suggestions").document(Timestamp.now().seconds.toString()).setData({"sug":sController.toString()});
                           },
                         ),
                          CupertinoButton(
                           child: Text("Cancel",style: TextStyle(color: Colors.red),),
                           onPressed: (){
                             Navigator.of(context).pop();
                           },
                         ),
                       ],
                     );
                   }
                 );
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
  );
    searchButton = IconButton(
    icon: Icon(Icons.search),
    splashColor: Colors.yellow,

    color: Colors.white,
    onPressed: (){
      if(teachers.isNotEmpty){
        print("TEACHERS ISNT EMPTY");
        if(!isSearching){
          
          isSearching = true;
           setState(() {
          title =Container(
            padding: EdgeInsets.symmetric(vertical:6),
            child:TextField(
            style: TextStyle(color: Colors.white),
            onChanged: (text){
              setState(() {
                List searchedteachers = [];
                for (var item in teachers) {
                  if(item.children[0].text.toString().toLowerCase().contains(text.toLowerCase()) || item.children[4].text.toString().toLowerCase().contains(text.toLowerCase())){
                    searchedteachers.add(item);
                  }
                  
                }
                body =teacherListView(searchedteachers);
              });
            },
            decoration: InputDecoration(
              labelText: "Teacher Name",
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: borderMaker(Colors.yellow),
              enabledBorder: borderMaker(Colors.white),
              border: borderMaker(Colors.lightBlue),
              
            ),
          )
          );
        });
        }else{
          isSearching = false;
          setState(() {
            title = titleText;

          });
        }
      }
      
    });
    
        return Scaffold(
        appBar: AppBar(
          backgroundColor:  Colors.indigoAccent[700],
          centerTitle: false,
          title: title,
          actions: <Widget>[infoButton,searchButton],
          
          ),
         body: body 
        );
        }

 OutlineInputBorder borderMaker(Color color) {
   return OutlineInputBorder(
              borderSide: BorderSide(color: color),
              borderRadius: BorderRadius.circular(10)
            );
 }

 ListView teacherListView(List teachersList) {
   return ListView.separated(
               
               separatorBuilder: (c,i){
                 return Container(height: 30,);
               },
               itemBuilder: (c,i){
                 dom.Element web =teachersList[i].children[0];

                 String name = teachersList[i].children[0].text.toString();
                 String ext = teachersList[i].children[1].text.toString();
                 String room = teachersList[i].children[2].text.toString();
                 
                //Department
                 
                 String department = "";
                 try {
                   department = teachersList[i].children[3].text.toString();
                 } catch (e) {
                   
                 }
                 if(department.isEmpty){
                   department = "";
                 }
                 if(department.length>30){
                   department = department.substring(0,30);
                 }
                 
                 String house = "";
                  try {
                    house = teachersList[i].children[4].text.toString();
                  } catch (e) {
                  }
                 String email = teachersList[i].children[5].text.toString();
                 String websiteString ="http://www.samohi.smmusd.org/Admin/staff.html";
                 
                 Widget website = Container(color:Colors.transparent);
                 if(name.contains("\n")){
                   name = name.split("\n")[0];
                   website =FloatingActionButton(
                     mini: true,
                     backgroundColor: Colors.indigoAccent[700],
                     child: Icon(mIcons.MdiIcons.link),
                     foregroundColor: Colors.white,
                     onPressed: (){
                       print("attempting to launch");
                      if(web.children.length==1){
                        print(web.children[0].outerHtml.split("\"")[1]);
                        websiteString = web.children[0].outerHtml.split("\"")[1];
                      }else{
                        print(web.children[1].outerHtml.split("\"")[1]);
                        websiteString = web.children[1].outerHtml.split("\"")[1];

                       }
                        launch(websiteString);
                     },
                   );

                 }
                 name = name;
                 try {
                   name = name.split(", ")[1]+" "+name.split(",")[0];
                 } catch (e) {
                 }
                 return Container(
                   //height: 300,
                   padding: EdgeInsets.symmetric(horizontal:20),
                   child: RaisedButton(
                     color: Colors.white,
                     elevation: 10,
                     padding: EdgeInsets.all(20),
                     onPressed: (){
 
                     },
                     child: Column(
                       children: <Widget>[
                         Row(children: <Widget>[
                          Text(name,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                          Expanded(child: Container(),),
                          Text(room,style: TextStyle(color: Colors.grey[700],fontSize: 16,),textAlign: TextAlign.center,),

                         ],),
                         Row(children: <Widget>[
                          Text(department,style: TextStyle(color: Colors.black,fontSize: 16,),textAlign: TextAlign.center,),
                          Expanded(child: Container(),),
                          Text(house,style: TextStyle(color: Colors.black,fontSize: 16,),textAlign: TextAlign.center,),

                         ],),
                         Row(children: <Widget>[
                           Text("Ext: "+ext,style: TextStyle(color: Colors.grey[700],fontSize: 17),textAlign: TextAlign.center,),

                         ],),
                         Row(children: <Widget>[
                          CupertinoButton(
                            padding: EdgeInsets.all(0),
                          onPressed: (){
                            s.Clipboard.setData(s.ClipboardData(text: email));
                            showCupertinoDialog(
                              context: context,
                              builder: (c){
                                return CupertinoAlertDialog(
                                  title:Text("Email copied to clipboard"),
                                  actions: <Widget>[
                                    CupertinoButton(
                                      child: Text("Ok"),
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );

                              }

                            );
                          },
                          child:
                            Text(email.trim(),style: TextStyle(color: Colors.blue,fontSize: 17),textAlign: TextAlign.center,),
                          ),
                          Expanded(child: Container(),),
                          website

                         ],),
                          
                       ],
                     ),
                   ),
                 );
                           },
               itemCount: teachersList.length,
             );
 }
}