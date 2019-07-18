import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart' as mIcons;
import 'package:http/http.dart' as http;
import 'color_loader_3.dart';
import 'package:webview_flutter/webview_flutter.dart' as web;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart'as dom;
//import 'package:flutter_map/flutter_map.dart';
import 'dart:io';
import 'dart:math';
//import 'package:latlong/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'story.dart';
import 'dart:convert';
//import 'package:twitter/twitter.dart';
import 'dart:ui' as ui;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:intl/intl.dart';
import 'dart:convert';
class MainWindow extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  _MainWindowState createState() => _MainWindowState();
}

class _MainWindowState extends State<MainWindow> with TickerProviderStateMixin {
  int _counter = 0;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var title = Text("Samohi Connect");
  TabController tabController;
TabController eventstabController;
   TextEditingController email =TextEditingController();
   TextEditingController password =TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     tabController = TabController(
            vsync: this,
            length: 4,
            initialIndex: 2

          );
          eventstabController =TabController(
            vsync: this,
            length: 2,
            initialIndex: 0
          );
          
    if(!tabController.hasListeners){
           tabController.addListener((){
             if(tabController.index==0){
               setState(() {
                 title = Text("Calender");
               });
             }else if(tabController.index==1){
               setState(() {
                 title =Text("Map");
               });
             }else if(tabController.index==2){
               setState(() {
                 title =Text("Samohi Connect");
               });
             }else if(tabController.index==3){
               setState(() {
                 title =Text("The Samohi News");
               });
             }else if(tabController.index==4){
               setState(() {
                 title =Text("The Samohi Twitter");
               });
             }
            });
          }
  }
  @override
  Widget build(BuildContext context) {
  
         
  var menuDrawer = Drawer(
    elevation: 20,
    child: ListView.custom(
      padding: EdgeInsets.zero,
      childrenDelegate: SliverChildListDelegate([
        DrawerHeader(
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.blueAccent[700]
          ),
          
          child: Image.asset("assets/logo.png"),
          padding: EdgeInsets.all(15),
        ),
        
          Container(height: 50,color: Colors.grey[200],child: Text("Important Links:"),alignment: Alignment.bottomLeft,padding: EdgeInsets.all(5),),

          ListTile(
          title: Text("Illuminate"),
          subtitle: Text("Gradebook"),
          trailing: Icon(CupertinoIcons.book,color: Colors.black,),
          onTap: (){
           // Navigator.of(context).pushNamed(illuminate.tag);
            launch("https://smmusd.illuminatehc.com/login",enableJavaScript: true);
          },
        ),
        ListTile(
          title: Text("Clever"),
          subtitle: Text("For College"),
          trailing: Icon(MdiIcons.brain,color: Colors.black,),
          onTap: (){
            launch("https://clever.com/oauth/authorize?response_type=code&state=7e61a70abe76142b7e225f5bf580dfe6675ccf7bbff8edc379aeea2b34c217b3&redirect_uri=https%3A%2F%2Fclever.com%2Fin%2Fauth_callback&client_id=4c63c1cf623dce82caac&confirmed=true&channel=clever&district_id=52e02e628b625cb10d006ce5",enableJavaScript: true);

          },
        ),
        ListTile(
          title: Text("Flex Time"),
          subtitle: Text("New Schedule"),
          trailing: Icon(MdiIcons.timelapse,color: Colors.black,),
          onTap: (){
            launch("http://www.samohi.smmusd.org/flextime-pilot.html",enableJavaScript: true);
          },
        ),
        Container(height: 50,color: Colors.grey[200],child: Text("Info Links:"),alignment: Alignment.bottomLeft,padding: EdgeInsets.all(5),),
          ListTile(
          title: Text("Schedule"),
          subtitle: Text("School Bell Schedule"),
          trailing: Icon(Icons.schedule,color: Colors.black,),
          onTap: (){
            launch("http://www.samohi.smmusd.org/Students/bells.html",enableJavaScript: true);

          },
        ),
        ListTile(
          title: Text("Attendance"),
          subtitle: Text("Policy"),
          trailing: Icon(CupertinoIcons.pencil,color: Colors.black,),
          onTap: (){
            launch("http://www.samohi.smmusd.org/Admin/attendance.html",enableJavaScript: true);

          },
        ),
        ListTile(
          title: Text("College Center"),
          subtitle: Text("Information"),
          trailing: Icon(MdiIcons.school,color: Colors.black,),
          onTap: (){
            launch("http://www.samohi.smmusd.org/CollegeCenter/index.html",enableJavaScript: true);

          },
        ),
        ListTile(
          title: Text("Daily Bulletin"),
          subtitle: Text("Todays Info"),
          trailing: Icon(MdiIcons.bulletinBoard,color: Colors.black,),
          onTap: (){
            launch("http://www.samohi.smmusd.org/BB.pdf",enableJavaScript: true);

          },
        ),
         ListTile(
          title: Text("Library"),
          subtitle: Text("Library Page"),
          trailing: Icon(Icons.library_books,color: Colors.black,),
          onTap: (){
            launch("http://www.samohi.smmusd.org/library/index.html",enableJavaScript: true);

          },
         ),
         ListTile(
          title: Text("Transcripts"),
          subtitle: Text("Grades"),
          trailing: Icon(MdiIcons.fileDocumentOutline,color: Colors.black,),
          onTap: (){
            launch("http://www.samohi.smmusd.org/Admin/transcripts.html",enableJavaScript: true);

          },
         ),
         ListTile(
          title: Text("Clubs"),
          subtitle: Text("Club Directory"),
          trailing: Icon(MdiIcons.cardsClub,color: Colors.black,),
          onTap: (){
            launch("http://www.samohi.smmusd.org/Students/clubs/index.html",enableJavaScript: true);

          },
         ),
         ListTile(
          title: Text("Staff Directory"),
          subtitle: Text("Find Teachers"),
          trailing: Icon(MdiIcons.teach,color: Colors.black,),
          onTap: (){
            launch("http://www.samohi.smmusd.org/Admin/staff.html",enableJavaScript: true);

          },
         ),
          Container(height: 50,color: Colors.grey[200],child: Text("Important Websites:"),alignment: Alignment.bottomLeft,padding: EdgeInsets.all(5),),
          ListTile(
          title: Text("SMMUSD"),
          subtitle: Text("www.smmusd.org/"),
          trailing: Icon(MdiIcons.pencilOutline,color: Colors.black,),
          onTap: (){
            launch("http://www.smmusd.org/",enableJavaScript: true);

          },
         ),
         ListTile(
          title: Text("Samohi"),
          subtitle: Text("Santa Monica High School"),
          trailing: Icon(MdiIcons.chairSchool,color: Colors.black,),
          onTap: (){
            launch("http://www.samohi.smmusd.org/",enableJavaScript: true);
          },
         ),
         Container(height: 50,color: Colors.grey[200],child: Text("Contact your house:"),alignment: Alignment.bottomLeft,padding: EdgeInsets.all(5),),
         ListTile(
          title: Text("S House"),
          trailing: Text("S",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,fontSize: 20),),
          onTap: (){
                launch("http://www.samohi.smmusd.org/houses/shouse.html",enableJavaScript: true);
            

          },
         ),
         ListTile(
          title: Text("M House"),
          trailing: Text("M",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,fontSize: 20),),
          onTap: (){
            launch("http://www.samohi.smmusd.org/houses/Mhouse.html",enableJavaScript: true);

          },

         ),
         ListTile(
          title: Text("H House"),
          trailing: Text("H",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,fontSize: 20),),
          onTap: (){
                launch("http://www.samohi.smmusd.org/houses/hhouse.html",enableJavaScript: true);

          },
         ),
         
         ListTile(
          title: Text("O House"),
          trailing: Text("O",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,fontSize: 20),),
          onTap: (){
            launch("http://www.samohi.smmusd.org/houses/ohouse.html",enableJavaScript: true);
          },
         ),
         ListTile(
          title: Text("I House"),
          subtitle: Text("The best house"),
          trailing: Text("I",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,fontSize: 20),),
          onTap: (){
                launch("http://www.samohi.smmusd.org/houses/Ihouse.html",enableJavaScript: true);
            
          },
         ),
         Container(height: 50,color: Colors.grey[200],child: Text("Developed by Benjamin Swerdlow, SwerdIsTheWord\u00a9"),alignment: Alignment.bottomLeft,padding: EdgeInsets.all(5),),

      ])
    ),
  );
  
    return Scaffold(
      key: scaffoldKey,
      drawer: menuDrawer,
      body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: title,
        leading: IconButton(
          icon: Icon(Icons.menu,color: Colors.white,),
          splashColor: Colors.yellow,
          onPressed: (){
            scaffoldKey.currentState.openDrawer();
          },
        ),
        backgroundColor: Colors.blueAccent[700],
      ),
      SliverFillRemaining(
        child: TabBarView(
          children: <Widget>[
            calender(),
            map(),
            eventView(),
            news(),
            //todo()
           // library()
           //socialMedia()
          ],
          controller: tabController,
          
        ),
      )
    ],
  ),
    bottomNavigationBar: TabBar(
      indicatorColor: Colors.blue[700],
      indicatorWeight: 2,
      
      controller: tabController,
      tabs: <Widget>[
        Tab(          
          icon: Icon(Icons.calendar_today,color: Colors.black,),
        ),
         Tab(          
          icon: Icon(Icons.map,color: Colors.black,),
        ),
        Tab(icon: Image.asset("assets/testingIcon.png"),),
        Tab(
          icon: Icon(mIcons.MdiIcons.newspaper,color: Colors.black,),
        ),
       //Tab(icon: Icon(mIcons.MdiIcons.calendarToday,color: Colors.black,),)
      ],
    ),
  );
  
}  Widget calender() {
    var calenderUrl = "https://calendar.google.com/calendar/embed?title=Santa%20Monica%20High%20School%20Calendar&mode=AGENDA&height=600&wkst=1&bgcolor=%23ffffff&src=smmk12.org_21bhbi3q00vuvdf2rak3rrrll8%40group.calendar.google.com&color=%23875509&src=8tn1onqvkup6g281q19s6oon3s%40group.calendar.google.com&color=%230F4B38&src=smmk12.org_tfdd6j1jr5hatfbcj87rro5k9c%40group.calendar.google.com&color=%23125A12&src=smmk12.org_7qnt6q53j7934lvcl0t754of9c%40group.calendar.google.com&color=%23711616&src=smmk12.org_4h8qa262239su4p66islu1e5vg%40group.calendar.google.com&color=%2323164E&src=smmk12.org_t60qs7u1uktrievfsk7gq5c73s%40group.calendar.google.com&color=%23182C57&src=smmk12.org_8umjrnuec40aa66o36lhd1huh8%40group.calendar.google.com&color=%23333333&src=smmk12.org_u8qc6umps8tqttms2sg3456jg8%40group.calendar.google.com&color=%236B3304&ctz=America%2FLos_Angeles";
    return Stack(
      children:[FutureBuilder(
      future: http.get(calenderUrl),
      builder: (context,webSnap){
        print(webSnap.connectionState);
        if(webSnap.hasError){
          String error = "Network failure";
          if(webSnap.error.runtimeType.toString()=="SocketException"){
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
        if(webSnap.connectionState!=ConnectionState.done){
          return Center(
            child: ColorLoader3(),
          );
        }else{
          http.Response p1 =webSnap.data;
          

          return web.WebView(
            initialUrl: calenderUrl,
            javascriptMode: web.JavascriptMode.unrestricted,
          );
        }
      },
    ),
    // pullup(),
    
    ],
    alignment: Alignment.bottomCenter,
    );
  }
Widget map() {
    //pk.eyJ1Ijoic3dlcmQiLCJhIjoiY2p3NGV3bzBnMWhnaDQ5cXZlMHgzZG5rNyJ9.d_agU8wGRZYZUHOmrrHBjQ
    //pk.eyJ1Ijoic3dlcmQiLCJhIjoiY2p3NGV3bzBnMWhnaDQ5cXZlMHgzZG5rNyJ9.d_agU8wGRZYZUHOmrrHBjQ
    var mapTabController = TabController(initialIndex: 0,vsync: this,length: 2);
    var imageURL = "http://www.samohi.smmusd.org/houses/images/campus.gif";

   //return 
   //       new FlutterMap(
   //   options: MapOptions(
   //     center:new LatLng(34.013183,-118.486464),
   //     
   //     zoom: 16.5
   //   ),
   //   layers: [
   //     new TileLayerOptions(
   //       urlTemplate: "https://api.mapbox.com/styles/v1/swerd/cjw4hcm3u1xkd1cnw1zswdrub/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic3dlcmQiLCJhIjoiY2p3NGV3bzBnMWhnaDQ5cXZlMHgzZG5rNyJ9.d_agU8wGRZYZUHOmrrHBjQ",
   //       additionalOptions: {
   //         'accessToken': 'pk.eyJ1Ijoic3dlcmQiLCJhIjoiY2p3NGV3bzBnMWhnaDQ5cXZlMHgzZG5rNyJ9.d_agU8wGRZYZUHOmrrHBjQ',
   //         'id':'swerd.cjw4gw80z0sk22urz5hs9e3z0-317l2'
   //       },
   //     )
   //     ],
   // );
  }

  Widget news() {
    //embed
          return Scaffold(
            //bottomNavigationBar: pullup(),
            body:FutureBuilder(
            future: http.get("https://www.thesamohi.com/category/news"),
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
              RaisedButton(child: Text("Try Again"),color: Colors.blue,onPressed: (){
                return news();
              },)
            ],
          );
        }else
              if(s.connectionState!=ConnectionState.done){
                return Center(child:ColorLoader3());
              }else{
                print("OK part 1");
                print(s.data);
                http.Response p1 = s.data;
                print("OK PART 2");
                print(p1.body);
                var document = parse(p1.body);
                var priceElement = document.getElementById("omc-main").children;
                
                print("OK PART 3");
                print(priceElement);
                priceElement.removeAt(priceElement.length-1);

                priceElement.removeAt(0);

                return ListView.separated(
                  itemCount: priceElement.length,
                  separatorBuilder: (c,i){
                    return Container(height: 0,);
                  },
                  itemBuilder: (c,i){
                    print("New Post");
                    print(priceElement[i].localName);
                    print("HTML");
                    print(priceElement[i].innerHtml);
                    var document2 = parse(priceElement[i].innerHtml);
                    var imageHope = document2.getElementsByClassName("omc-image-blog-one wp-post-image");
                    var headingHope =document2.getElementsByClassName("omc-blog-one-heading");
                    print("WITHIN");
                    dynamic imagedoc;
                    dynamic headingdoc;
                    print(headingHope.first);
                    for (var item in imageHope) {

                      imagedoc =item.outerHtml;


                    }
                    for (var item in headingHope) {

                      headingdoc =item.outerHtml;


                    }

                    print("INSIDE");
                    print(imagedoc.runtimeType);
                    String headerString =headingdoc.toString();
                    String imageString = imagedoc.toString();
                    print("HEADER STRING");
                    print(headerString);
                    List imageSplit =imageString.split("""\"""");    
                    List headerSplit =headerString.split(">");     
                    print("HEADER SPLIT");               
                    print(headerSplit[1].toString().split("\"")[1]);
                    String theHeader = headerSplit[2].toString().split("<")[0];
                    String link = headerSplit[1].toString().split("\"")[1];
                    //print(imageSplit[1]);
                    //return Container(color: Colors.indigo,height: 10,);
                    return FutureBuilder(
                      future: http.get(imageSplit[1]),
                      builder: (c,s){
                        if(s.hasError){
                          return Text("Failed to load post");
                        }else if(s.connectionState!=ConnectionState.done){
                          var loadingSlide = RaisedButton(
                              color: Colors.grey[150],
                              elevation: 10,
                              onPressed: (){

                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                        'Loading',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight:
                                            FontWeight.bold,
                                        ),
                                      ),
                                    
                                  
                                  ],
                              ),
                            );
                          return Container(
                            height: 200,
                            padding: EdgeInsets.all(25),
                            child:loadingSlide
                          
                          );
                        }else{
                          return Container(
                            height: 200,
                            padding: EdgeInsets.symmetric(horizontal:25,vertical: 10),

                            child: Hero(
                              tag: headerString,
                              child:RaisedButton(
                              elevation: 15,
                              onPressed: (){
                               print("FISSH ITS IN HERE");
                               print(link);
                               print("HEADER BEFORE PUSH:");
                               print(theHeader);
                              Navigator.push(
                                context,
                                  MaterialPageRoute(builder: (context) => Story(header: theHeader,link: link,)),
                                );                              
                              },
                              color: Colors.grey[150],
                              child:Row(
                              children: <Widget>[
                               Container(child:Image.memory(s.data.bodyBytes,fit: BoxFit.fill,),padding: EdgeInsets.all(10),width: 150,height: 175,),
                                 
                               Expanded(child:Text(theHeader,maxLines: 3,style: TextStyle(color: Colors.black,fontSize: 20),textAlign: TextAlign.center,)),
                                 
                              
                              ],)),
                          )
                          );
                          
                        }
                      },
                  );
                  },
                );
              }
            },
          ));
          return Container(color: Colors.green,);
     
    //<a class="twitter-timeline" href="https://twitter.com/SMMUSD?ref_src=twsrc%5Etfw">Tweets by SMMUSD</a> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
  }

  eventView() {
    return Scaffold(
      appBar: TabBar(
        controller: eventstabController,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black87,

        tabs: <Widget>[
          Tab(text: "Events",),
          Tab(text: "Polls",),
        ],
      ),
      body: TabBarView(
        children: <Widget>[
          FutureBuilder(
            future:Firestore.instance.collection("events").getDocuments(),
            builder: (c,s){
              if(s.hasError){
                return Column(children: <Widget>[
                  Image.asset("assets/testingIcon.png"),
                  Text("Handshake Failure")

                ],mainAxisAlignment: MainAxisAlignment.center,);
              }
              if(s.connectionState!=ConnectionState.done){
                return ColorLoader3();
              }else{
                QuerySnapshot snapshot = s.data;
                List documents = snapshot.documents;
                if(documents.length!=0){
                  return ListView.separated(
                    itemCount: documents.length,
                    separatorBuilder: (c,i){
                      return Container(height: 30,);
                    },
                    itemBuilder: (c,i){
                      DocumentSnapshot document =  documents[i];
                      Timestamp time = document["day"];
                      print("TIMEEE");
                      print(time);
                      String date = "FISH";
                      //String date = new DateFormat.yMMMMd("en_US").format( DateTime.parse(time.toDate().toString()));

                      print(date);
                      if(document["type"]=="withImage"){
                      return Container(
                        height: 350,
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            FutureBuilder(
                              future:FirebaseStorage.instance.ref().child("eventImages").child(document["image"]).getData(9000000),
                              builder: (c,s){
                                if(s.connectionState!=ConnectionState.done){
                                  return ColorLoader3();
                                }else{
                                  
                                  return Container(
                                    child:Image.memory(s.data,fit: BoxFit.fitWidth,),
                                    height: 350,
                                    width: MediaQuery.of(c).size.width,
                                    );
                                    
                                }
                              },
                              ),
                              Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width-40,
                                padding: EdgeInsets.all(5),
                                child: RaisedButton(
                                  elevation: 10,
                                  color: Colors.white,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 5,),
                                      Text(document.documentID,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 21),),
                                      SizedBox(height: 5,),
                                      Text(document["description"],textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15),),
                                      Text(date,textAlign: TextAlign.center,)
                                    ],
                                  ),
                                  onPressed: (){

                                  },),
                                )
                          ],
                        ),
                        );
                      }
                    },
                  );
                }else{
                  return Column(children: <Widget>[
                  Image.asset("assets/testingIcon.png",width: 100,),
                  Text("No events right now")

                ],mainAxisAlignment: MainAxisAlignment.center,);
                }
              }
            },
          ),
          FutureBuilder(
            future: Firestore.instance.collection("polls").getDocuments(),
            builder: (c,s){
              if(s.connectionState!=ConnectionState.done){
                return ColorLoader3();
              }else{
                QuerySnapshot data = s.data;
                List documents = data.documents;
                FirebaseAuth.instance.signInAnonymously();
                return ListView.separated(
                  itemCount: documents.length,
                  separatorBuilder: (c,i){
                    return Container(height: 40,);
                  },
                  itemBuilder: (c,i){
                    DocumentSnapshot document =documents[i];
                    return Container(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(document.documentID),
                            subtitle: Text(document["askedby"]),
                          ),
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: <Widget>[
                          FutureBuilder(
                            future: FirebaseStorage.instance.ref().child("pollsImages").child(document["image"]).getData(9000000),
                            builder: (c,s){
                              if(s.connectionState!=ConnectionState.done){
                                return ColorLoader3();
                              }else{
                                return Image.memory(s.data,fit: BoxFit.fitWidth,height: 350,width: MediaQuery.of(c).size.width,);
                              }
                            },
                          ),
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width-40,
                            child: RaisedButton(
                              child:Text(document["description"],textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 18),),
                              color: Colors.white,
                              onPressed: (){},
                              elevation: 10,
                              ),
                          ),
                          ]
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            IconButton(
                              splashColor: Colors.green,
                              onPressed: (){
                            showDialog(context: c,builder: (c){
                                  return CupertinoAlertDialog(
                                    title: Text("Thank you for your feedback"),
                                    content: FutureBuilder(
                                      future:Firestore.instance.collection("polls").document(document.documentID).get(),
                                      builder: (c,s){
                                        if(s.connectionState!=ConnectionState.done){
                                          return ColorLoader3();
                                        }else{

                                          if(s.data["yes"]!=null){
                                            int amount = s.data["yes"];
                                            var amountMap = new Map<String,int>();
                                            amountMap["yes"]=amount+1;
                                            Firestore.instance.collection("polls").document(document.documentID).updateData(amountMap);

                                          }else{
                                            var amount = new Map<String,int>();
                                            amount["yes"]=1;
                                            Firestore.instance.collection("polls").document(document.documentID).updateData(amount);
                                          }
                                          return RaisedButton(child: Text("Thank you"),onPressed: (){
                                            Navigator.of(context).pop();
                                          },);
                                        }
                                      },
                                    ),
                                  );
                                });

                              },
                              icon: Icon(Icons.thumb_up,color: Colors.black,),
                            ),
                            SizedBox(width: 30),
                            IconButton(
                              splashColor: Colors.red,
                              onPressed: (){
                                showDialog(context: c,builder: (c){
                                  return CupertinoAlertDialog(
                                    title: Text("Thank you for your feedback"),
                                    content: FutureBuilder(
                                      future:Firestore.instance.collection("polls").document(document.documentID).get(),
                                      builder: (c,s){
                                        if(s.connectionState!=ConnectionState.done){
                                          return ColorLoader3();
                                        }else{

                                          if(s.data["no"]!=null){
                                            int amount = s.data["no"];
                                            var amountMap = new Map<String,int>();
                                            amountMap["no"]=amount+1;
                                            Firestore.instance.collection("polls").document(document.documentID).updateData(amountMap);

                                          }else{
                                            var amount = new Map<String,int>();
                                            amount["no"]=1;
                                            Firestore.instance.collection("polls").document(document.documentID).updateData(amount);
                                          }
                                          return RaisedButton(child: Text("Thank you"),onPressed: (){
                                            Navigator.of(context).pop();
                                          },);
                                        }
                                      },
                                    ),
                                  );
                                });
                              },
                              icon: Icon(Icons.thumb_down,color: Colors.black,),
                            ),

                          ],)

                        ],
                      ),
                      );
                  },
                );
              }
            },
          )
        ],
        controller: eventstabController,
      )
    );
  }

  library() {
    var title = Text("Library Catalog",style: TextStyle(color: Colors.blue));

    SliverAppBar appbar = SliverAppBar(
          title: title,
          backgroundColor: Colors.red,
          );

    var headers = new Map<String,String>();
    headers["Upgrade-Insecure-Requests"] = "1";
    headers["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36";
    headers["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3";

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          primary: false,
          backgroundColor: Colors.white,
          elevation: 10,
          forceElevated: true,
          floating: true,
          leading: Container(width: 0),
          title: Text("Library Catalog",style: TextStyle(color: Colors.black)),
          //bottom: PreferredSize(
          //  preferredSize: Size(MediaQuery.of(context).size.width,50),
          //  child: Container(
          //    padding: EdgeInsets.symmetric(vertical:10,horizontal: 30),
          //    child: TextField(
          //      decoration: InputDecoration(
          //        labelText: "Book Title",
          //        icon: Icon(Icons.search),
          //        border: OutlineInputBorder(
          //          borderRadius: BorderRadius.circular(10)
          //        ),
                  
                  
          //      ),
          //      autofocus: false,
          //      controller: bookController,
          //      ),
                
          //    ),
          //),
            
          
        ),
        //https://smmusd.follettdestiny.com/cataloging/servlet/handlebasicsearchform.do?restoreFromCrumb=1&formSignature=saveData&formName=cataloging_servlet_BasicSearchForm&breadCrumbIndex=76030&printerFriendly=true
        //https://smmusd.follettdestiny.com/cataloging/servlet/handlebasicsearchform.do?restoreFromCrumb=1&formSignature=saveData&formName=cataloging_servlet_BasicSearchForm&breadCrumbIndex=76118&printerFriendly=true
        //https://smmusd.follettdestiny.com/cataloging/servlet/handlebasicsearchform.do?doTop10=true
        SliverFillRemaining(
          child:FutureBuilder(
            future: Firestore.instance.collection("library").getDocuments(),
            builder: (c,s){
              if(s.hasError){
                print(s.error);
                return Container(color: Colors.red,);
              }
              if(s.connectionState!=ConnectionState.done){
                return ColorLoader3();
              }
              
              print("data");
              //print(s.data.body);
              QuerySnapshot q = s.data;
              return Container(color: Colors.indigo,);

            },
          )
        )

      ],
    );
  }

}

class copied extends StatelessWidget {
  const copied({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("Your house principal's email has been copied to your clipboard"),
      actions: <Widget>[CupertinoButton(child: Text("OK"),onPressed: (){Navigator.of(context).pop();},)],
    );
  }
}
