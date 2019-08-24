import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart' as mIcons;
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'color_loader_3.dart';
import 'color_loader_4.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
//import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:html/parser.dart' show parse;
import 'story.dart';
//import 'package:mapbox_gl/mapbox_gl.dart';
import 'calender.dart';
import 'checkList.dart';
//import 'dart:io';
//import 'dart:math';
import 'package:url_launcher/url_launcher.dart';
//import 'story.dart';
//import 'dart:convert';
import 'package:unicorndial/unicorndial.dart';
import 'package:html/parser.dart';
import 'login_screen_3.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:latlong/latlong.dart';
//import 'package:twitter/twitter.dart';
//import 'dart:ui' as ui;
//import 'package:groovin_widgets/modal_drawer_handle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';

//import 'package:path_provider/path_provider.dart'
//import 'package:latlong/latlong.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'constants.dart';

import 'attendance.dart';
import 'bellSchedule.dart';
import 'collegeCenter.dart';
import 'clubs.dart';
import 'teachers.dart';
import 'houses.dart';
import 'housesV2.dart';
import 'illuminate.dart';
import 'policies.dart';
import 'map.dart';
import 'library.dart';
import 'bulletin.dart';
import 'developerPage.dart';
//AIzaSyDv1ZVTEAzB00t0LAMHqmyWr-Zr2-CV3no

class MainWindowAndroid extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  static String tag = "MainWindowAndroid";
  static CupertinoActionSheetAction reportABug = CupertinoActionSheetAction(
    child: Text("Report A Bug"),
    onPressed: (){
      launch("https://forms.gle/MqdgiWG8tfeeu7mF6");
    },
  );
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
   Widget shareAction =IconButton(
     icon: Icon(Icons.share,color: Colors.white,),
     splashColor: Colors.yellow,
     onPressed: (){},
   );
       Widget mainMapView;

   TabController tabController;
   TabController newsTabController;

   TabController eventstabController;
  Widget titleWidget = Text("ASB Event Feed");
  var calenderUrl = "https://calendar.google.com/calendar/embed?title=Santa%20Monica%20High%20School%20Calendar&mode=AGENDA&height=600&wkst=1&bgcolor=%23ffffff&src=smmk12.org_21bhbi3q00vuvdf2rak3rrrll8%40group.calendar.google.com&color=%23875509&src=8tn1onqvkup6g281q19s6oon3s%40group.calendar.google.com&color=%230F4B38&src=smmk12.org_tfdd6j1jr5hatfbcj87rro5k9c%40group.calendar.google.com&color=%23125A12&src=smmk12.org_7qnt6q53j7934lvcl0t754of9c%40group.calendar.google.com&color=%23711616&src=smmk12.org_4h8qa262239su4p66islu1e5vg%40group.calendar.google.com&color=%2323164E&src=smmk12.org_t60qs7u1uktrievfsk7gq5c73s%40group.calendar.google.com&color=%23182C57&src=smmk12.org_8umjrnuec40aa66o36lhd1huh8%40group.calendar.google.com&color=%23333333&src=smmk12.org_u8qc6umps8tqttms2sg3456jg8%40group.calendar.google.com&color=%236B3304&ctz=America%2FLos_Angeles";
  dynamic physics = NeverScrollableScrollPhysics();
  @override
  void initState() {
    checkUpToDate();
    checkSignIn();

    // TODO: implement initState
    super.initState();

    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.requestNotificationPermissions();

    eventstabController =TabController(
          vsync: this,
            length: 2,
            initialIndex: 0
    );
    newsTabController = TabController(
      vsync: this,
      length: 4
    );
    tabController =TabController(
      length: 5,
      vsync: this,
      initialIndex: 2
    );
    
    setState(() {
      shareAction = new ShareButton(tabController: tabController);
      infoAction = infoButton();
    });

    
    
     
  
                           
                 
}
IconButton infoButton() {
  return IconButton(
    icon: Icon(Icons.info_outline),
    splashColor: Constants.baseColor,
    onPressed: (){
      int currentIndex = tabController.index;
      if(currentIndex==0){
        Constants.showInfoBottomSheet(
          [
                Constants.officialWebsiteAction(context, "http://www.samohi.smmusd.org/calendar.html"),
                MainWindowAndroid.reportABug,
                Constants.ratingAction(context),
                CupertinoActionSheetAction(
                  child: Text("Where does this data come from?"),
                  onPressed: (){
                    showCupertinoModalPopup(
                      context: context,
                      builder: (c){
                        return CupertinoAlertDialog(
                          title: Text("Info Origins?"),
                          content: RichText(
                            textAlign: TextAlign.center,
                            
                            text:TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(text: "The data comes from the "),
                                TextSpan(text: "official calendar",style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: " on the "),
                                TextSpan(text: "school's website.",style: TextStyle(fontWeight: FontWeight.bold))
                              ]
                            )
                          ),
                          actions: <Widget>[
                            CupertinoDialogAction(
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
                )
              ],
            context
          );
        
      }else if(currentIndex==1){
        Constants.showInfoBottomSheet(
          [

            Constants.actionWithPop(context, "View Official School Map", "http://www.samohi.smmusd.org/houses/images/campus.gif"),
            Constants.actionWithPop(context,"View Old Version","https://api.mapbox.com/styles/v1/swerd/cjw4hcm3u1xkd1cnw1zswdrub.html?fresh=true&title=true&access_token=pk.eyJ1Ijoic3dlcmQiLCJhIjoiY2p3NGV3bzBnMWhnaDQ5cXZlMHgzZG5rNyJ9.d_agU8wGRZYZUHOmrrHBjQ#16.1/34.011844/-118.486192/0"),
            Constants.ratingAction(context),
            CupertinoActionSheetAction(
                  child: Text("Where does this data come from?"),
                  onPressed: (){
                    showCupertinoModalPopup(
                      context: context,
                      builder: (c){
                        return CupertinoAlertDialog(
                          title: Text("Info Origins?"),
                          content: RichText(
                            textAlign: TextAlign.center,
                            
                            text:TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(text: "The data comes from the "),
                                TextSpan(text: "official school map",style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: ". It was put together by "),
                                TextSpan(text: "student developers.",style: TextStyle(fontWeight: FontWeight.bold))
                              ]
                            )
                          ),
                          actions: <Widget>[
                            CupertinoDialogAction(
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
                ),

            MainWindowAndroid.reportABug,
          ],
          context
          );
        
      }else if(currentIndex==2){
        Constants.showInfoBottomSheet(
          [
            CupertinoActionSheetAction(
              child: Text("Extra Info"),
              onPressed: (){
                showCupertinoModalPopup(
                  context: context,
                  builder: (c){
                    return new EventViewInfoDialog(context: context);
                  }
                );
              }
            ),
            MainWindowAndroid.reportABug,
          ],
          context
        );
          }else if(currentIndex==3){
            Constants.showInfoBottomSheet(
              [
                Constants.officialWebsiteAction(context, "https://www.thesamohi.com/"),
                Constants.ratingAction(context),
                CupertinoActionSheetAction(
                  child: Text("Extra Info"),
                  onPressed: (){
                    showCupertinoModalPopup(
                      context: context,
                      builder: (c)=>CupertinoAlertDialog(
                        title: Text("Extra Info"),
                        content: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(text: "The data shown here comes directly from the"),
                              TextSpan(text: " SAMOHI News Website",style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: "."),

                            ])
                          
                          ),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: Text("Ok"),
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                      )
                    );
                  },
                ),
                MainWindowAndroid.reportABug,
              ],
              context
              );
            }else if(currentIndex==4){
              Constants.showInfoBottomSheet(
                [
                  Constants.ratingAction(context),
                  CupertinoActionSheetAction(
                    child: Text("Extra Info"),
                    onPressed: (){
                      showCupertinoModalPopup(
                        context: context,
                        builder: (c){
                          return CupertinoAlertDialog(
                            title: Text("A new checklist feature for all of your schoolwork"),
                            content: Text("The data you input here is stored locally, and seen by no-one but you\n PS. It cannot store more than 9,007,199,254,740,992 todos 😉"),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: Text("Ok"),
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                              ),
                              CupertinoDialogAction(
                                child: Text("Give us a good rating?"),
                                onPressed: (){
                                  Constants.giveARating();
                                  Constants.pop(context);
                                  Constants.pop(context);
                                },
                              )
                            ],
                          );
                        }
                      );
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: Text("Clear"),
                    onPressed: (){
                      Navigator.of(context).pop();
                      try {
                        setState(() {
                          titleWidget = Text("Loading");
                        });
                        SharedPreferences.getInstance().then((prefs){
                          prefs.setStringList(ChecklistPageState.listKey, []);
                          setState(() {
                            titleWidget = Text("Checklist");
                          });
                        });
                      } catch (e) {
                      }
                    },
                  ),
                  MainWindowAndroid.reportABug
                ],
              context
              );
            }
          },
        );
      }
         
      Future<dynamic> checkSignIn() {
        return FirebaseAuth.instance.currentUser().then(
          (currentUser){
            if(currentUser == null){
              showCupertinoModalPopup(
                context: context,
                builder: (c){
                  return showSignUpOrLoginDialog();
                }
              );
            }     
          }
        );
      }
                 
      Future<dynamic> checkUpToDate() {
        return Firestore.instance.collection("update").document("update").get().then(
          (currentUpdate){
            if(checkUpdate(currentUpdate)){
              getTheNewUpdateDialog();
            }
          });
        }
                 
      CupertinoAlertDialog showSignUpOrLoginDialog() {
        return CupertinoAlertDialog(
          title: Text("Login"),
            content: Text("Login or Sign Up with the click of a button"),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text("Login"),
                  onPressed: (){
                    Navigator.of(context).popAndPushNamed(LoginScreen3.tag);
                  },
                ),
              CupertinoDialogAction(
                isDefaultAction: false,
                child: Text("Nah"),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
                 
        checkUpdate(DocumentSnapshot currentUpdate) => currentUpdate.data["android"]>10;
                 
        Future getTheNewUpdateDialog() {
          return showCupertinoModalPopup(
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
                           
                           child: Image.asset("assets/logo.png",fit: BoxFit.contain),
                           padding: EdgeInsets.all(5),
                         ),
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
                                         
                                         return ListTile(
                                           title: Text("Login"),
                                           subtitle: Text("Login or Sign Up"),
                                           trailing: Icon(MdiIcons.login,color: Colors.black,),
                                           onTap: (){
                                             Navigator.of(context).pushNamed(LoginScreen3.tag);
                                           },
                                         );
                                       }else{
                                         return ListTile(
                                           title: Text("Logout"),
                                           subtitle: Text("See you soon!"),
                                           trailing: Icon(MdiIcons.walk,color: Colors.black,),
                                           onTap: (){
                                             showCupertinoModalPopup(
                                               context: context,
                                               builder: (c){
                                                 return CupertinoAlertDialog(
                                                   title: Text("Logout"),
                                                   content: Text("Are you sure? This action cannot be undone."),
                                                   actions: <Widget>[
                                                     CupertinoDialogAction(
                                                       child: Text("Sign Out"),
                                                       onPressed: (){
                                                         FirebaseAuth.instance.signOut();
                                                         Navigator.of(context).popAndPushNamed(MainWindowAndroid.tag);
                                                       },
                                                     ),
                                                     CupertinoDialogAction(
                                                       isDefaultAction: true,
                                                       child: Text("Nevermind"),
                                                       onPressed: (){
                                                         //FirebaseAuth.instance.signOut();
                                                         Navigator.of(context).pop();
                                                       },
                                                     )
                                                   ],
                                                 );
                                               }
                                             );
                                             //Navigator.of(context).pushNamed(LoginScreen3.tag);
                                           },
                                         );
                                         print("Display name:::");
                                         FirebaseUserMetadata m = theUser.metadata;
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
                               ),
                         
                           Container(height: 50,color: Colors.grey[200],child: Text("Important Links:"),alignment: Alignment.bottomLeft,padding: EdgeInsets.all(5),),
                 
                           ListTile(
                           title: Text("Illuminate"),
                           subtitle: Text("Gradebook"),
                           trailing: Icon(CupertinoIcons.book,color: Colors.black,),
                           onTap: (){
                             //Navigator.of(context).pushNamed(Illuminate.tag);
                             Navigator.of(context).push(
                               MaterialPageRoute(
                                 builder: (c)=>new WebviewScaffold(
                                  url: "https://smmusd.illuminatehc.com/",
                                  appBar: new AppBar(
                                    
                                    backgroundColor: Constants.baseColor,
                                    title: new Text("Illuminate"),
                                  ),
                                ),
                                 maintainState: true,
                                 fullscreenDialog: true
                               )
                             );
                           },
                         ),
                         ListTile(
                           title: Text("Clever"),
                           subtitle: Text("For College"),
                           trailing: Icon(MdiIcons.brain,color: Colors.black,),
                           onTap: (){
                              Navigator.of(context).push(
                               MaterialPageRoute(
                                 
                                 builder: (c)=>new WebviewScaffold(
                                   userAgent: "A person",
                                  url: "https://clever.com/oauth/authorize?response_type=code&state=7e61a70abe76142b7e225f5bf580dfe6675ccf7bbff8edc379aeea2b34c217b3&redirect_uri=https%3A%2F%2Fclever.com%2Fin%2Fauth_callback&client_id=4c63c1cf623dce82caac&confirmed=true&channel=clever&district_id=52e02e628b625cb10d006ce5",
                                  appBar: new AppBar(
                                    
                                    backgroundColor: Constants.baseColor,
                                    title: new Text("Clever"),
                                  ),
                                ),
                                 maintainState: true,
                                 fullscreenDialog: true
                               )
                             );
                 
                           },
                         ),
                         ListTile(
                           title: Text("Flex Time"),
                           subtitle: Text("New Schedule"),
                           trailing: Icon(MdiIcons.timelapse,color: Colors.black,),
                           onTap: (){
                             Navigator.of(context).push(
                               MaterialPageRoute(
                                 
                                 builder: (c)=>new WebviewScaffold(
                                   userAgent: "A person",
                                  url: "http://www.samohi.smmusd.org/flextime-pilot.html",
                                  appBar: new AppBar(
                                    
                                    backgroundColor: Constants.baseColor,
                                    title: new Text("Flex Time"),
                                  ),
                                ),
                                 maintainState: true,
                                 fullscreenDialog: true
                               )
                             );
                           },
                         ),
                         Container(height: 50,color: Colors.grey[200],child: Text("Info Links:"),alignment: Alignment.bottomLeft,padding: EdgeInsets.all(5),),
                           ListTile(
                           title: Text("Schedule"),
                           subtitle: Text("School Bell Schedule"),
                           trailing: Icon(Icons.schedule,color: Colors.black,),
                           onTap: (){
                            // launch("http://www.samohi.smmusd.org/Students/bells.html",enableJavaScript: true);
                             Navigator.of(context).push(
                               MaterialPageRoute(
                                 builder: (c)=>BellSchedule(),
                                 maintainState: true,
                                 fullscreenDialog: true
                               )
                             );
                           },
                         ),
                         ListTile(
                           title: Text("Staff Directory"),
                           subtitle: Text("Find Teachers"),
                           trailing: Icon(MdiIcons.teach,color: Colors.black,),
                           onTap: (){
                             //launch("http://www.samohi.smmusd.org/Admin/staff.html",enableJavaScript: true);
                             Navigator.of(context).push(
                               MaterialPageRoute(
                                 builder: (c)=>Teachers(),
                                 maintainState: true,
                                 fullscreenDialog: true
                               )
                             );
                           },
                          ),
                         ListTile(
                           title: Text("College Center"),
                           subtitle: Text("Information"),
                           trailing: Icon(MdiIcons.school,color: Colors.black,),
                           onTap: (){
                             //launch("http://www.samohi.smmusd.org/CollegeCenter/index.html",enableJavaScript: true);
                             Navigator.of(context).push(
                               MaterialPageRoute(
                                 builder: (c)=>CollegeCenter(),
                                 maintainState: true,
                                 fullscreenDialog: true
                               )
                             );
                           },
                         ),
                         
                         ListTile(
                           title: Text("Policies"),
                           subtitle: Text("SAMOHI Policies"),
                           trailing: Icon(MdiIcons.ruler,color: Colors.black,),
                           onTap: (){
                             Navigator.of(context).push(
                               MaterialPageRoute(
                                 builder: (c)=>PolicyPage(),
                                 maintainState: true,
                                 fullscreenDialog: true
                               )
                             );
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
                           title: Text("Daily Bulletin"),
                           subtitle: Text("Todays Info"),
                           trailing: Icon(MdiIcons.bulletinBoard,color: Colors.black,),
                           onTap: (){
                             //launch("http://www.samohi.smmusd.org/BB.pdf",enableJavaScript: true);
                             Navigator.of(context).push(
                               MaterialPageRoute(
                                 builder: (c)=>new WebviewScaffold(
                                  url: "http://www.samohi.smmusd.org/BB.pdf",
                                  appBar: new AppBar(
                                    
                                    backgroundColor: Constants.baseColor,
                                    title: new Text("Daily Bulletin"),
                                  ),
                                ),
                                 maintainState: true,
                                 fullscreenDialog: true
                               )
                             );
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
                           title: Text("Attendance"),
                           subtitle: Text("Policy"),
                           trailing: Icon(CupertinoIcons.pencil,color: Colors.black,),
                           onTap: (){
                             //launch("http://www.samohi.smmusd.org/Admin/attendance.html",enableJavaScript: true);
                             Navigator.of(context).popAndPushNamed(Attendance.tag);
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
                          Container(height: 50,color: Colors.grey[200],child: Text("Developed by Benjamin Swerdlow, \u00a9SwerdIsTheWord"),alignment: Alignment.bottomLeft,padding: EdgeInsets.all(5),),
                          ListTile(
                            title: Text("Developed By"),
                            subtitle: Text("See the SAMO Connect Team"),
                            trailing: Icon(MdiIcons.developerBoard,color: Colors.black,),
                            onTap: ()=>Navigator.of(context).pushNamed(DeveloperPage.tag),
                          ),
                          //https://forms.gle/vyJF2XWDgycXifQg7
                          ListTile(
                            title: Text("Report a bug"),
                            subtitle: Text("Your feedback helps us make the app better"),
                            trailing: Icon(MdiIcons.bug,color: Colors.black,),
                            onTap: (){
                              launch("https://forms.gle/vyJF2XWDgycXifQg7");
                            },
                          ),
                          ListTile(
                            title: Text("Feedback"),
                            subtitle: Text("Your feedback helps us make the app better"),
                            trailing: Icon(MdiIcons.phoneInTalk,color: Colors.black,),
                            onTap: (){
                              launch("https://forms.gle/vyJF2XWDgycXifQg7");
                            },
                          ),
                            //https://forms.gle/xcn1KVUndTVry3X36
                            //https://forms.gle/xcn1KVUndTVry3X36
                          ListTile(
                            title: Text("Join the team"),
                            subtitle: Text("We accept anyone who wants to help, not limited to programmers"),
                            trailing: Icon(MdiIcons.emoticonCoolOutline,color: Colors.black,),
                            onTap: (){
                              launch("https://forms.gle/vyJF2XWDgycXifQg7");
                            },
                            
                          ),
                          ListTile(
                            trailing: Icon(MdiIcons.account,color: Colors.black,),
                            title: Text("Why Sign in?"),
                            subtitle: Text("Benefits"),
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
                       title: TabBarView(
                         
                         controller: tabController,
                         children: <Widget>[
                           Center(child:Text("Calendar")),
                           Center(child:Text("Map")),
                           Center(child:Text("SAMOHI Connect")),
                           Center(child:Text("The SAMOHI News")),
                           Center(child:Text("Checklist")),
                         ],
                       ),
                       actions: <Widget>[shareAction,infoAction],
                       leading: IconButton(
                         icon: Icon(Icons.menu,),
                         splashColor: Colors.yellow,
                         onPressed: (){
                             scaffoldKey.currentState.openDrawer();
                         },
                       ),
                     ),
                     body: TabBarView(
                       physics: physics,
                 
                       //physics: ScrollPhysics(parent: ScrollPhysics().cr()),
                       controller: tabController,
                       children: <Widget>[
                         Calendar(),
                         map(),
                         eventView(),
                         news(),
                         ChecklistPage()
                       ],
                     ),
                     // floatingActionButton: FloatingActionButton(
                     //   hoverColor: Colors.indigoAccent[700],
                     //   focusColor: Colors.indigoAccent[700],
                     //   backgroundColor: Colors.indigoAccent[700],
                     //   onPressed: (){
                     //     tabController.animateTo(2);
                     //   },
                     //   child: Container(
                     //     padding: EdgeInsets.only(bottom: 3),
                     //     child:Icon(MdiIcons.homeOutline)
                     //     //child: Image.asset("assets/vikingC3.png")
                     //     ),
                     // ),
                     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                     bottomNavigationBar: TabBar(
                     
                       indicatorColor: Colors.indigoAccent[700],
                       indicatorWeight: 2,
                       
                       controller: tabController,
                       indicatorSize: TabBarIndicatorSize.tab,
                       tabs: <Widget>[
                         Tab(          
                           
                           icon: Icon(MdiIcons.calendarTextOutline,color: Colors.black,),
                         ),
                          Tab(          
                           icon: Icon(MdiIcons.mapOutline,color: Colors.black,),
                         ),
                         Tab(
                           child: Padding(
                             padding: const EdgeInsets.only(top:2.0),
                             child: Image.asset("assets/vikingB3.png"),
                           ),
                         ),
                         Tab(
                           icon: Icon(CupertinoIcons.news,color: Colors.black,),
                         ),
                         Tab(icon: Icon(MdiIcons.playlistCheck, color: Colors.black,),)
                       ],
                     ),
                   );
                          
                  
                   
                 }
                 
                   void houseRoute(BuildContext context, String house) {
                     Navigator.of(context).push(
                       MaterialPageRoute(
                         builder: (c){
                           return HouseViewV2(House:house);
                         }
                       )
                     );
                   }
                 
                 
                   map() {
                     return MapClass();
                     
                    
                     //print(MapboxStyles.TRAFFIC_DAY);
                 
                         //new TileLayerOptions(
                         //  urlTemplate: "https://api.mapbox.com/styles/v1/swerd/cjw4hcm3u1xkd1cnw1zswdrub/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic3dlcmQiLCJhIjoiY2p3NGV3bzBnMWhnaDQ5cXZlMHgzZG5rNyJ9.d_agU8wGRZYZUHOmrrHBjQ",
                         //  additionalOptions: {
                         //    'accessToken': 'pk.eyJ1Ijoic3dlcmQiLCJhIjoiY2p3NGV3bzBnMWhnaDQ5cXZlMHgzZG5rNyJ9.d_agU8wGRZYZUHOmrrHBjQ',
                         //    'id':'swerd.cjw4gw80z0sk22urz5hs9e3z0-317l2'
                         //  },
                         //)
                   
                   }
                 
                   Scaffold MapScaffoldMaker(Widget mappView) {
                    List<UnicornButton> childButtons = List<UnicornButton>();
                    childButtons.add(
                      UnicornButton(
                        hasLabel: true,
                        labelText: "Buildings",
                        currentButton: FloatingActionButton(
                          heroTag: "Buildings",
                          mini: true,
                          backgroundColor: Colors.redAccent[400],
                          child: Icon(MdiIcons.officeBuilding),
                          onPressed: () {},
                        )
                      )
                    );
                    childButtons.add(
                     UnicornButton(
                     hasLabel: true,
                     labelText: "Important Rooms",
                         currentButton: FloatingActionButton(
                             heroTag: "Important Rooms",
                             backgroundColor: Colors.deepPurple,
                             mini: true,
                             onPressed: (){
                               print("IN MOTION??");
                               setState(() {
                                 mainMapView = Container(color: Colors.red,);
                           //      buildings ={constructionZone};
                               });
                             },
                             child: Icon(CupertinoIcons.bookmark))));
                    childButtons.add(
                    UnicornButton(
                       labelText: "All",
                       hasLabel: true,
                         currentButton: FloatingActionButton(
                             heroTag: "All",
                             
                             backgroundColor: Colors.indigoAccent[700],
                             mini: true,
                             onPressed: (){},
                             child: Image.asset("assets/logo.png"),
                             )));
                 
                     return Scaffold(
                    body:  mappView,
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: UnicornDialer(
                    parentButtonBackground: Colors.indigoAccent[700],
                    childPadding: 4,
                    childButtons: childButtons,
                    parentButton: Icon(Icons.menu),
                    finalButtonIcon: Icon(Icons.close),
                    hasNotch: false,
                    hasBackground: false,
                    
                    backgroundColor: Colors.indigoAccent[700],
                 
                  ),
                  );
                   }
                 
                   GoogleMap googleMap(Set<Marker> buildings) {
                     return GoogleMap(
                    compassEnabled: true,
                    
                    initialCameraPosition: CameraPosition(target: LatLng(34.012,-118.487),zoom: 17,tilt: 10),
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    markers: buildings,
                    
                    
                  );
                   }
                 eventView() {
                   LocalStorage eventImages = LocalStorage("events");
                   Map theImages = eventImages.getItem("images")!=null?eventImages.getItem("images"):new Map();
                   if(theImages==null){
                     eventImages.setItem("images",new Map());
                   }
                     return FutureBuilder(
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
                                   Timestamp aTime = a["day"];
                                   Timestamp bTime = b["day"];
                                   if(aTime.seconds>bTime.seconds){
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
                                       date = new DateFormat.yMMMMd("en_US").format( DateTime.parse(time.toDate().toString()));
                 
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
                                                   try {
                                                     return Container(
                                                     child:Image.memory(s.data,fit: BoxFit.fitWidth,),
                                                     height: 350,
                                                     width: MediaQuery.of(c).size.width,
                                                     );
                                                   } catch (e) {
                                                     return Container(
                                                     child:Stack(
                                                       fit: StackFit.expand,
                                                       children: <Widget>[
                                                         Image.asset("assets/vikingC3.png",fit: BoxFit.fitWidth,),
                                                        // Text("Looks like you are looking for something that doesn't work")
                                                       ],
                                                     ),
                                                     height: 350,
                                                     width: MediaQuery.of(c).size.width,
                                                     );
                                                   }
                                                   
                                                     
                                                 }
                                               },
                                               ),
                                               Container(
                                                 height: 120,
                                                 width: MediaQuery.of(context).size.width-40,
                                                 padding: EdgeInsets.all(5),
                                                 child: RaisedButton(
                                                   elevation: 10,
                                                   color: Colors.white,
                                                   child: Column(
                                                     mainAxisAlignment: MainAxisAlignment.center,
                                                     children: <Widget>[
                                                       Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: <Widget>[
                                                           Text(document.documentID,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 21),),
                                                         ],
                                                       ),
                                                       Text(document["description"],textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 17),),
                                                       Row(
                                                         mainAxisAlignment: MainAxisAlignment.end,
                                                         children: <Widget>[
                                                           Text(date,textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 19),),
                                                       ],)
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
                           );
                         
                 
                   }
                   
                   Widget news() {
                     String tab1str = "News";
                     String tab2str = "Sports";
                     String tab3str = "Opinion";
                     String tab4str = "Feature";
                     //embed
                     return Scaffold(
                        appBar: TabBar(
                          indicatorColor: Colors.indigoAccent[700],
                          controller: newsTabController,
                          tabs: <Widget>[
                            Tab(child: Constants.basicText(tab1str)),
                            Tab(child: Constants.basicText(tab2str)),
                            Tab(child: Constants.basicText(tab3str)),
                            Tab(child: Constants.basicText(tab4str))
                          ],
                        ),
                        body: TabBarView(
                          controller: newsTabController,
                          children: <Widget>[
                           newsFeedBuilder(tab1str),
                           newsFeedBuilder(tab2str),
                           newsFeedBuilder(tab3str),
                           newsFeedBuilder(tab4str)
                          ],
                        )    
                      );
                    }
                 
                   FutureBuilder<http.Response> newsFeedBuilder(String siteExtension) {
                     return FutureBuilder(
                           future: http.get("https://www.thesamohi.com/category/"+siteExtension),
                           builder: (c,s){
                             if(s.hasError){
                         String error = "Network failure";
                         if(s.error.runtimeType.toString()=="SocketException"){
                           error = "Handshake Failure";
                         }
                         //if()
                        
                         
                         return Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: <Widget>[
                             RichText(
                               textAlign: TextAlign.center,
                               text: TextSpan(
                                 style: TextStyle(color: Colors.black, fontSize: 19),
                                 children: <TextSpan>[
                                   TextSpan(text: "Sorry, it looks like your "),
                                   TextSpan(text: "offline",style: TextStyle(fontWeight: FontWeight.bold))

                                 ]
                               ),
                             )
                             
                           ],
                         );
                       }else
                             if(s.connectionState!=ConnectionState.done){
                               return Center(child:ColorLoader3());
                             }else{
                               try {
                                 
                               
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
                                   try {
                                     
                                  
                                   
                                   print("New Post");
                                   print(priceElement[i].localName);
                                   print("HTML");
                                   print(priceElement[i].innerHtml);
                                   var document2 = parse(priceElement[i].innerHtml);
                                   var imageHope;
                                   try {
                                     imageHope = document2.getElementsByClassName("omc-image-blog-one wp-post-image");
                                   } catch (e) {
                                     imageHope = document2.getElementsByClassName("omc-image-blog-one");
                 
                                     //omc-image-blog-one
                                   }
                                   
                                   var headingHope =document2.getElementsByClassName("omc-blog-one-heading");
                                   String writtenBy = "";
                                   String writtenWhen = "";
                                   try {
                                     var baseOfWrite = document2.getElementsByClassName("omc-date-time-one");
                                     String start = baseOfWrite.last.text;
                                     print("START 12");
                                     List pubandwrite = start.split("|");
                                     writtenBy = pubandwrite.last.toString().trim();
                                     writtenWhen = pubandwrite.first.toString().trim();
                 
                                     //print();
                 
                                   } catch (e) {
                                   }
                                   print("WRitten on");
                                   print(writtenWhen);
                                   print("Written By");
                                   print(writtenBy);
                                   
                 
                                   //omc-blog-one-heading
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
                                         return Center(child:Text("Failed to load post"));
                                       }else if(s.connectionState!=ConnectionState.done){
                                         var loadingSlide = RaisedButton(
                                             color: Colors.white,
                                             shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(25)),
                                             elevation: 10,
                                             onPressed: (){
                 
                                             },
                                             child: Center(child: ColorLoader3(),)
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
                 
                                           child: RaisedButton(
                                             padding:  EdgeInsets.all(10),
                                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                             elevation: 15,
                                             onPressed: (){
                                              print("FISSH ITS IN HERE");
                                              print(link);
                                              print("HEADER BEFORE PUSH:");
                                              print(theHeader);
                                             Navigator.push(
                                               context,
                                                 MaterialPageRoute(builder: (context) => Story(header: theHeader,link: link,by:writtenBy,when:writtenWhen)),
                                               );                              
                                             },
                                             color: Colors.white,
                                             child:Row(
                                               
                                             children: <Widget>[
                                              Container(child:ClipRRect(child:Image.memory(s.data.bodyBytes,fit: BoxFit.cover,), borderRadius: BorderRadius.circular(25)),width: 155,height: 175,padding: EdgeInsets.zero,),
                                                
                                              
                                             Expanded(child:Column(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: <Widget>[
                                                 Text(theHeader,maxLines: 3,style: TextStyle(color: Colors.black,fontSize: 20),textAlign: TextAlign.center,),
                                                 Text(writtenWhen,maxLines: 3,style: TextStyle(color: Colors.grey[700],fontSize: 16),textAlign: TextAlign.center,),
                                                 Text(writtenBy,maxLines: 3,style: TextStyle(color: Colors.grey[800],fontSize: 18),textAlign: TextAlign.center,),
                 
                                               ],
                                             )),
                                             
                                                
                                             
                                             ],)),
                                         );
                                         
                                         
                                       }
                                     },
                                 );
                                  } catch (e) {
                                    return Container(height:0);
                                   }
                                 },
                               );
                               } catch (e) {
                                 return Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children:<Widget>[
                                     Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          
                                          children: <TextSpan>[
                                            TextSpan(text: "This view is very ",style: TextStyle(fontSize: 18)),
                                            TextSpan(text: "popular",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                                            TextSpan(text: ", and the server is currently ",style: TextStyle(fontSize: 18)),
                                            TextSpan(text: "full",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                                            TextSpan(text: ". \nPlease check back in 5 minutes",style: TextStyle(fontSize: 18)),


                                          ]
                                        ),
                                      ),
                                    ),
                                     Text("Error linking to server",style: TextStyle(color: Colors.black,fontSize: 16),),

                                     ]);
                               }
                             }
                             
                           },
                         );
                   }
                 
                   void setTabScroll(bool scrollable) {
                     ScrollPhysics thePhysics;
                     if(scrollable){
                       thePhysics = AlwaysScrollableScrollPhysics();
                     }else{
                       thePhysics = NeverScrollableScrollPhysics();
                     }
                     setState(() {
                       physics = thePhysics;
                     });

                   }



}

class EventViewInfoDialog extends StatelessWidget {
  const EventViewInfoDialog({
    Key key,
    @required this.context,

  }) : super(key: key);

  final BuildContext context;


  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("A view for upcoming ASB events"),
      content: Text("This view is not official yet, though with your support, it may be in a few months"),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text("Ok"),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          child: Text("Give us a good rating?"),
          onPressed: (){
            Constants.giveARating();
            Constants.pop(context);
            Constants.pop(context);
          },
        )
      ],
    );
  }
}

class ShareButton extends StatelessWidget {
  const ShareButton({
    Key key,
    @required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return IconButton(
    icon: Icon(Icons.share),
    splashColor: Colors.yellow,
    onPressed: (){
      if(tabController.index==0){
       Constants.shareString("Check out the Official School Calendar on SAMO Connect -- https://samoconnect.page.link/SamoConnect");
      }else if(tabController.index==1){
        Constants.shareString("See school in focus, with the school map, on SAMO Connect -- https://samoconnect.page.link/SamoConnect");
      }else if(tabController.index==2){
        Constants.shareString("Hear about upcoming ASB events, with the exclusive ASB Event Feed, on SAMO Connect -- https://samoconnect.page.link/SamoConnect");
      }else if(tabController.index==3){
        Constants.shareString("Know all the SAMOHI News with the click of a button, on SAMO Connect -- https://samoconnect.page.link/SamoConnect");
      }else if(tabController.index==4){
        Constants.shareString("Keep up with your schoolwork with the new checklist feature, on SAMO Connect -- https://samoconnect.page.link/SamoConnect");

      }
      
    }
      );
  }
}

