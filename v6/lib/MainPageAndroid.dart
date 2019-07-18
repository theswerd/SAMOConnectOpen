import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart' as mIcons;
import 'package:http/http.dart' as http;
import 'color_loader_3.dart';
import 'package:webview_flutter/webview_flutter.dart' as web;
//import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:html/parser.dart' show parse;
import 'story.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
//import 'dart:io';
//import 'dart:math';
import 'package:url_launcher/url_launcher.dart';
//import 'story.dart';
//import 'dart:convert';
import 'package:flutter_signin_button/flutter_signin_button.dart';
//import 'package:twitter/twitter.dart';
//import 'dart:ui' as ui;
//import 'package:groovin_widgets/modal_drawer_handle.dart';
import 'calender.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:intl/intl.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:launch_review/launch_review.dart';
import 'bellSchedule.dart';
import 'collegeCenter.dart';
import 'teachers.dart';
import 'houses.dart';
import 'housesV2.dart';
import 'clubs.dart';
import 'attendance.dart';
import 'policies.dart';
import 'login_screen_3.dart';

class MainWindowAndroid extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  static String tag = "MainWindowAndroid";

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  _MainWindowAndroidState createState() => _MainWindowAndroidState();
}

class _MainWindowAndroidState extends State<MainWindowAndroid> with TickerProviderStateMixin {
   GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

   IconButton infoAction =IconButton(
     icon: Icon(Icons.info_outline),
     splashColor: Colors.yellow,
     onPressed: (){},
   );

   TabController tabController;
   TabController eventstabController;
  Widget titleWidget = Text("SAMOHI Connect");
  var calenderUrl = "https://calendar.google.com/calendar/embed?title=Santa%20Monica%20High%20School%20Calendar&mode=AGENDA&height=600&wkst=1&bgcolor=%23ffffff&src=smmk12.org_21bhbi3q00vuvdf2rak3rrrll8%40group.calendar.google.com&color=%23875509&src=8tn1onqvkup6g281q19s6oon3s%40group.calendar.google.com&color=%230F4B38&src=smmk12.org_tfdd6j1jr5hatfbcj87rro5k9c%40group.calendar.google.com&color=%23125A12&src=smmk12.org_7qnt6q53j7934lvcl0t754of9c%40group.calendar.google.com&color=%23711616&src=smmk12.org_4h8qa262239su4p66islu1e5vg%40group.calendar.google.com&color=%2323164E&src=smmk12.org_t60qs7u1uktrievfsk7gq5c73s%40group.calendar.google.com&color=%23182C57&src=smmk12.org_8umjrnuec40aa66o36lhd1huh8%40group.calendar.google.com&color=%23333333&src=smmk12.org_u8qc6umps8tqttms2sg3456jg8%40group.calendar.google.com&color=%236B3304&ctz=America%2FLos_Angeles";


  dynamic physics = ScrollPhysics();

  @override
  void initState() {
Firestore.instance.collection("update").document("update").get().then(
      (currentUpdate){
        if(currentUpdate.data["update"]>3.14){
          showCupertinoDialog(
            context: context,
            builder: (c){
              return CupertinoAlertDialog(
                title: Text("A new update is out"),
                actions: <Widget>[
                  CupertinoButton(
                    child: Text("Get it!"),
                    onPressed: (){
                      launch("https://samoconnect.page.link/SamoConnect");
                    },
                  )
                ],
              );
            }
          );
        }
      });


    setState(() {
      infoAction =IconButton(
        icon: Icon(Icons.info_outline),
        splashColor: Colors.yellow,
        onPressed: (){
          if(tabController.index==0){
            showModalBottomSheet(
              context: context,
              builder: (c){
                return CupertinoActionSheet(
                  title: Text("Extra Info"),
                  actions: <Widget>[
                    CupertinoActionSheetAction(
                      child: Text("Official Website"),
                      onPressed: (){
                        Navigator.of(context).pop();
                        launch("https://calendar.google.com/calendar/embed?title=SAMO%20CONNECT&mode=AGENDA&src=smmk12.org_21bhbi3q00vuvdf2rak3rrrll8@group.calendar.google.com&src=8tn1onqvkup6g281q19s6oon3s@group.calendar.google.com&src=smmk12.org_tfdd6j1jr5hatfbcj87rro5k9c@group.calendar.google.com&src=smmk12.org_7qnt6q53j7934lvcl0t754of9c@group.calendar.google.com&src=smmk12.org_4h8qa262239su4p66islu1e5vg@group.calendar.google.com&src=smmk12.org_t60qs7u1uktrievfsk7gq5c73s@group.calendar.google.com&src=smmk12.org_8umjrnuec40aa66o36lhd1huh8@group.calendar.google.com&src=smmk12.org_u8qc6umps8tqttms2sg3456jg8@group.calendar.google.com&dates=20190701/20190801");
                      },
                    )
                  ],
                );
              }
            );
          }else
          if(tabController.index==1){
            showModalBottomSheet(
              context: context,
              builder: (c){
                return CupertinoActionSheet(
                  title: Text("Extra Info"),
                  actions: <Widget>[
                    CupertinoActionSheetAction(
                      child: Text("View Official School Map"),
                      onPressed: (){
                        Navigator.of(context).pop();
                        launch("http://www.samohi.smmusd.org/houses/images/campus.gif");
                        //vigator.of(context).popAndPushNamed(OfficialMap.tag);
                        
                        //launch("https://api.mapbox.com/styles/v1/swerd/cjw4hcm3u1xkd1cnw1zswdrub.html?fresh=true&title=true&access_token=pk.eyJ1Ijoic3dlcmQiLCJhIjoiY2p3NGV3bzBnMWhnaDQ5cXZlMHgzZG5rNyJ9.d_agU8wGRZYZUHOmrrHBjQ#16.1/34.011844/-118.486192/0");
                      },
                    ),

                    CupertinoActionSheetAction(
                      child: Text("View Old Version"),
                      onPressed: (){
                        Navigator.of(context).pop();

                        launch("https://api.mapbox.com/styles/v1/swerd/cjw4hcm3u1xkd1cnw1zswdrub.html?fresh=true&title=true&access_token=pk.eyJ1Ijoic3dlcmQiLCJhIjoiY2p3NGV3bzBnMWhnaDQ5cXZlMHgzZG5rNyJ9.d_agU8wGRZYZUHOmrrHBjQ#16.1/34.011844/-118.486192/0");
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: Text("Give Us A Good Rating?"),
                      onPressed: (){
                        Navigator.of(context).pop();
                        LaunchReview.launch(
                          iOSAppId: "1465501734",
                          androidAppId: "com.swerd.SamoConnect"
                        );
                        //launch("https://api.mapbox.com/styles/v1/swerd/cjw4hcm3u1xkd1cnw1zswdrub.html?fresh=true&title=true&access_token=pk.eyJ1Ijoic3dlcmQiLCJhIjoiY2p3NGV3bzBnMWhnaDQ5cXZlMHgzZG5rNyJ9.d_agU8wGRZYZUHOmrrHBjQ#16.1/34.011844/-118.486192/0");
                      },
                    )
                  ],
                );
              }
            );
          }else if(tabController.index==2){
            showModalBottomSheet(
              context: context,
              builder: (c){
                return CupertinoActionSheet(
                  title: Text("Extra Info"),
                  actions: <Widget>[
                    CupertinoActionSheetAction(
                      child: Text("Extra Info"),
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (c){
                            return AlertDialog(
                              title: Text("A view for upcoming ASB events"),
                              content: Text("This view is not official yet, though with your support, it may be in a few months"),
                              actions: <Widget>[
                                CupertinoButton(
                                  child: Text("Ok"),
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                ),
                                CupertinoButton(
                                  child: Text("Give us a good rating?"),
                                  onPressed: (){
                                    LaunchReview.launch(
                                      iOSAppId: "1465501734",
                                      androidAppId: "com.swerd.SamoConnect"
                                    );
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();

                                  },
                                )
                              ],
                            );
                          }
                        );
                      },
                    )
                  ],
                );
              }
            );
   
          }else if(tabController.index==3){
            showModalBottomSheet(
              context: context,
              builder: (c){
                return CupertinoActionSheet(
                  title: Text("Extra Info"),
                  actions: <Widget>[
                    CupertinoActionSheetAction(
                      child: Text("Official Website"),
                      onPressed: (){
                        launch("https://www.thesamohi.com/");
                        
                      },
                    )
                  ],
                );
              }
            );
   
          }
        },
      );
    });
   
    // TODO: implement initState
    super.initState();
    eventstabController =TabController(
          vsync: this,
            length: 2,
            initialIndex: 0
    );

    tabController =TabController(
      length: 4,
      vsync: this,
      initialIndex: 2
    );
    
     
     
   if(!tabController.hasListeners){
           tabController.addListener((){
             if(tabController.index==0){
               setState(() {
                 physics =ScrollPhysics();

                 //NeverScrollableScrollPhysics
                 titleWidget = Text("Calendar");
               });
             }else if(tabController.index==1){
               setState(() {
                 titleWidget =Text("Map");
                 physics =  physics;

               });
               print("CHECKING PERMISSION");
               

             }else if(tabController.index==2){
               setState(() {
                  physics =NeverScrollableScrollPhysics();

                 titleWidget =Text("SAMOHI Connect");
               });
             }else if(tabController.index==3){
               setState(() {
                  physics =ScrollPhysics();

                 titleWidget =Text("The Samohi News");
               });
             }else if(tabController.index==4){
               setState(() {
                 titleWidget =Text("The Samohi Twitter");
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
          
          child:  Column(
            children: <Widget>[
              Image.asset("assets/logo.png",fit: BoxFit.fitWidth,width: 100,),
              FutureBuilder(
                future:FirebaseAuth.instance.currentUser(),
                builder: (c,s){
                  if(s.hasError){
                    return Text("Network Failure");
                  }
                  if(s.connectionState!=ConnectionState.done){

                    return Container(height: 0,);
                  }else{
                    FirebaseUser theUser = s.data;
                    
                    print("CIRRENT USERRR BOISSS");
                    print(theUser);
                      if(theUser==null){
                        
                        return SignInButton(Buttons.GoogleDark,onPressed: (){
                          Navigator.of(context).popAndPushNamed(LoginScreen3.tag);
                        },);
                      }else{

                        print("Display name:::");
                        FirebaseUserMetadata m = theUser.metadata;
                        print(m.creationTimestamp);
                        return RaisedButton(
                          child: Text("Sign Out",style: TextStyle(color: Colors.white),),
                          color: Colors.indigoAccent[700],
                          onPressed: (){
                            print("Sign OOOt");
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).popAndPushNamed(MainWindowAndroid.tag);
                          },
                        );
                      }
                  }
                },
              )
              
              ],),
          padding: EdgeInsets.all(5),
        ),
        
          Container(height: 50,color: Colors.grey[200],child: Text("Important Links:"),alignment: Alignment.bottomLeft,padding: EdgeInsets.all(5),),

          ListTile(
          title: Text("Illuminate"),
          subtitle: Text("Gradebook"),
          trailing: Icon(CupertinoIcons.book,color: Colors.black,),
          onTap: (){
            //Navigator.of(context).pushNamed(Illuminate.tag);
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
           // launch("http://www.samohi.smmusd.org/Students/bells.html",enableJavaScript: true);
            Navigator.of(context).popAndPushNamed(BellSchedule.tag);
          },
        ),
        ListTile(
          title: Text("Attendance"),
          subtitle: Text("Policy"),
          trailing: Icon(CupertinoIcons.pencil,color: Colors.black,),
          onTap: (){
            //launch("http://www.samohi.smmusd.org/Admin/attendance.html",enableJavaScript: true);
            Navigator.of(context).popAndPushNamed(Attendance.tag);
          },
        ),
        ListTile(
          title: Text("College Center"),
          subtitle: Text("Information"),
          trailing: Icon(MdiIcons.school,color: Colors.black,),
          onTap: (){
            //launch("http://www.samohi.smmusd.org/CollegeCenter/index.html",enableJavaScript: true);
            Navigator.of(context).popAndPushNamed(CollegeCenter.tag);
          },
        ),
        ListTile(
          title: Text("Daily Bulletin"),
          subtitle: Text("Todays Info"),
          trailing: Icon(MdiIcons.bulletinBoard,color: Colors.black,),
          onTap: (){
            launch("http://www.samohi.smmusd.org/BB.pdf",enableJavaScript: true);
            //Navigator.of(context).pushNamed(bulletin.tag);
          },
        ),
         ListTile(
          title: Text("Library"),
          subtitle: Text("Library Page"),
          trailing: Icon(Icons.library_books,color: Colors.black,),
          onTap: (){
            launch("http://www.samohi.smmusd.org/library/index.html",enableJavaScript: true);
            //Navigator.of(context).pushNamed(LibraryPage.tag);
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
          title: Text("Policies"),
          subtitle: Text("SAMOHI Policies"),
          trailing: Icon(MdiIcons.ruler,color: Colors.black,),
          onTap: (){
            Navigator.of(context).pushNamed(PolicyPage.tag);
          },
        ),
         ListTile(
          title: Text("Clubs"),
          subtitle: Text("Club Directory"),
          trailing: Icon(MdiIcons.cardsClub,color: Colors.black,),
          onTap: (){
            //launch("http://www.samohi.smmusd.org/Students/clubs/index.html",enableJavaScript: true);
            Navigator.of(context).popAndPushNamed(Clubs.tag);
          },
         ),
         ListTile(
          title: Text("Staff Directory"),
          subtitle: Text("Find Teachers"),
          trailing: Icon(MdiIcons.teach,color: Colors.black,),
          onTap: (){
            //launch("http://www.samohi.smmusd.org/Admin/staff.html",enableJavaScript: true);
            Navigator.of(context).pushNamed(Teachers.tag);
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
            
               // launch("http://www.samohi.smmusd.org/houses/shouse.html",enableJavaScript: true);
               houseRoute(context,"S");


          },
         ),
         ListTile(
          title: Text("M House"),
          trailing: Text("M",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,fontSize: 20),),
          onTap: (){
            //launch("http://www.samohi.smmusd.org/houses/Mhouse.html",enableJavaScript: true);
            houseRoute(context,"M");

          },

         ),
          ListTile(
          title: Text("O House"),
          trailing: Text("O",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,fontSize: 20),),
          onTap: (){
            houseRoute(context,"O");

            //launch("http://www.samohi.smmusd.org/houses/ohouse.html",enableJavaScript: true);
          },
         ),
         ListTile(
          title: Text("H House"),
          trailing: Text("H",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,fontSize: 20),),
          onTap: (){
                //launch("http://www.samohi.smmusd.org/houses/hhouse.html",enableJavaScript: true);
            houseRoute(context,"H");

          },
         ),
         
        
         ListTile(
          title: Text("I House"),
          //subtitle: Text("The best house"),
          trailing: Text("I",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,fontSize: 20),),
          onTap: (){
            houseRoute(context,"I");
            //houseView(house)
                //launch("http://www.samohi.smmusd.org/houses/Ihouse.html",enableJavaScript: true);
            
          },
         ),
         Container(height: 50,color: Colors.grey[200],child: Text("Developed by Benjamin Swerdlow, SwerdIsTheWord\u00a9"),alignment: Alignment.bottomLeft,padding: EdgeInsets.all(5),),
         ListTile(
           trailing: Icon(MdiIcons.account,color: Colors.black,),
           title: Text("Why Sign In?"),
           subtitle: Text("Benifits"),
           onTap: (){
             showCupertinoModalPopup(
               context: context,
               builder: (c){
                 return CupertinoAlertDialog(
                   title: Text("Why sign in?"),
                   content: Text("While we don't store any data about you (In accordance with federal FERPA laws), signing in allows us to authenticate your database calls, improving your user experience, and making our servers run faster."),
                   actions: <Widget>[CupertinoButton(
                     child: Text("Ok"),
                     onPressed: (){
                       Navigator.of(context).pop();
                     },
                   )],
                 );
               }
             );
           },
         ),
         AboutListTile(
           applicationVersion: "3.13",
           applicationName: "SAMO Connect",
           applicationLegalese: "In accordance with federal FERPA law, SAMO Connect does not collect any personal information of students such as their student IDs or Illuminate Logins.",
           applicationIcon: Icon(Icons.school,color: Colors.black,),
         ),
         

      ])
    ),
  );
  
  return Scaffold(
    key: scaffoldKey,
    drawer: menuDrawer,

    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.indigoAccent[700],
      centerTitle: true,
      actions: <Widget>[infoAction],
      title: titleWidget,
      leading: IconButton(
        icon: Icon(Icons.menu,),
        onPressed: (){
            scaffoldKey.currentState.openDrawer();
        },
      ),
    ),
    body: TabBarView(
      physics: NeverScrollableScrollPhysics(),
      controller: tabController,
      children: <Widget>[
        Calender(),
        map(),
        eventView(),
        news(),

      ],
    ),
    bottomNavigationBar: TabBar(
    
      indicatorColor: Colors.indigoAccent[700],
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
         
 
  
}

  Widget calender() {
    return web.WebView(
            initialUrl: calenderUrl,
            javascriptMode: web.JavascriptMode.unrestricted,
          );
  }

  map() {
    return MapboxMap(
      
      initialCameraPosition: CameraPosition(target: LatLng(34.013183,-118.486464),zoom: 16),
      myLocationEnabled: true,
      myLocationTrackingMode: MyLocationTrackingMode.Tracking,
      compassEnabled: true,
      styleString:"mapbox://styles/swerd/cjw4hcm3u1xkd1cnw1zswdrub",
      tiltGesturesEnabled: true,
      
      
      //$project_dir/example/android/app/src/main/res/values/developer-config.xml
    );
        //new TileLayerOptions(
        //  urlTemplate: "https://api.mapbox.com/styles/v1/swerd/cjw4hcm3u1xkd1cnw1zswdrub/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic3dlcmQiLCJhIjoiY2p3NGV3bzBnMWhnaDQ5cXZlMHgzZG5rNyJ9.d_agU8wGRZYZUHOmrrHBjQ",
        //  additionalOptions: {
        //    'accessToken': 'pk.eyJ1Ijoic3dlcmQiLCJhIjoiY2p3NGV3bzBnMWhnaDQ5cXZlMHgzZG5rNyJ9.d_agU8wGRZYZUHOmrrHBjQ',
        //    'id':'swerd.cjw4gw80z0sk22urz5hs9e3z0-317l2'
        //  },
        //)
  
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
                documents.sort((a,b){
                  Timestamp ATime = a["day"];
                  Timestamp BTime = b["day"];
                  if(ATime.seconds>BTime.seconds){
                    return 1;
                  }else{
                    return 0;
                  }
                });
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
                      String date = "";
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
    ,  
         
         );

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("ERROR",style: TextStyle(color: Colors.black,fontSize: 25),),
              SizedBox(height: 10),
              Text(error,style: TextStyle(color: Colors.grey[600]),),
              RaisedButton(child: Text("Try Again"),color: Colors.blue,onPressed: (){
                build(context);
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

                return ListView.builder(
                  itemCount: priceElement.length,

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
                              color: Colors.white,
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
                              color: Colors.white,
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
  void houseRoute(BuildContext context, String house) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c){
          
          return HouseViewV2(House: house,);
        }
      )
    );
  }
}


