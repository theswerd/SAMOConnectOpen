

import 'package:flutter/material.dart';
import 'color_loader_3.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart' as mIcons;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';
import 'constants.dart';
class Clubs extends StatefulWidget {
  static String tag = "clubs";
  @override
  _ClubsState createState() => new _ClubsState();
}

class _ClubsState extends State<Clubs> with TickerProviderStateMixin{
  Widget titleText =Text("Clubs");
  bool isSearching = false;
  Widget title =Text("Clubs");
  List<dom.Element> clubs = [];
  IconButton shareButton = IconButton(
    icon: Icon(Icons.share),
    splashColor: Colors.yellowAccent,
    onPressed: (){
      Share.share("Not sure which clubs you want to join? Check them out on SAMO Connect -- https://samoconnect.page.link/SamoConnect");
    },
  );
  Widget searchButton = FloatingActionButton(
    child: Icon(Icons.search),
    onPressed: (){

    },
  );
  Widget body = Container(color: Colors.white,);
  AnimationController searchAnimationController;
  @override
  initState() {

    super.initState();
    searchAnimationController = new AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    setState(() {
      body = FutureBuilder(
           future:http.get("http://www.samohi.smmusd.org/Students/clubs/index.html"),
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
               clubs = doc.body.children[0].children[0].children[0].children[4].children[0].children[0].children[0].children[2].children[0].children[0].children[0].children;
               clubs.removeAt(0); 
               return clubListView(clubs);
             }
           },
         );

    });
  }
 @override
 Widget build(BuildContext context) {
   Widget infoButton =IconButton(
    icon: Icon(mIcons.MdiIcons.informationOutline),
    splashColor: Colors.yellow,
    onPressed: (){
      Constants.showInfoBottomSheet(
        [
              CupertinoActionSheetAction(
                child: Text("Club Charter"),
                onPressed: (){
                  launch("http://www.samohi.smmusd.org/Students/clubs/ClubCharterFall19-20.pdf");
                },
              ),
              Constants.officialWebsiteAction(context, "http://www.samohi.smmusd.org/Students/clubs/index.html"),
             
              Constants.ratingAction(context),
              CupertinoActionSheetAction(
                child: Text("Extra Info"),
                onPressed: ()=>showCupertinoModalPopup(
                  context: context,
                  builder: (c)=>CupertinoAlertDialog(
                    title: Text("Extra Info"),
                    content: Text("This is a list of all the clubs at SAMOHI, pulled live from the SAMOHI Website"),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: Text("Ok"),
                        onPressed: ()=>Navigator.of(context).pop(),
                      )
                    ],
                  )
                )
              )
              
            ],
            context
      );
    }

  );
    searchButton = FloatingActionButton(
    child: AnimatedIcon(icon: AnimatedIcons.search_ellipsis, progress: searchAnimationController),
    splashColor: Colors.yellow,

    foregroundColor: Colors.white,
    onPressed: (){
      if(clubs.isNotEmpty){
        if(!isSearching){
          searchAnimationController.forward();
          isSearching = true;
           setState(() {
          title =Container(
            padding: EdgeInsets.symmetric(vertical:6),
            child:TextField(
              style: TextStyle(color: Colors.white),
            onChanged: (text){
              setState(() {
                List searchedClubs = [];
                for (var item in clubs) {
                  if(item.children[0].text.toString().toLowerCase().contains(text.toLowerCase()) || item.children[4].text.toString().toLowerCase().contains(text.toLowerCase())){
                    searchedClubs.add(item);
                  }
                  
                }
                body =clubListView(searchedClubs);
              });
            },
            decoration: InputDecoration(
              labelText: "Club Name",
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: borderMaker(Colors.yellow),
              enabledBorder: borderMaker(Colors.white),
              border: borderMaker(Colors.lightBlue)
            ),
          )
          );
        });
        }else{
          searchAnimationController.reverse();
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
          title: AnimatedSwitcher(child:title, duration: Duration(milliseconds: 500),transitionBuilder: (w,a)=>ScaleTransition(child: w, scale: a,alignment: Alignment.centerLeft,)),
          actions: <Widget>[shareButton,infoButton],
          
          ),
          floatingActionButton: searchButton,
         body: body 
        );
        }

 OutlineInputBorder borderMaker(Color color) {
   return OutlineInputBorder(
              borderSide: BorderSide(color: color),
              borderRadius: BorderRadius.circular(10)
            );
 }

 ListView clubListView(List clubs) {
   return ListView.separated(
               
               separatorBuilder: (c,i){
                 return Container(height: 30,);
               },
               itemBuilder: (c,i){
                 String name = clubs[i].children[0].text.toString();
                 String room = clubs[i].children[1].text.toString();
                 String day = clubs[i].children[2].text.toString();
                 String advisor = clubs[i].children[3].text.toString();
                 String mission = clubs[i].children[4].text.toString();
                 if(day.toLowerCase()  == "M Lunch".toLowerCase()){
                   day = "Monday";
                 }else if(day.toLowerCase() == "T Lunch".toLowerCase()){
                    day = "Tuesday";
                 }else if(day.toLowerCase() == "W Lunch".toLowerCase()){
                    day = "Wednesday";
                 }else if(day.toLowerCase() == "Th Lunch".toLowerCase()){
                    day = "Thursday";
                 }else if(day.toLowerCase() == "F Lunch".toLowerCase()){
                    day = "Friday";
                 }else if(day.toLowerCase() == "T, F lunch".toLowerCase()){
                    day = "Tuesday and Friday";
                 }else if(day.toLowerCase() == "T Lunch/After School".toLowerCase()){
                    day = "Tuesday and After School";
                 }
                 if(name.length>29){
                   name = name.substring(0,29)+"...";
                   
                   
                 }
                 return Container(
                   //height: 300,
                   padding: EdgeInsets.symmetric(horizontal:20),
                   child: RaisedButton(
                     splashColor: Colors.redAccent[400],
                     color: Colors.white,
                     elevation: 10,
                     padding: EdgeInsets.all(15),
                     onPressed: (){
 
                     },
                     child: Column(
                       children: <Widget>[
                         Row(children: <Widget>[
                           Text(name,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                           Expanded(child: Container(),),
                           Text(room,style: TextStyle(color: Colors.grey[700],fontSize: 15),textAlign: TextAlign.center,),
                         ],),
                         Container(height: 5,),
                         Row(children: <Widget>[
                           Text(advisor,style: TextStyle(color: Colors.grey[700],fontSize: 16),textAlign: TextAlign.center,),
                           Expanded(child: Container(),),
 
                           Text(day,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                         ]),
                         Container(height: 5,),
 
                         Text(mission,style: TextStyle(color: Colors.black,fontSize: 17),textAlign: TextAlign.center,),
 
                       ],
                     ),
                   ),
                 );
               },
               itemCount: clubs.length,
             );
 }
}