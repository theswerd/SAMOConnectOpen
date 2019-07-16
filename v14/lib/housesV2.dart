import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:flutter/services.dart';
import 'color_loader_3.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';

class HouseViewV2 extends StatefulWidget {
HouseViewV2({this.House});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String House;

  @override
  _HouseViewV2State createState() => _HouseViewV2State();
}

class _HouseViewV2State extends State<HouseViewV2> with TickerProviderStateMixin{
  TabController theTabController;

  IconButton shareButton = IconButton(
    icon: Icon(Icons.share),
    splashColor: Colors.yellowAccent,
    onPressed: (){
      Share.share("Wondering who your house principal is? See your on SAMO Connect -- https://samoconnect.page.link/SamoConnect");
    },
  );
  @override
  void initState() { 
    super.initState();
    theTabController = new TabController(vsync: this, length: 2);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigoAccent[700],
        title: Text(widget.House+" House"),
        actions: <Widget>[
          shareButton,
          IconButton(
            icon:Icon(Icons.info_outline),
            splashColor: Colors.yellow,
            onPressed: (){
              showModalBottomSheet(
                context: context,
                builder: (c){
                  return CupertinoActionSheet(
                    actions: <Widget>[
                      CupertinoActionSheetAction(
                        child: Text("Official Website"),
                        onPressed: (){
                          launch("http://www.samohi.smmusd.org/houses/"+widget.House+"house.html");
                        },
                      ),
                      CupertinoActionSheetAction(
                        child: Text("Give us a good review?"),
                        onPressed: (){
                         LaunchReview.launch(
                          iOSAppId: "1465501734",
                          androidAppId: "com.swerd.SamoConnect"
                        );
                          //launch("http://www.samohi.smmusd.org/houses/"+widget.House+"house.html");
                        },
                      )
                    ],
                  );
                }
              );
            },
          )
        ],
      ),
      body: FutureBuilder(
        future:get("http://www.samohi.smmusd.org/houses/"+widget.House+"house.html"),
        builder: (c,s){
          if(s.hasError){
              return Center(child: Text("Network Handshake Failure"),);
            }else if(s.connectionState!=ConnectionState.done){
              return Center(child: ColorLoader3(),);
            }else{
              Response response = s.data;
              dom.Document document =parse(response.body);
              List<dom.Element> listOfBase = document.body.children.first.children.first.children.first.children; //This list is the horizontal list of everything on screen
              List<dom.Element> listBelowHeader;
              try {
                listBelowHeader =  listOfBase[4].children.first.children.first.children.first.children;
              } catch (e) {
              }
              
              Widget teacher = makeTeacherList(listBelowHeader,context);
              Widget admin = makeAdminList(listBelowHeader,context);
              return Scaffold(
                body: TabBarView(
                  controller: theTabController,
                  children: <Widget>[
                    teacher,
                    admin
                  ],
                ),
                appBar: TabBar(
                  controller: theTabController,
                  indicatorColor: Colors.indigoAccent[700],
                  indicatorSize: TabBarIndicatorSize.tab,
                  
                  // labelStyle: TextStyle(color: Colors.black),
                  // unselectedLabelStyle: TextStyle(color: Colors.black),
                  tabs: <Widget>[
                    Tab(
                      
                      //icon: Icon(Icons.school,color: Colors.black,),
                      child: Text("Teachers",style: TextStyle(color: Colors.black),),
                      //text: "Teachers",
                      
                    ),
                    Tab(
                      child: Text("Administrators",style: TextStyle(color: Colors.black),),
                    )
                  ],
                )
              );
              //admin;
            }
          
        },
      ),
    );
  }
}

Widget makeTeacherList(List<dom.Element> fullList, BuildContext context) {
  List<dom.Element> listOfTeachersUnformatted = [];
  try {
    listOfTeachersUnformatted =(fullList[3].children[1].children.first.children.first.children.last.children.first.children.first.children.first.children);
    listOfTeachersUnformatted.addAll(fullList[3].children[1].children.first.children.first.children.last.children.last.children.first.children.first.children);
    //return Center(child: Text(listOfTeachersUnformatted.toString()),);

  } catch (e) {
        return Center(child: Text("Unable to compile teacher data"),);

  }
  List<dom.Element> listOfTeachersCleaned = [];
  try {
    for (dom.Element item in listOfTeachersUnformatted) {
      if(item.text.trim().isNotEmpty){//STOPS AN ERROR IN H HOUSE
        listOfTeachersCleaned.add(item);
      }
    }
  } catch (e) {
    return Center(child: Text("Unable to clean teacher data"),);

  }
  List<String> listOfTeachersFormat1 = [];
  try {
    for (var item in listOfTeachersCleaned) {
      print("ITE<<<");
      try {
        //print(item.children[0].text.trim());
        listOfTeachersFormat1.add(item.children[0].text.trim());
      } catch (e) {
      }
    }
  } catch (e) {
    return Center(child: Text("Unable to format teacher data"),);

  }
  List listODepartments = new List();

  List listOfTeachersFormat2 = [];
  try {
    Map<String,Map> mapOfData = new Map<String,Map>();
    String department;
//mapOfData["fish"] ={"money":",machine"};
    List individualDepList = [];
    for (int i = 0; i < listOfTeachersFormat1.length; i++) {
      String item = listOfTeachersFormat1[i].trim();
      if (i == 0) {
        department = item;
        
      }else if(i == listOfTeachersFormat1.length-1){
        listODepartments.add({"data":individualDepList, "dep":department});

      }else{
        if(item.contains(", ")){
          try {
            Map teacherMap = new Map();
            print("baseItem:::");
            print(item);
            List splitItem = item.split(",");
            String name = "";
            try {
              name =splitItem[0].toString().trim();
              if(name.contains('(')){
                name = name.split("(")[0];
              }
            } catch (e) {
            }
            String room = "";
            try {
              room =splitItem[1].toString().trim();
            } catch (e) {
            }

            String extension = "";
            try {
              String bX = splitItem[2]; //BaseExtension But i cant type that much everytimes
              if(bX.toLowerCase().contains("x")){
                extension =bX;
              }else{
                extension = "x"+bX.trim();
              }


            } catch (e) {
            }

            String email = "";
            try {
              email =splitItem.last.toString().trim();
            } catch (e) {
            }
            
            teacherMap["name"]= name;
            teacherMap["email"] = email;
            teacherMap["extension"] = extension;
            teacherMap["room"]= room;
            individualDepList.add(teacherMap);
          } catch (e) {
          }
          
          //mapOfData【
        }else{
          listODepartments.add({"data":individualDepList, "dep":department});
        individualDepList = [];

         department = item;
        }
      }
      print("DATA MAP V1");
      print(listODepartments);
    }
  } catch (e) {
    return Center(child: Text("Unable to finish formatting teacher data"),);

  }
  
  return ListView.separated(
    itemCount: listODepartments.length,
    separatorBuilder: (c,i)=>Container(height: 20,),
    itemBuilder: (c,i){
      Map currentItem = listODepartments[i];
      print("deps::");
      //String t;
      //t.isEmpty
      print(currentItem["dep"].isEmpty);
      print(currentItem["dep"]);
      String currentDep =currentItem["dep"];
      List teachersInDep =currentItem["data"];
      double testAmount =125;
      if(currentItem["dep"].isNotEmpty){
      return Container(
        //width: MediaQuery.of(context).size.width*.8,
        padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*.08),
        height: (listODepartments[i]["data"].length*testAmount+50).toDouble(),
        child: RaisedButton(
          elevation: 15,
          color: Colors.white,
          onPressed: (){},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal:10),
            child: Column(
              children: <Widget>[
                Text(currentDep,style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                Container(
                  height: (testAmount*listODepartments[i]["data"].length).toDouble(),
                  padding: EdgeInsets.symmetric(vertical:0,horizontal: 5),
                  child: ListView.separated(
                    itemCount: teachersInDep.length,
                    separatorBuilder: (c,i)=>Container(height: 10,),
                    itemBuilder: (c,i){
                      Map currentItem =teachersInDep[i];
                      return Card(
                        elevation: 15,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Text(currentItem["name"],style: TextStyle(color: Colors.black,fontSize: 20),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(currentItem["room"],style: TextStyle(color: Colors.grey[700],fontSize: 18),),
                                  Text(currentItem["extension"],style: TextStyle(color: Colors.grey[700],fontSize: 18))
                                ],),
                              Container(child:CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: Text(currentItem["email"],style: TextStyle(fontSize: 18),),
                                onPressed: (){
                                  Clipboard.setData(ClipboardData(text: currentItem["email"]));
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (c){
                                      return CupertinoAlertDialog(
                                        title: Text("Copied!"),
                                        content: Text(currentItem["name"].trim()+"'s email has been copied to your clipboard."),
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
                              ),
                              alignment: Alignment.centerLeft,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
      }else{
        return Container(height: 0,);
      }
    },
  );
}


Widget makeAdminList(List<dom.Element> fullList,BuildContext context) {
  List<dom.Element> listOfadminUnformatted = [];
  try {
    listOfadminUnformatted =fullList[2].children[1].children.first.children.first.children.first.children; //THE ROW INCLUDING THE IMAGE AND SPACERS
  } catch (e) {
    print("ERROR GATHERING DATA -- 1");
    print(e);
    return Center(child: Text("Unable to gather admin data"),);
  }

  List<dom.Element> listOfadminFormat1 = [];
  try {
    for (dom.Element item in listOfadminUnformatted) {
      if(item.text.trim()!=""){
        
        listOfadminFormat1.add(item);
     }
    }
  } catch (e) {
    print("ERROR GATHERING DATA -- 2");
    print(e);
    return Center(child: Text("Unable to format admin data"),);
     
  }


  List<List<dom.Element>> listOfadminFormat2 = []; //THIS IS A LIST OF GROUPINGS WITH TEXT;
  try {
    
    for (dom.Element grouping in listOfadminFormat1) {
      List<dom.Element> groupEntities = grouping.children.first.children.first.children.first.children.first.children.first.children.first.children;
      List<dom.Element> onlyTextEntities = [];
      for (dom.Element item in groupEntities) { //THIS TAKES OUT ANYTHING WITHOUT TEXT
        if(item.text.trim().isNotEmpty){
          onlyTextEntities.add(item);
        }
      }
      //print(onlyTextEntities);
      listOfadminFormat2.add(onlyTextEntities);
    }

  } catch (e) {
    print("ERROR GATHERING DATA -- 3");
    print(e);
    return Center(child: Text("Unable to compile admin data"),);
  }
  
  List listOfAdminFinalFormat = []; //THIS IS THE FINAL FORMAT HOPEFULLY
  try {
    print("\n\n\n");
    print("Permutation 3");
    //print(listOfadminFormat2);
    
    Widget principal = makePrincipalView(listOfadminFormat2[0],context);
    Widget assistant = makeAssistantView(listOfadminFormat2[0], context);
    Widget advisor1 = makeAdvisorView(listOfadminFormat2[1], context,0);
    Widget advisor2 = makeAdvisorView(listOfadminFormat2[1], context,1);

    listOfAdminFinalFormat.add(principal);
    listOfAdminFinalFormat.add(assistant);
    listOfAdminFinalFormat.add(advisor1);
    listOfAdminFinalFormat.add(advisor2);

    
  } catch (e) {
    print("ERROR GATHERING DATA -- 3");
    print(e);
    return Center(child: Text("Unable to compile admin data"),);
  }


  
  
  return ListView.separated(
    padding: EdgeInsets.all(10),
    itemCount: listOfAdminFinalFormat.length,
    separatorBuilder: (c,i)=>Container(height: 20,),
    itemBuilder: (c,i){
      return listOfAdminFinalFormat[i];
    },
  );
}

Widget makePrincipalView(List<dom.Element> unformattedElements,BuildContext context) {
  try {
    for (dom.Element item in unformattedElements) {
      //print(item.text.trim());
    }

    String title = "";
    try {
      title = unformattedElements[0].text.trim();
    } catch (e) {
    }

    String name = "";
    try {
      name = unformattedElements[1].text.trim();
    } catch (e) {
    }

    String room = "";
    String extension = "";
    String email = "";

    try {
      List dataOnThem =unformattedElements[2].text.trim().split(", ");
      room =dataOnThem[0];
      extension = dataOnThem[1];
      email = dataOnThem[2];

    } catch (e) {
    }

    return Container(
      //height: 300,
      //maxHeight: 300,
      width: MediaQuery.of(context).size.width*.9,
      child: Card(
        elevation: 15,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(name,style: TextStyle(color: Colors.black,fontSize: 22)),
                  Text(title,style: TextStyle(color: Colors.grey[700],fontSize: 18),),
                ],
              ),
              Container(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(extension,style: TextStyle(color: Colors.grey[700],fontSize: 18),),
                  Text(room, style: TextStyle(color: Colors.black,fontSize: 20))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CupertinoButton(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(email,style: TextStyle(fontSize: 20)),
                    onPressed: (){
                      Clipboard.setData(ClipboardData(text:email));
                      showCupertinoModalPopup(
                        context: context,
                        builder: (c){
                          return CupertinoAlertDialog(
                            title: Text("Copied"),
                            content: Text(name+"'s email has been copied to your clipboard"),
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
              ],)
            ],
          ),
        ),
      ),
    );
  } catch (e) {
    return Container(height: 0,);
  }
}


Widget makeAssistantView(List<dom.Element> unformattedElements,BuildContext context) {
  try {
    for (dom.Element item in unformattedElements) {
      //print(item.text.trim());
    }

    String title = "";
    try {
      title = unformattedElements[3].text.trim();
    } catch (e) {
    }

    String name = "";
    try {
      name = unformattedElements[4].text.trim();
      if(name.contains(",")){
        name = name.split(",")[0];
      }
    } catch (e) {
    }

    String room = "";
    String extension = "";
    String email = "";

    try {
      List dataOnThem =unformattedElements[5].text.trim().split(", ");
      room =dataOnThem[0];
      extension = dataOnThem[1];
      email = dataOnThem[2];

    } catch (e) {
    }

    return Container(
      //height: 300,
      //maxHeight: 300,
      width: MediaQuery.of(context).size.width*.9,
      child: Card(
        elevation: 15,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(name,style: TextStyle(color: Colors.black,fontSize: 22)),
                  Text(title,style: TextStyle(color: Colors.grey[700],fontSize: 18),),
                ],
              ),
              Container(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(extension,style: TextStyle(color: Colors.grey[700],fontSize: 18),),
                  Text(room, style: TextStyle(color: Colors.black,fontSize: 20))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CupertinoButton(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(email,style: TextStyle(fontSize: 20)),
                    onPressed: (){
                      Clipboard.setData(ClipboardData(text:email));
                      showCupertinoModalPopup(
                        context: context,
                        builder: (c){
                          return CupertinoAlertDialog(
                            title: Text("Copied"),
                            content: Text(name+"'s email has been copied to your clipboard"),
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
              ],)
            ],
          ),
        ),
      ),
    );
  } catch (e) {
    return Container(height: 0,);
  }
}


//Base index lets me put both advisors in one section
Widget makeAdvisorView(List<dom.Element> unformattedElements,BuildContext context, int baseIndex){
  try {
    unformattedElements.removeAt(0);

    String title = "Advisor";
    
    String name = "";
    try {
      name = unformattedElements[baseIndex].text.trim();
    } catch (e) {
    }

    String room = "";
    String extension = "";
    String email = "";

    try {
      List dataOnThem =unformattedElements[baseIndex+1].text.trim().split(", ");
      room =dataOnThem[0];
      extension = dataOnThem[1];
      email = dataOnThem[2];

    } catch (e) {
    }

    return Container(
      //height: 300,
      //maxHeight: 300,
      width: MediaQuery.of(context).size.width*.9,
      child: Card(
        elevation: 15,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(name,style: TextStyle(color: Colors.black,fontSize: 22)),
                  Text(title,style: TextStyle(color: Colors.grey[700],fontSize: 18),),
                ],
              ),
              Container(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(extension,style: TextStyle(color: Colors.grey[700],fontSize: 18),),
                  Text(room, style: TextStyle(color: Colors.black,fontSize: 20))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CupertinoButton(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(email,style: TextStyle(fontSize: 20),),
                    onPressed: (){
                      Clipboard.setData(ClipboardData(text:email));
                      showCupertinoModalPopup(
                        context: context,
                        builder: (c){
                          return CupertinoAlertDialog(
                            title: Text("Copied"),
                            content: Text(name+"'s email has been copied to your clipboard"),
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
              ],)
            ],
          ),
        ),
      ),
    );
  } catch (e) {
    return Container(height: 0,);
  }

}