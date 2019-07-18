import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';

import 'package:url_launcher/url_launcher.dart';
import 'color_loader_3.dart';
class houseView extends StatefulWidget {

  static String tag = "HouseView";
  String house;

  houseView(this.house,);

  @override
  _houseViewState createState() => _houseViewState(house);
}

class _houseViewState extends State<houseView>
    with SingleTickerProviderStateMixin {
    String house;


  _houseViewState(this.house);
  TabController teachersAndAdmin;
  @override
  void initState() { 
    super.initState();
    teachersAndAdmin = TabController(
      vsync: this,
      length: 2
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(MdiIcons.informationOutline),
            splashColor: Colors.yellowAccent,
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
                          launch("http://www.samohi.smmusd.org/houses/"+house+"house.html");
                        },
                      )
                    ],
                  );
                  
                }
              );
            },
          )
        ],
        backgroundColor: Colors.indigoAccent[700],
        title: Text(house + " House"),
        
      ),
      body: FutureBuilder(
        future:http.get("http://www.samohi.smmusd.org/houses/"+house+"house.html"),
        builder: (c,s){
          if(s.hasError){
            return Center(child: Text("Handshake Failure",style: TextStyle(color: Colors.black,fontSize: 20),),);
          }
          if(s.connectionState!=ConnectionState.done){
            return Center(child: ColorLoader3(),);
          }else{
            http.Response response = s.data;
            dom.Document doc = parse(response.body);

            List<dom.Element> overallbody = doc.body.children[0].children[0].children[0].children[4].children[0].children[0].children[0].children;

            //List<dom.Element> teachers = overallbody[3].children[1].children[0].children[0].children[1].children;
            List<dom.Element> teachers = overallbody[3].children[1].children[0].children[0].children.last.children;
            //List<dom.Element> teachers = overallbody[3].children[1].children[0].children[0].children.last.children;

            teachers.removeAt(1);

            List<dom.Element> admin = overallbody[2].children[1].children[0].children[0].children[0].children;
            // admin.removeAt(5);
            // admin.removeAt(3);
            // admin.removeAt(1);
            // admin.removeAt(0);
            print("It got hereeee");
            admin.remove(4);
            admin.remove(2);
            admin.remove(0);
            //List admin = [];
            //print("OUTSIDE TEACHERS");
            //print(teachers.length);
           //List<dom.Element> teachers = overallbody[3].children[1].children[0].children[0].children.last.children;

            List<dom.Element> allTeachers = teachers[0].children[0].children[0].children+teachers[1].children[0].children[0].children;
            //String currentDepartment = "";
            print("OK WIERD THEIRYY");
            print(allTeachers);
            List<List> teachersAndDep = [];
            for (var item in allTeachers) { 
              try {
                if(item.text.contains("@smmusd")){
                //print("TEACHER");
                teachersAndDep.add(item.text.trim().split("\n"));      
              }else{
                //print("DEPARTMENT");  
                //print(item.text.trim().split('\n'));
                teachersAndDep.add(item.text.trim().split('\n'));
              }
              } catch (e) {
              }
              
            }
            
            String department = teachersAndDep[0][0];
            print(department);
            //print("PHASE 2");
            var departmentsMap = new Map();
            List departmentList = [];
            for (var item in teachersAndDep) {

              //print(item[0].toString().split(','));
              //print(item[0].toString().split(',').length);

              if(item[0].toString().split(',').length==1){
                print("DEPARTMENT");

                department = item[0];
                //departmentList.clear();
                departmentList = [];
              }else{
                //print("Teacher");
                departmentList.add( item[0].toString().split(','));
               //List listforAdding = departmentsMap[department]+();
                departmentsMap[department] = departmentList;
              }

            }
           
            Widget departmentslistView = ListView.separated(
              itemCount: departmentsMap.keys.length,
              separatorBuilder: (c,i){
                return Container(height: 30,);
              },
              itemBuilder: (c,i){
                return Container(
                  padding: EdgeInsets.symmetric(horizontal:20),
                  child: 
                RaisedButton(
                  padding: EdgeInsets.all(20),
                  onPressed: (){},
                  elevation: 10,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Text(departmentsMap.keys.toList()[i],style: TextStyle(color: Colors.black,fontSize: 20),),
                      Container(height: 20),
                      teacherListView(departmentsMap[departmentsMap.keys.toList()[i]])
                    ],
                  ),
                ),);
              }
              );
            
            List totalAdminData = [];
            //COLLECTS ALL ADMIN
            for (var item in admin) {
              print("NEW ITEM");
              //List allItems = (item.children[0].children[0].children[0].children[0]);
              List allItems = (item.children[0].children[0].children[0].children[0].children[0].children[0].children);
              //CLEANING EACH
              //List allItems = [];
              for (int i = 0; i < allItems.length; i++) {
                dom.Element uncompiled = allItems[i];
                if(uncompiled.text.trim()==""){
                  //print("EMPTY");
                 allItems.removeAt(i);
                }
              }
              List<String> adminList = [];
              //REMOVE EXTRA SPACES
              for (int j = 0; j < allItems.length; j++) {
                dom.Element item = allItems[j];
               // print(item.text.trim());
                adminList.add(item.text.trim());
              }
              List principal = [];
              List assistant = [];
              print("\n\n");
              print('');
              print("IT MADE IT HERE!!!!!");
              for (int k = 0; k < adminList.length; k++) {
                String adminPart = adminList[k];
                //print("ADMIN PART");
                //print(adminPart);
                if(k<4){
                  principal.add(adminPart);
                }else if(k<8){
                  assistant.add(adminPart);
                }
               totalAdminData.add(adminPart);   
              }
            }
            //ALL ADMIN DATA HERE
            print("TOTAL ADMIN DATA");
            print(totalAdminData);
            Map principal = new Map();
            principal["name"] = totalAdminData[1];
            principal["ext"] =totalAdminData[2].toString().split(',')[1].trim();
            principal["room"] =totalAdminData[2].toString().split(',')[0].trim();
            principal["email"] =totalAdminData[2].toString().split(',')[2].trim();

            Map assistant = new Map();
            assistant["name"] =totalAdminData[4].toString().split(',')[0];
            assistant["ext"] =totalAdminData[5].toString().split(',')[1].trim();
            assistant["room"] =totalAdminData[5].toString().split(',')[0].trim();
            assistant["email"] =totalAdminData[5].toString().split(',')[2].trim();

            Map counselor1 = new Map();
            counselor1["name"] =totalAdminData[7].toString();
            counselor1["ext"] =totalAdminData[8].toString().split(',')[1].trim();
            counselor1["room"] =totalAdminData[8].toString().split(',')[0].trim();
            counselor1["email"] =totalAdminData[8].toString().split(',')[2].trim();

            Map counselor2 = new Map();
            counselor2["name"] =totalAdminData[9].toString();
            counselor2["ext"] =totalAdminData[10].toString().split(',')[1].trim();
            counselor2["room"] =totalAdminData[10].toString().split(',')[0].trim();
            counselor2["email"] =totalAdminData[10].toString().split(',')[2].trim();

            
            print(counselor2);
            Widget adminView = ListView(children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal:30,vertical: 10),
                child: RaisedButton(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  onPressed: (){

                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text("Principal",style: TextStyle(color: Colors.grey[700],fontSize: 18),)
                        ],
                      ),
                      Container(height: 10,),
                      Row(children: <Widget>[
                        Text(principal["name"],style: TextStyle(color: Colors.black,fontSize: 18),),
                        Expanded(child: Container(),),
                        Text(principal["ext"],style: TextStyle(color: Colors.black,fontSize: 17),),
                        
                      ],),
                      Container(height: 5),
                      Row(children: <Widget>[
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Text(principal["email"].trim(),style: TextStyle(color: Colors.blue,fontSize: 16),),
                          onPressed: (){
                            Clipboard.setData(ClipboardData(text: principal["email"]));
                            showCupertinoDialog(
                              context: context,
                              builder: (c){
                                return CupertinoAlertDialog(
                                  title: Text(principal["name"]+"'s email has been copied to your clipboard"),
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
                        Expanded(child: Container(),),
                        Text(principal["room"],style: TextStyle(color: Colors.grey[800],fontSize: 16),)
                        
                      ],)
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal:30),
                child: RaisedButton(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  onPressed: (){

                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text("Assistant",style: TextStyle(color: Colors.grey[700],fontSize: 18),)
                        ],
                      ),
                      Container(height: 10,),
                      Row(children: <Widget>[
                        Text(assistant["name"],style: TextStyle(color: Colors.black,fontSize: 18),),
                        Expanded(child: Container(),),
                        Text(assistant["ext"],style: TextStyle(color: Colors.black,fontSize: 17),),
                        
                      ],),
                      Container(height: 5),
                      Row(children: <Widget>[
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Text(assistant["email"].trim(),style: TextStyle(color: Colors.blue,fontSize: 16),),
                          onPressed: (){
                            Clipboard.setData(ClipboardData(text: assistant["email"]));
                            showCupertinoDialog(
                              context: context,
                              builder: (c){
                                return CupertinoAlertDialog(
                                  title: Text(assistant["name"]+"'s email has been copied to your clipboard"),
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
                        Expanded(child: Container(),),
                        Text(assistant["room"],style: TextStyle(color: Colors.grey[800],fontSize: 16),)
                        
                      ],)
                    ],
                  ),
                ),
              ),
              Container(
                padding:  EdgeInsets.symmetric(horizontal:30,vertical: 10),
                child: RaisedButton(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  onPressed: (){

                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text("Counselor",style: TextStyle(color: Colors.grey[700],fontSize: 18),)
                        ],
                      ),
                      Container(height: 10,),
                      Row(children: <Widget>[
                        Text(counselor1["name"],style: TextStyle(color: Colors.black,fontSize: 18),),
                        Expanded(child: Container(),),
                        Text(counselor1["ext"],style: TextStyle(color: Colors.black,fontSize: 17),),
                        
                      ],),
                      Container(height: 5),
                      Row(children: <Widget>[
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Text(counselor1["email"].trim(),style: TextStyle(color: Colors.blue,fontSize: 16),),
                          onPressed: (){
                            Clipboard.setData(ClipboardData(text: counselor1["email"]));
                            showCupertinoDialog(
                              context: context,
                              builder: (c){
                                return CupertinoAlertDialog(
                                  title: Text(counselor1["name"]+"'s email has been copied to your clipboard"),
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
                        Expanded(child: Container(),),
                        Text(counselor1["room"],style: TextStyle(color: Colors.grey[800],fontSize: 16),)
                        
                      ],)
                    ],
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal:30),
                child: RaisedButton(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  onPressed: (){

                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text("Counselor",style: TextStyle(color: Colors.grey[700],fontSize: 18),)
                        ],
                      ),
                      Container(height: 10,),
                      Row(children: <Widget>[
                        Text(counselor2["name"],style: TextStyle(color: Colors.black,fontSize: 18),),
                        Expanded(child: Container(),),
                        Text(counselor2["ext"],style: TextStyle(color: Colors.black,fontSize: 17),),
                        
                      ],),
                      Container(height: 5),
                      Row(children: <Widget>[
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Text(counselor2["email"].trim(),style: TextStyle(color: Colors.blue,fontSize: 16),),
                          onPressed: (){
                            Clipboard.setData(ClipboardData(text: counselor2["email"]));
                            showCupertinoDialog(
                              context: context,
                              builder: (c){
                                return CupertinoAlertDialog(
                                  title: Text(counselor2["name"]+"'s email has been copied to your clipboard"),
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
                        Expanded(child: Container(),),
                        Text(assistant["room"],style: TextStyle(color: Colors.grey[800],fontSize: 16),)
                        
                      ],)
                    ],
                  ),
                ),
              ),
              
  
  
            
            ],);
            //print(principal);
            return Scaffold(
              appBar: TabBar(
                indicatorColor: Colors.indigoAccent[700],
                controller: teachersAndAdmin,
                labelColor: Colors.black,
                tabs: <Widget>[
                  Tab(
                    text: "Teachers",
                    
                  ),
                  Tab(
                    text: "Admin",
                  )
                ],
              ),
              body: TabBarView(
                controller: teachersAndAdmin,
                children: <Widget>[
                  departmentslistView,
                  adminView
                ],
              ),
            );
                 }}
          ));
          
       
    
    
   
  }

  Widget teacherListView(List teachers) {
    return Container(
      height: (teachers.length*110).toDouble(),
      child:ListView.separated(
      itemCount: teachers.length,
      separatorBuilder: (c,i){
        return Container(height: 20,);
      },
      itemBuilder: (c,i){
        while(teachers[i].length<4){
          teachers.add("");
        }
        return Container(
          child:RaisedButton(
          elevation: 10,
          color: Colors.white,
          padding: EdgeInsets.all(20),
          onPressed: (){},
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(teachers[i][0].toString().trim(),style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                  Expanded(child: Container(),),
                  Text(teachers[i][1].toString().trim(),style: TextStyle(color: Colors.grey[700],fontSize: 13,fontWeight: FontWeight.normal),),
                  ],    
                ),
                Container(height: 10,),
              Row(
                children: <Widget>[
                  Text(teachers[i][3].toString().trim(),style: TextStyle(color: Colors.blue[700],fontSize: 15,fontWeight: FontWeight.normal),),
                  Expanded(child: Container(),),
                  Text(teachers[i][2].toString().trim(),style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                  ],    
                ),  
            ],
          ),
        ));
      },
    )
    );
  }
      
}

