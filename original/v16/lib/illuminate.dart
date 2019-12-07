import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:v16/color_loader_5.dart';
import 'constants.dart';
import 'color_loader_3.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:html/dom.dart'as dom;
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart'; 
import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';


class Illuminate extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
 static String tag = "illuminate";
  Illuminate();

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  _IlluminateState createState() => new _IlluminateState();
}

class _IlluminateState extends State<Illuminate> with TickerProviderStateMixin {
  static String baseURL = "https://smmusd.illuminatehc.com";


  Widget bodyWidget;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController usernameController;
  TextEditingController passwordController;

  CupertinoActionSheetAction officialWebsiteAction;
  AnimationController menuController;

  TabController gradebookTabController;
  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    menuController = new AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this
    );

    gradebookTabController = new TabController(length: 2, vsync: this);
    officialWebsiteAction =  Constants.officialWebsiteAction(context, baseURL);
    bodyWidget =loginPage();
  }

  FutureBuilder<http.Response> loginPage() {
    return FutureBuilder(
      future:http.get(baseURL+"/login"),
      builder: (c,s){
        if(s.hasError){
          return Center(child: Text("Network Handshake Error;\nCheck your connection"),);
        }
        if(s.connectionState!=ConnectionState.done){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(child: ColorLoader3(),),
              Text("Establishing connection with Illuminate")
            ],
          );
        }else{
          //print(s.data.body);
          http.Response response = s.data;
          print("JEADERS");
          
          String header = response.headers["set-cookie"].split(',').last.split(';').first;
          print(header);
          return Padding(
            padding: EdgeInsets.all(15),
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image.asset('assets/university.png', width: MediaQuery.of(context).size.width/3),
                    Container(height: 12,),
                    Text("Illuminate", textAlign: TextAlign.center,style: TextStyle(fontSize: 32),),
                  ],
                ),
                Container(height: 80,),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Username:", style: TextStyle(fontSize: 18),)
                      ],
                    ),
                    TextField(
                      controller: usernameController,
                      autocorrect: false,
                      
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),

                        labelText: "Username"
                      ),
                    ),
                    Container(height: 40,),
                    Row(
                      children: <Widget>[
                        Text("Password:", style: TextStyle(fontSize: 18),)
                      ],
                    ),
                    TextField(
                      controller: passwordController,
                      autocorrect: false,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "Password"
                      ),
                    ),
                    Container(height: 50,),
                    Container(
                      child: RaisedButton(
                        elevation: 10,
                        padding: EdgeInsets.symmetric(vertical:25, horizontal:(MediaQuery.of(context).size.width-140)/2),
                        color: Constants.baseColor,
                        onPressed: (){
                          if(usernameController.text.isEmpty){
                            scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.redAccent,
                                content: Text("Please enter your username"),
                                action: SnackBarAction(label: "Ok",onPressed: ()=>scaffoldKey.currentState.hideCurrentSnackBar()),
                              )
                            );
                          }else{
                            if(passwordController.text.isEmpty){
                              scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.redAccent,
                                  content: Text("Please enter your password"),
                                  action: SnackBarAction(label: "Ok",onPressed: ()=>scaffoldKey.currentState.hideCurrentSnackBar(),),
                                )
                              );
                            }else{
                              setState(() {
                                bodyWidget = checkLogin(header, usernameController.text, passwordController.text);
                              });
                            }
                          }
                        },
                        child: Text("LOGIN", style: TextStyle(color: Colors.white, fontSize: 22),),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
                      ),
                    ),
                    Container(height: 40,),
                  ],
                )
                

              ],
            ),
          );//checkLogin(header,"595537","123456");
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent[700],
        title: Text("Illuminate"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            color: Colors.white,
            splashColor: Colors.yellowAccent,
            onPressed: (){
              Constants.showInfoBottomSheet([
                officialWebsiteAction,
                Constants.ratingAction(context),
                CupertinoActionSheetAction(
                  child: Text("Extra Info"),
                  onPressed: ()=>showCupertinoModalPopup(
                    context: context,
                    builder: (c)=>CupertinoAlertDialog(
                      title: Text("Extra Info"),
                      content: Text("In-app illuminate makes accessing your gradebook easy. Your information completely safe, it is only used for when you login, and cleared when you press the back button."),
                      actions: <Widget>[CupertinoDialogAction(child: Text("Ok"),onPressed: ()=>Navigator.of(context).pop(),)],
                    )
                  ),
                ),
                CupertinoActionSheetAction(
                  child: Text("Share"),
                  onPressed: ()=>Constants.shareString("Hate using illuminate on your phone? SAMOHI Connect offers a true, formatted, in-app illuminate experience -- https://swerd.tech/samoconnect.html"),
                )
              ], context);
            },
          )
        ],
      ),
      key: scaffoldKey,
      body: bodyWidget
    );
  }

  FutureBuilder<http.Response> checkLogin(String header,String username, String password) {
    return FutureBuilder(
            future: http.post(baseURL+"/login_check", headers: {"cookie":header}, body: {"_username":username,"_password":password}),
            builder: (c, s){
              if(s.connectionState!=ConnectionState.done){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(child: ColorLoader3()),
                    Text("Attempting to login", textAlign: TextAlign.center,)
                  ],
                );
              }else{
                http.Response r = s.data;
                print(r.headers['set-cookie']);
                header = r.headers['set-cookie'].split(",").last.split(";").first;

                print("header");
                print(header);
                dom.Document theDoc = parse(s.data.body);
                
                
                  print("Logged In success");
                try {
                  
                  return loggedInBuilder(header);

                } catch (e) {
                  return loginPage();
                }


              }
            },
          );
  }

  Widget loggedInBuilder(String header) {
    try {
      
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(child: AnimatedIcon(icon:AnimatedIcons.menu_close, progress: menuController),heroTag: "Menu",onPressed: (){
          menuController.forward();
          showCupertinoModalPopup(
          context: context,
          builder: (c)=>CupertinoActionSheet(
            title: Text("See more of your illuminate"),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text("Attendance Records"),
                onPressed: ()=>attendanceBuilder(header),
              )
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Text("Cancel"),
              onPressed: ()=>Navigator.of(context).pop(),
            ),
          )
        ).then((onValue)=>menuController.reverse());

        
        }
        ),
        body: FutureBuilder(
                      future: http.get(baseURL+"/student-path?login=1", headers: {"cookie":header}),
                      builder: (c,s){
                        if(s.connectionState!=ConnectionState.done){
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(child: ColorLoader3(),),
                              Text("Verifying login", textAlign: TextAlign.center,)
                            ],
                          );
                        }else{
                          dom.Document doc = parse(s.data.body);
                          print(doc.children.first.children);
                          print(doc.body.innerHtml);
                          try {
                            return gradebookBuilder(header);
                          } catch (e) {
                            return loginPage();
                          }

                          
                        }
                      },
                    ),
      );
    } catch (e) {
      return loginPage();
    }
  }

  FutureBuilder<http.Response> gradebookBuilder(String header) {
    
    try {
      
      return FutureBuilder(
                        future: http.get(baseURL+"/gradebooks/", headers: {"cookie":header}),
                        builder: (c,s){
                          if(s.connectionState!=ConnectionState.done){
                            return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(child: ColorLoader3(),),
                              Text("Loading gradebook", textAlign: TextAlign.center,)
                            ],
                          );
                          }else{
                            try {
                              
                            
                            dom.Document doc = parse(s.data.body);
                            print(doc.children.first.children);
                            print(doc.body.innerHtml);
                            if(doc.body.innerHtml.contains("Gradebook Summary")){
                              print("TRUEEEEE");
                              if(doc.body.innerHtml.contains("ENGLISH 10 HP")){
                                print("ALSO TRURRRR");
                              }
                            }
                            List<dom.Element> unformattedGrades = doc.body.getElementsByClassName("ibox-content").last.children.first.children.first.children.last.children;
                            List formattedGrades = [];
                            for (dom.Element grade in unformattedGrades) {
                              Map classMap = new Map();
                              classMap['grade'] = grade.children.first.innerHtml.split(" ").first;
                              Color color = Colors.black;
                              try {
                                color = Color(int.parse("0xff"+grade.attributes['style'].split("#").last.toString().toLowerCase()));
                              } catch (e) {
                                color = Colors.black;
                              }
                              classMap['gradeColor'] = color;
                              double gradePercent = 100;
                              try {
                                gradePercent = double.parse(grade.children.first.innerHtml.split(" ").last.split('%').first.toString());
                              } catch (e) {
                                gradePercent = 100;
                              }
                              classMap['gradePercent'] = gradePercent;
                              classMap['class'] = grade.children[1].innerHtml;
                              classMap['teacher'] = grade.children[3].innerHtml;
                              classMap['lastUpdated'] = grade.children[4].innerHtml;
                              classMap['url'] = grade.children[2].children.first.attributes['href'];

                              formattedGrades.add(classMap);
                            }
                            
                            officialWebsiteAction = new CupertinoActionSheetAction(
                              child: Text("View on website"),
                              onPressed: ()=>gradebookWebview(header, baseURL+"/gradebooks/", "Gradebook")
                            );
                            return Scaffold(
                              appBar: TabBar(
                                controller: gradebookTabController,
                                tabs: <Widget>[
                                  Tab(icon: Icon(MdiIcons.grid),),
                                  Tab(icon: Icon(Icons.filter_list),)
                                ],
                              ),
                              body: TabBarView(
                                controller: gradebookTabController,
                                children: <Widget>[
                                  GridView.builder(
                                    
                                    itemCount: formattedGrades.length,
                                    padding: EdgeInsets.all(15),
                                    itemBuilder: (c,i){
                                      Map thisClass = formattedGrades[i];
                                      Row theClassHeading = Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                              Text(thisClass['class']),
                                              Text(thisClass['grade'], style: TextStyle(color: thisClass['gradeColor'], fontWeight: FontWeight.bold)),
                                            ],);

                                      double chartSize = ((MediaQuery.of(context).size.width-30)/2-45);
                                      return RaisedButton(
                                        padding: EdgeInsets.all(10),
                                        elevation: 15,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                        color: Colors.white,
                                        child:Column(
                                          children: <Widget>[
                                            theClassHeading,
                                            AnimatedCircularChart(
                                            chartType: CircularChartType.Radial,
                                            size: Size(chartSize,chartSize),
                                            holeLabel: formattedGrades[i]['gradePercent'].toString()+"%",
                                            labelStyle: TextStyle(color: Colors.black, fontSize: 28),
                                            initialChartData: [
                                              CircularStackEntry(
                                                [
                                                  CircularSegmentEntry(
                                                    formattedGrades[i]['gradePercent'],Colors.greenAccent[400]
                                                  ),
                                                  CircularSegmentEntry(
                                                    100-formattedGrades[i]['gradePercent'],Colors.redAccent[400]
                                                  )
                                                ]
                                              )
                                            ],
                                          ),

                                          ],
                                        ),
                                        onPressed: ()=>openClassGradebook(header, formattedGrades[i]['url'], formattedGrades[i]['class']),
                                      );
                                    },
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2, crossAxisSpacing: 15, mainAxisSpacing: 15, ),
                                  ),
                                  ListView.separated(
                                    padding: EdgeInsets.all(50),
                                    itemCount: formattedGrades.length,

                                    separatorBuilder: (c,i)=>Container(height: 30,),
                                    itemBuilder: (c,i)=>RaisedButton(
                                      elevation: 15,
                                      
                                      splashColor: Constants.baseColor,
                                      padding: EdgeInsets.all(15),
                                      color: Colors.white,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(formattedGrades[i]['class'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                              Text(formattedGrades[i]['grade'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(formattedGrades[i]['teacher'], style: TextStyle(fontSize: 19, fontWeight: FontWeight.normal, color: Colors.grey[600]),),
                                              Text(formattedGrades[i]['lastUpdated'], style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold))
                                            ],
                                          ),
                                          AnimatedCircularChart(
                                            chartType: CircularChartType.Radial,
                                            size: Size(MediaQuery.of(context).size.width-160,MediaQuery.of(context).size.width-160),
                                            holeLabel: formattedGrades[i]['gradePercent'].toString()+"%",
                                            labelStyle: TextStyle(color: Colors.black, fontSize: 28),
                                            initialChartData: [
                                              CircularStackEntry(
                                                [
                                                  CircularSegmentEntry(
                                                    formattedGrades[i]['gradePercent'],Colors.greenAccent[400]
                                                  ),
                                                  CircularSegmentEntry(
                                                    100-formattedGrades[i]['gradePercent'],Colors.redAccent[400]
                                                  )
                                                ]
                                              )
                                            ],
                                          ),
                                          FutureBuilder(
                                            future: http.get(baseURL+formattedGrades[i]['url'], headers: {"cookie":header}),
                                            builder: (c,s){
                                              if(s.connectionState!=ConnectionState.done){
                                                return Center(child: ColorLoader5());
                                              }else{
                                                try {
                                                   List<Map> theAssignments = formatGradebook(s);
                                                    Map infoAnalysis = new Map();
                                                    infoAnalysis['hasMissings'] = false;
                                                    infoAnalysis['hasAces'] = false;

                                                    for (Map assignment in theAssignments) {
                                                      try {
                                                        
                                                      
                                                      print(assignment);
                                                      if(assignment['missing']){
                                                        infoAnalysis['missings']!=null?infoAnalysis['missings']++:infoAnalysis['missings']=1;
                                                        infoAnalysis['hasMissings'] = true;
                                                        print("WE HAVE A MISSING");
                                                      }else if(assignment['ace']){
                                                         infoAnalysis['aces']!=null?infoAnalysis['aces']++:infoAnalysis['aces']=1;
                                                         infoAnalysis['hasAces'] = true;
                                                          print("WE HAVE AN ACE");
                                                      }
                                                      } catch (e) {
                                                      }
                                                    }
                                                    Widget missingWidget = Container();
                                                    Widget aceWidget = Container();

                                                    if(infoAnalysis['hasMissings']){
                                                      missingWidget = Column(children: <Widget>[
                                                        FloatingActionButton(
                                                          mini: true,
                                                          onPressed: (){

                                                          },
                                                          backgroundColor: Colors.redAccent[400],
                                                          child: Icon(MdiIcons.alertCircleOutline),
                                                          tooltip: infoAnalysis['missings'].toString()+" Missing",
                                                          heroTag: formattedGrades[i].toString()/*Stopping scheduler conflicts */,
                                                        ),
                                                        Text(infoAnalysis['missings'].toString()+" Missing")
                                                      ],);
                                                    }
                                                    if(infoAnalysis['hasAces']){
                                                      aceWidget = Column(children: <Widget>[
                                                        FloatingActionButton(
                                                          mini: true,
                                                          onPressed: (){

                                                          },
                                                          backgroundColor: Color.fromRGBO(255,215,0, 1),
                                                          child: Icon(MdiIcons.starOutline),
                                                          tooltip: infoAnalysis['aces'].toString()+" Aces",
                                                          heroTag: formattedGrades[i].toString()+"ACE"/*Stopping scheduler conflicts */,
                                                        ),
                                                        Text(infoAnalysis['aces'].toString()+" Aces")
                                                      ],);
                                                    }
                                                    return Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        missingWidget,
                                                        aceWidget
                                                      ],
                                                    );
                
                                                } catch (e) {
                                                  print("OH I GOTTA ERROR");
                                                  print(e);
                                                  return Container(height: 0);
                                                }
                                              }
                                            },
                                          
                                          )
                                        ],
                                      ),
                                      onPressed: ()=>openClassGradebook(header, formattedGrades[i]['url'], formattedGrades[i]['class']),
                                    ),
                                  ),
                                ],
                              ),
                            );//
                            } catch (e) {
                              //LOGIN ERROR
                              try {
                                scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.redAccent[400],
                                  action: SnackBarAction(label: "OK",onPressed: ()=>scaffoldKey.currentState.hideCurrentSnackBar(),textColor: Colors.white,),
                                  content: Text("Sorry, we can't log you in right now."),
                                )
                              );
                              } catch (e) {
                              }
                              
                              return loginPage();
                            }
                          }
                          
                        }
                        
                      );

    } catch (e) {
      return loginPage();
    }
  }

  Future gradebookWebview(String header,url, title) {
    return Navigator.of(context).push(
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                maintainState: true,
                                builder: (c)=>WebviewScaffold(url: url, headers: {"cookie":header},appBar: AppBar(title: Text(title),actions: <Widget>[IconButton(icon: Icon(Icons.launch),onPressed: ()=>launch(url),),]))
                              )
                            );
  }

  openClassGradebook(String header, String url, String subject){
    print("THE URLLL");
    print(url);
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        maintainState: true,
        builder: (c)=>Scaffold(
          appBar: AppBar(
            title: Text(subject),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.launch),onPressed: ()=>gradebookWebview(header,baseURL+url, "Gradebook"),)
            ],
          ),
          body: FutureBuilder(
            future: http.get(baseURL+url, headers: {"cookie":header}),
            builder: (c,s){
              try {
               
              if(s.connectionState!=ConnectionState.done){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(child: ColorLoader3(),),
                    Text("Loading your "+subject+" class", textAlign: TextAlign.center,)
                  ],
                );
              }else{
                List<Map> theAssignmentsF = formatGradebook(s);
                return ListView.separated(
                  padding: EdgeInsets.all(25),
                  itemCount: theAssignmentsF.length,
                  separatorBuilder: (c,i)=>Container(height: 30,),
                  itemBuilder: (c,i)=>RaisedButton(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    onPressed: (){},
                    elevation: 15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(theAssignmentsF[i]['name'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Text(theAssignmentsF[i]['points'], style: TextStyle(fontSize: 21, fontWeight: FontWeight.normal),),

                        ],),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(theAssignmentsF[i]['category'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.grey[700]),),
                            Row(children: <Widget>[
                              theAssignmentsF[i]['extraCredit']?FloatingActionButton(backgroundColor: Constants.baseColor,onPressed: (){}, tooltip: "Extra Credit!", child: Icon(MdiIcons.thumbUpOutline),mini: true,):Container(),
                              !theAssignmentsF[i]['graded']?FloatingActionButton(backgroundColor: Colors.cyanAccent,onPressed: (){}, tooltip: "Not graded yet", child: Text("-", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),mini: true,):Container(),
                              theAssignmentsF[i]['ace']?FloatingActionButton(backgroundColor: Color.fromRGBO(255,215,0, 1),onPressed: (){}, tooltip: "100%", child: Icon(MdiIcons.starOutline),mini: true,):Container(),
                              theAssignmentsF[i]['missing']?FloatingActionButton(backgroundColor: Colors.redAccent[400],onPressed: (){},tooltip: "Missing",child: Icon(MdiIcons.alertCircleOutline),mini: true,):Container(),
                            ],)

                        ],),
                      ],
                    ),
                  ),
                );
              }
              } catch (e) {
                try {
                  scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.redAccent[400],
                    action: SnackBarAction(label: "OK",onPressed: ()=>scaffoldKey.currentState.hideCurrentSnackBar(),textColor: Colors.white,),
                    content: Text("Sorry, we can't log you in right now."),
                  )
                  );
                } catch (e) {
                }
                              
               return loginPage();
              }
            }
            ,
          ),
        )
      )
    );
  }

  List<Map> formatGradebook(AsyncSnapshot s) {
    dom.Document theDoc = parse(s.data.body);
    dom.Element theGradebook = theDoc.getElementById("assignment_list");
    List<dom.Element> theAssignments = theGradebook.children.last.children;
    List<Map> theAssignmentsF = [];
    for (dom.Element item in theAssignments) {
      Map theMap = new Map();
      theMap['category'] = item.children.first.text;
      theMap['name'] = item.children[1].children.first.text.toString();
      theMap['points'] = item.children[2].text.trim().split("\n").join(" ");
      bool ace = false;
      try {
        ace = theMap['points'].toString().split("/").first.trim()==theMap['points'].toString().split("/").last.trim();
      } catch (e) {
        ace = false;
      }
      theMap['ace'] = ace;
      bool extraCredit = false;
      try {
        extraCredit = theMap['points'].toString().split("/").last.trim()=="-";
      } catch (e) {
        extraCredit = false;
      }
      theMap['extraCredit'] = extraCredit;
      bool graded = true;
      try {
        graded = theMap['points'].toString().split("/").first.trim()!="-";
      } catch (e) {
        graded = true;
      }
      theMap['graded'] = graded;
      theMap['missing'] = item.children[2].text.trim()=="Missing";
      if(theMap['missing']){
        theMap['ace']=false;
      }
      theMap['grade'] = item.children[3].text.trim();
      theMap['due'] = item.children[5].text.trim();
      theAssignmentsF.add(theMap);
    }
    return theAssignmentsF;
  }
      
  classListBuilder(String header) async{
    try {
      Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          maintainState: true,
          builder: (c)=>Scaffold(
            appBar: AppBar(
              title: Text("Classes"),
            ),
          )
        )
      );
    } catch (e) {
      Navigator.of(context).pop();
    }
    
  }

  attendanceBuilder(String header) async{
      Widget attendanceBody = FutureBuilder(
        future: http.get(baseURL+"/attendance/summary", headers: {"cookie":header}),
        builder: (c,s){
          if(s.hasError){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("There was an error connecting"),
                Text("("+s.error.toString()+")")
              ],
            );
          }
          if(s.connectionState!=ConnectionState.done){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(child: ColorLoader3(),),
                Text("Loading your attendance")
              ],
            );
          }else{
            try {
              dom.Document attendanceDoc = parse(s.data.body);
              List<dom.Element> recordsUnF = attendanceDoc.getElementsByClassName("table").first.children.last.children;
              List<Map> format = [];
              dom.Element totals = recordsUnF.removeLast();
              for (dom.Element recordsUnF in recordsUnF) {
                Map newMap = new Map();
                try {
                  newMap['category'] = recordsUnF.children.first.text.trim();
                  Color categoryColor = Colors.grey;
                  switch (newMap['category']) {
                    case "On Time":
                      print("On Time");
                      categoryColor = Colors.greenAccent[400];
                      break;
                    case "Tardy":
                      categoryColor = Colors.orange;
                      print("Tardy");
                      break;
                    //FFD76B
                    case "Excused":
                      categoryColor = Colors.yellowAccent[400];
                      print("Excused");

                      break;
                    case "Unexcused":
                      categoryColor = Colors.redAccent[400];
                      print("Unexcused");
                      break;
                    default:
                  }
                  newMap['color'] = categoryColor;
                  newMap['totalAD'] = double.parse(recordsUnF.children[1].text.trim());
                  newMap['percentAD'] = recordsUnF.children[2].text.trim();
                  newMap['totalC'] = double.parse(recordsUnF.children[3].text.trim());
                  newMap['percentC'] = recordsUnF.children[4].text.trim();
                  if(newMap['category']=="On Time"||newMap['category']=="Tardy"||newMap['category']=="Excused"||newMap['category']=="Unexcused"){
                    format.add(newMap);
                  }
                } catch (e) {
                }
              }
              List<CircularSegmentEntry> segmentsAllDay = [];
              List<CircularSegmentEntry> segmentsClasses = [];

              for (Map item in format) {
                segmentsAllDay.add(CircularSegmentEntry(item['totalAD'], item['color']));
                segmentsClasses.add(CircularSegmentEntry(item['totalC'], item['color']));

              }
              
               return ListView(
                 padding: EdgeInsets.all(25),
                 children: <Widget>[
                   RaisedButton(
                     color: Colors.white,
                     onPressed: (){},
                     elevation: 15,
                     padding: EdgeInsets.all(10),
                     child: Column(
                       
                       children: <Widget>[
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           
                           children: <Widget>[
                             Text("Attendance Chart:", style: TextStyle(fontSize: 22)),
                             IconButton(
                               icon: Icon(MdiIcons.informationOutline),
                               onPressed: ()=>showCupertinoModalPopup(
                                 context: context,
                                 builder: (c)=>CupertinoAlertDialog(
                                   title: Text("Legend"),
                                   content: RichText(
                                     text: TextSpan(
                                       style: TextStyle(color: Colors.black, fontSize: 22),
                                       children: [
                                         TextSpan(text: "Green", style: TextStyle(fontWeight: FontWeight.bold, decorationColor: Colors.greenAccent[400], decoration: TextDecoration.underline, decorationThickness: 2.0)),
                                         TextSpan(text: ": On Time\n"),
                                         TextSpan(text: "Orange", style: TextStyle(fontWeight: FontWeight.bold, decorationColor: Colors.orange, decoration: TextDecoration.underline, decorationThickness: 2.0)),
                                         TextSpan(text: ": Tardy\n"),
                                         TextSpan(text: "Yellow", style: TextStyle(fontWeight: FontWeight.bold, decorationColor: Colors.yellowAccent[400], decoration: TextDecoration.underline, decorationThickness: 2.0)),
                                         TextSpan(text: ": Excused\n"),
                                         TextSpan(text: "Red", style: TextStyle(fontWeight: FontWeight.bold, decorationColor: Colors.redAccent[400], decoration: TextDecoration.underline, decorationThickness: 2.0), ),
                                         TextSpan(text: ": Unexcused"),
                                         
                                       ]
                                     ),
                                   ),
                                   actions: <Widget>[
                                     CupertinoDialogAction(
                                       child: Text("Ok"),
                                       onPressed: ()=>Navigator.of(context).pop()
                                     )
                                   ],
                                 )
                               ),
                               )
                           ],
                         ),
                         Divider(color: Colors.black,),
                         AnimatedCircularChart(
                           edgeStyle: SegmentEdgeStyle.round,
                           size: Size(MediaQuery.of(context).size.width-70,MediaQuery.of(context).size.width-70),
                           holeLabel: format[0]['percentC'].toString().trim().split("%").first.replaceAll("\n", "")+"% On Time",
                           labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                           initialChartData: [
                             CircularStackEntry(
                               segmentsAllDay,
                               
                             ),
                             CircularStackEntry(
                               segmentsClasses,
                             )
                           ],
                         ),
                       ],
                     )
                   ),
                   Container(height: 30),
                   RaisedButton(
                     color: Colors.white,
                     onPressed: (){},
                     elevation: 15,
                     padding: EdgeInsets.all(10),
                     child: Column(
                       children: <Widget>[
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: <Widget>[
                           Text("Raw Data:",style: TextStyle(fontSize: 22)),
                           
                         ],),
                         Divider(color: Colors.black,),
                         attendanceRawDataRowMaker(format[0]),
                         Divider(),
                         attendanceRawDataRowMaker(format[1]),
                         Divider(),
                         Text("Absences", style: TextStyle(fontWeight: FontWeight.bold)),
                         Divider(),
                         attendanceRawDataRowMaker(format[2]),
                         Divider(),
                         attendanceRawDataRowMaker(format[3]),
                         Divider()
                       ],
                     ),
                   )
                 ],
               );
            } catch (e) {
              return Center(child: Text("Sorry, we couldn't proccess your attendance records"));
            }
          }
        },
      );        
    
    try {
      Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          maintainState: true,
          builder: (c)=>Scaffold(
            appBar: AppBar(title: Text("Attendance"),actions: <Widget>[
              IconButton(icon: Icon(MdiIcons.launch),onPressed: ()=>gradebookWebview(header,baseURL+"/attendance/summary", "Attendance"),),
              
            ],),
            body: attendanceBody
          )
        )
      );
    } catch (e) {

      Navigator.of(context).pop();
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Sorry, there was an error proccessing your request"),
          action: SnackBarAction(label: "Ok", onPressed: ()=>scaffoldKey.currentState.hideCurrentSnackBar()),
        )
      );
    }
  }

  Row attendanceRawDataRowMaker(Map format) {
    return Row(children: <Widget>[
                         Text(format['category'].toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                         VerticalDivider(),
                         Text(format['totalC'].toInt().toString()+" Times"),
                         VerticalDivider(),
                         Text(format['percentC'].toString().split("%").first.trim()+"% of the time"),
                       ],);
  }
}
  
Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
  return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
}