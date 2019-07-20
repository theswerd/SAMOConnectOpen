import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'color_loader_3.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:convert';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';



class ChecklistPage extends StatefulWidget {

  //static String splitter = " -ThisIsASplitterHopefullyNoOneWillType5632- ";
  @override
  ChecklistPageState createState() => ChecklistPageState();
}

class ChecklistPageState extends State<ChecklistPage> {
  TextEditingController controller = TextEditingController();
  List<String> todos = [];
  Widget body = Container();
  TextEditingController titleController;
  TextEditingController descriptionController;
  String currentEmoji = "";

  @override
  void initState() { 
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  
  @override
  Widget build(BuildContext context) {
      body = buildListOfTodos();
      return body;
  }

  Widget buildListOfTodos() {
     List allEmojis = <Widget>[
            makeEmojiTile("👩‍🎨"),
            makeEmojiTile("👨‍🎨"),
            makeEmojiTile("👩‍🔬"),                                            
            makeEmojiTile("👨‍🔬"),
            makeEmojiTile("👩‍🏭"),
            makeEmojiTile("👨‍🏭"),
            makeEmojiTile("👩‍🏫"),
            makeEmojiTile("👨‍🏫"),
            makeEmojiTile("👩‍🎓"),
            makeEmojiTile("👨‍🎓"),
            makeEmojiTile("👩‍⚕️"),
            makeEmojiTile("👨‍⚕️"),// 
            makeEmojiTile("⭐️"),
            makeEmojiTile("🌟"),
            makeEmojiTile("✨"),
            makeEmojiTile("⚡️"),
            makeEmojiTile("☄️"),
            makeEmojiTile("🔥"),
            makeEmojiTile("🌎"),
            makeEmojiTile("🎼"),
            makeEmojiTile("🎹"),
            makeEmojiTile("🥁"),//        
            makeEmojiTile("🎷"),
            makeEmojiTile("🎺"),
            makeEmojiTile("🎸"), 
            makeEmojiTile("🎻"),
            makeEmojiTile("✉️"),
            makeEmojiTile("✅"),
            makeEmojiTile("⁉️"),
            makeEmojiTile("🛑"),
            makeEmojiTile("🍕"),
            makeEmojiTile("🥑"),


          ];


    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: "Add to checklist",
        backgroundColor: Colors.indigoAccent[700],
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
        onPressed: (){

          int randomInt = new Random(Timestamp.now().microsecondsSinceEpoch.toInt()).nextInt(6+1);
          List options = ["Hobkirk's Homework", "Radford's Radicals", "Corrigan's Chemistry", "McKeown's Music Practice", "Sato's Sprints","Lee's Letter writing","Wang's Worksheets","Sign up for the robotics club"];
          String ex = "Sign up for the robotics club";
          try {
            setState(() {
              ex = options[randomInt];
            });
          } catch (e) {
          }

          bool hasDate = false;
          bool favorite = false;
          bool hasColor = true;
          Color currentIndexColor = Colors.black;
          int date = DateTime(2020,1,1).millisecondsSinceEpoch;
          String title = "";
          String subTitle = "";
          currentEmoji = "";

          titleController.clear();
          descriptionController.clear();
          
          List allEmojis = <Widget>[
            makeEmojiTile("👩‍🎨"),
            makeEmojiTile("👨‍🎨"),
            makeEmojiTile("👩‍🔬"),                                            
            makeEmojiTile("👨‍🔬"),
            makeEmojiTile("👩‍🏭"),
            makeEmojiTile("👨‍🏭"),
            makeEmojiTile("👩‍🏫"),
            makeEmojiTile("👨‍🏫"),
            makeEmojiTile("👩‍🎓"),
            makeEmojiTile("👨‍🎓"),
            makeEmojiTile("👩‍⚕️"),
            makeEmojiTile("👨‍⚕️"),// 
            makeEmojiTile("⭐️"),
            makeEmojiTile("🌟"),
            makeEmojiTile("✨"),
            makeEmojiTile("⚡️"),
            makeEmojiTile("☄️"),
            makeEmojiTile("🔥"),
            makeEmojiTile("🌎"),
            makeEmojiTile("🎼"),
            makeEmojiTile("🎹"),
            makeEmojiTile("🥁"),//        
            makeEmojiTile("🎷"),
            makeEmojiTile("🎺"),
            makeEmojiTile("🎸"), 
            makeEmojiTile("🎻"),
            makeEmojiTile("✉️"),
            makeEmojiTile("✅"),
            makeEmojiTile("⁉️"),
            makeEmojiTile("🛑"),
            makeEmojiTile("🍕"),
            makeEmojiTile("🥑"),


          ];
          showCupertinoModalPopup(
            context: context,
            builder: (c){
              return Center(
                child: Dialog(
                  child: Container(
                         height: 320,
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left:15.0,top: 15.0),
                                child: Row(
                                
                                  children: <Widget>[
                                  Text("Todo:",style: TextStyle(color: Colors.black,fontSize: 20))
                                ],),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:15.0),
                                child: TextField(
                                  controller: titleController,
                                  decoration: InputDecoration(
                                    hintText: ex
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:15.0,top: 15.0),
                                child: Row(
                                
                                  children: <Widget>[
                                  Text("Description:",style: TextStyle(color: Colors.black,fontSize: 20))
                                ],),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:15.0),
                                child: TextField(
                                  controller: descriptionController,
                                  decoration: InputDecoration(
                                    hintText: "This is very important"
                                  ),
                                ),
                              ),
                              Container(height: 5,),
                              
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                     // Container(width: 15,),
                                      Column(
                                        children: <Widget>[
                                          Text("Add Color:"),
                                          IconButton(
                                            icon: Tooltip(child: Icon(MdiIcons.paletteOutline),message: "Change the color",),
                                            onPressed: (){
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (c){
                                                  return Container(
                                                    height: 330,
                                                    color: Colors.white,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[
                                                            CupertinoButton(
                                                              child: Text("Nevermind"),
                                                              onPressed: (){
                                                                Navigator.of(context).pop();
                                                              },
                                                            ),
                                                            CupertinoButton(
                                                              child: Text("Set Color"),
                                                              onPressed: (){
                                                                Navigator.of(context).pop();
                                                              },
                                                            )
                                                          ],
                                                        ),
                                                        MaterialColorPicker(
                                                          selectedColor: Colors.black,
                                                          allowShades: false,
                                                          iconSelected: MdiIcons.paletteOutline,
                                                          onColorChange: (Color theColor){
                                                            currentIndexColor = theColor;
                                                          },
                                                          onMainColorChange: (Color theColor){
                                                            currentIndexColor = theColor;

                                                          },
                                                          ),
                                                      ],
                                                    ),
                                                    );
                                                }
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text("Add Date:"),
                                          IconButton(
                                            icon: Tooltip(child: Icon(MdiIcons.calendarTextOutline,size: 30,),message: "Add date and time",),
                                            onPressed: (){
                                              int currentDateTime = DateTime(2019,1,1).millisecondsSinceEpoch;
                                              //bool hasDateTimeForPush;
                                              showCupertinoModalPopup(
                                                context: context,
                                                builder: (c)=>Container(
                                                  height: 352,
                                                  color: Colors.white,
                                                  child:Column(
                                                    children: <Widget>[
                                                      Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        CupertinoButton(
                                                          child: Text("Cancel"),
                                                          onPressed: (){
                                                            Navigator.of(context).pop();
                                                            hasDate = false;
                                                          },
                                                        ),
                                                        CupertinoButton(
                                                          child: Text("Set Date"),
                                                          onPressed: (){
                                                            hasDate = true;
                                                            date = currentDateTime;
                                                            Navigator.of(context).pop();
                                                          },
                                                        ),
                                                        
                                                      ],
                                                    ),
                                                      Container(
                                                        height: 300,
                                                        child: CupertinoDatePicker(
                                                          
                                                          mode: CupertinoDatePickerMode.date,
                                                          initialDateTime: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day),
                                                          onDateTimeChanged: (DateTime newDt){
                                                            currentDateTime = newDt.millisecondsSinceEpoch;
                                                        },
                                                      ),
                                                      ),
                                                    ],
                                                  ),
                                              )
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                         // Container(height: 5,),
                                          Text("Add Emoji:"),
                                          //Container(height: 7,),
                                          IconButton(
                                            icon: Icon(MdiIcons.emoticonWinkOutline,size: 28,),
                                            onPressed: (){
                                              showEmojiPicker(allEmojis);
                                            },
                                          )
                                          
                                        ],
                                      ),
                                      
                                    ],
                                  ),
                                  
                              
                              Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:20.0,vertical: 5),
                                    child: FlatButton(
                                      padding: EdgeInsets.symmetric(vertical:22),
                                      color: Colors.indigoAccent[700],
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                                      //padding: EdgeInsets.all(5),
                                      child: Center(child: Text("Add",style: TextStyle(color: Colors.white,fontSize: 18))),
                                      onPressed: (){
                                        title = titleController.text;
                                        subTitle = descriptionController.text;
                                        if(title.contains(",")||subTitle.contains(",")){
                                          showCupertinoModalPopup(
                                          context: context,
                                          builder: (c){
                                            return CupertinoAlertDialog(
                                              title: Text("No special characters (For now)"),
                                              actions: <Widget>[CupertinoButton(
                                                child:Text("Ok"),
                                                onPressed: (){
                                                  Navigator.of(context).pop();
                                                },
                                              )],
                                            );
                                          }
                                        );
                                        }else
                                        if(title!=""){
                                        todos.add([
                                          title,
                                          subTitle,
                                          currentEmoji,
                                          hasDate,
                                          date,
                                          hasColor,
                                          currentIndexColor,
                                          
                                        ].toString());
                                        storeStringList(todos);
                                        setState(() {
                                          body = buildListOfTodos();
                                        });
                                        Navigator.of(context).pop();
                                      }else{
                                        showCupertinoModalPopup(
                                          context: context,
                                          builder: (c){
                                            return CupertinoAlertDialog(
                                              title: Text("Please fill in the title"),
                                              actions: <Widget>[CupertinoButton(
                                                child:Text("Ok"),
                                                onPressed: (){
                                                  Navigator.of(context).pop();
                                                },
                                              )],
                                            );
                                          }
                                        );
                                      }
                                      },
                                    ),
                                  )


                            ],
                          ),
                        ),
                ),
              );
                  
                
              
            }            
          );
          //storeStringList(["Fish"]);
          setState(() {
            body = buildListOfTodos();
          });
        },
      ),
      body: FutureBuilder(
        future: getStringList(),
        builder: (c,s){
          if(s.hasError){
            return Center(child: Text("Local Storage Error"),);
          }
          bool passby = true;
          try {
            passby = s.data.length==0;
          } catch (e) {
          }
          if(s.connectionState!=ConnectionState.done){
            return Container();
          }
          if(!s.hasData||passby){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                  textAlign: TextAlign.center,
                  text:TextSpan(
                    children: [
                      TextSpan(text: "Welcome to your ",style: TextStyle(color: Colors.black,fontSize: 24)),
                      TextSpan(text: "School Checklist",style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold))
                    ]
                  ) 
                ),
                Divider(height: 2,),
                Text("This can be used for anything you need, however we recommend using it for school",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey[700],fontSize: 18),),
                Divider(height: 2,),
                RichText(
                  textAlign: TextAlign.center,
                  text:TextSpan(
                    children: [
                      TextSpan(text: "Click the ",style: TextStyle(color: Colors.black,fontSize: 20)),
                      TextSpan(text: "indigo button",style: TextStyle(color: Colors.indigoAccent[700],fontSize: 20,fontWeight: FontWeight.bold)),
                      TextSpan(text: " with the  +  to get started",style: TextStyle(color: Colors.black,fontSize: 20)),
                    ]
                  ) 
                ),    

              ],
            );
          }else{
            todos = s.data;
            // return AnimatedList(
              
            // );
            return ListView.separated(
              itemCount: todos.length,
              separatorBuilder: (c,i)=>Divider(height: 2,),
              itemBuilder: (c,i){
                List theData =[
                  "Unknown",
                  "Unknown",
                  false
                ];
                try {
                  List theListUnF = new List();
                  theListUnF.addAll(todos[i].toString().trim().split(""));
                  //theListUnF.remove(0);
                  theListUnF.removeAt(0);
                  theListUnF.removeLast();
                  List<String> theListF = theListUnF.join().split(", ");
                  theData = theListF;
                  // print(theStr);
                  // print("IDFK EXCEPT I DO 3");
                  // print(json.decode(theStr));
                  print("Got here");
                  //theData = jsonDecode(todos[i]);
                  print("SO it worked?");
                } catch (e) {
                  print("ERROR");
                  print(e.toString());
                }
                Text theDate = Text("");
                print(" Iff Date Data");
                //print(theData[2]);
                print(theData);
                Color theDateColor = Colors.black;
                if(theData[3]=="true"){
                   print("THE Date DATAAA");
                   print(theData[3]);
                   
                   DateTime theTime = DateTime.fromMillisecondsSinceEpoch(int.parse(theData[4].toString().trim()));
                  var formatter = new DateFormat('yyyy-MM-dd');
                  String formatted = formatter.format(theTime);
                  print("Checking time");
                  //print(DateTime.now().compareTo(theTime));
                   if(theTime.compareTo(DateTime.now())<=0){
                     theDateColor = Colors.red;
                   }
                   theDate = Text(formatted,style: TextStyle(fontSize: 17,color: theDateColor));
                   print(theTime);
                }
                Color titleColor = Colors.black;
                try {
                  if(theData[5]=="true"){
                    titleColor = Color(int.parse(theData[6].toString().split("(").last.split(")").first));
                    print("Current Color");
                    print(titleColor);
                  }
                } catch (e) {
                  print("OOOP we have an erorororr");
                  print(e);
                }
                String isFavString = "";
                IconData theCheckIcon = Icons.check_box_outline_blank;
                if(theData[2].isNotEmpty){
                try {                    //theCheckIcon = MdiIcons.starOutline;
                    isFavString = theData[2]+" ";//606,26a2
                  
                } catch (e) {
                }
                }else{
                  isFavString = "";
                }
                return ListTile(
                  title: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: isFavString, style: TextStyle(/*color: Colors.redAccent,*/fontSize: 22)),

                      TextSpan(text:theData[0].trim(),style: TextStyle(color: titleColor)),
                    ]
                  ),),
                  subtitle: Text(theData[1].trim()),
                  trailing: theDate,
                  leading: IconButton(
                          icon: Icon(theCheckIcon,size: 30,color: Colors.black,),
                          splashColor: Colors.yellowAccent,
                          onPressed: (){
                            showCupertinoModalPopup(
                              context: context,
                              builder: (c){
                                return CupertinoAlertDialog(
                                  title: Text("You did it?"),
                                  actions: <Widget>[
                                    
                                    CupertinoDialogAction(
                                      child: Text("Nah"),
                                      isDefaultAction: false,
                                      onPressed: (){
                                       
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: Text("Yes"),
                                      isDefaultAction: true,
                                      onPressed: (){
                                        todos.removeAt(i);
                                        storeStringList(todos);
                                        setState(() {
                                          body = buildListOfTodos();
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }
                            );
                          },
                  ),
                  onTap: (){
                    titleController.clear();
                    descriptionController.clear();
                    bool newDay = false;
                    bool newColor = false;
                    Color newColorData = Colors.black;
                    int currentDateTime = DateTime(2019,1,1).millisecondsSinceEpoch;
                    String hasDay = theData[3];
                    String hasColor = theData[5];
                    String emoji = theData[2];
                    String dayStr = "Change Day";

                    if(hasDay=="true"){
                      dayStr = "Change Day";
                    }else{
                      dayStr = "Add Day";
                    }
                    String colorStr = "Change Color";
                    if(hasColor =="true"){
                      colorStr = "Change Color";
                    }else{
                      colorStr = "Add Color";
                    }

                    String emojiStr = "Change Emoji";
                    if(emoji.trim().isEmpty){
                      emojiStr = "Add Emoji";
                    }
                    showCupertinoModalPopup(
                      context: context,
                      builder: (c){
                        
                        return CupertinoAlertDialog(
                          title: Text("Update Info"),
                          content: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text("Title:")
                                ],
                              ),
                              CupertinoTextField(
                                controller: titleController,
                                autocorrect: true,
                                clearButtonMode: OverlayVisibilityMode.editing,
                                //suffix: Text("Flander's Football"),
                              ),
                              Container(height: 10,),
                              Row(
                                children: <Widget>[
                                  Text("Subtitle:")
                                ],
                              ),
                              CupertinoTextField(
                                controller: descriptionController,
                                autocorrect: true,
                                clearButtonMode: OverlayVisibilityMode.editing,
                                //suffix: Text("Highly Unimportant"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    child: Text(colorStr),
                                    onPressed: (){
                                      showModalBottomSheet(
                                                context: context,
                                                builder: (c){
                                                  return Container(
                                                    height: 330,
                                                    color: Colors.white,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[
                                                            CupertinoButton(
                                                              child: Text("Nevermind"),
                                                              onPressed: (){
                                                                newColor = false;
                                                                Navigator.of(context).pop();
                                                              },
                                                            ),
                                                            CupertinoButton(
                                                              child: Text("Set Color"),
                                                              onPressed: (){
                                                                newColor = true;
                                                                Navigator.of(context).pop();
                                                              },
                                                            )
                                                          ],
                                                        ),
                                                        MaterialColorPicker(
                                                          selectedColor: Colors.black,
                                                          allowShades: false,
                                                          iconSelected: MdiIcons.paletteOutline,
                                                          onColorChange: (Color theColor){
                                                            newColorData = theColor;
                                                          },
                                                          onMainColorChange: (Color theColor){
                                                            newColorData = theColor;
                                                          },
                                                          ),
                                                      ],
                                                    ),
                                                    );
                                                }
                                              );

                                    },
                                  ),
                                  CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    child: Text(dayStr),
                                    onPressed: (){
                                              //bool hasDateTimeForPush;
                                      showCupertinoModalPopup(
                                                context: context,
                                                builder: (c)=>Container(
                                                  height: 352,
                                                  color: Colors.white,
                                                  child:Column(
                                                    children: <Widget>[
                                                      Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        CupertinoButton(
                                                          child: Text("Cancel"),
                                                          onPressed: (){
                                                            Navigator.of(context).pop();
                                                            hasDay = "false";
                                                            newDay = false;
                                                          },
                                                        ),
                                                        CupertinoButton(
                                                          child: Text("Set Date"),
                                                          onPressed: (){
                                                            hasDay = "true";
                                                            newDay = true;
                                                            currentDateTime = currentDateTime;
                                                            Navigator.of(context).pop();
                                                          },
                                                        ),
                                                        
                                                      ],
                                                    ),
                                                      Container(
                                                        height: 300,
                                                        child: CupertinoDatePicker(
                                                          
                                                          mode: CupertinoDatePickerMode.date,
                                                          initialDateTime: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day),
                                                          onDateTimeChanged: (DateTime newDt){
                                                            currentDateTime = newDt.millisecondsSinceEpoch;
                                                        },
                                                      ),
                                                      ),
                                                    ],
                                                  ),
                                              )
                                              );
 
                                    },

                                  ),
                                ],
                              ),                          
                              CupertinoButton(
                                child: Text(emojiStr),
                                onPressed: (){
                                  showEmojiPicker(allEmojis);
                                },
                              )
                              ],
                          ),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: Text("Cancel"),
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text("Save"),
                              onPressed: (){
                                if(titleController.text.trim().isNotEmpty){
                                  theData[0] = titleController.text.trim();
                                }
                                if(descriptionController.text.trim().isNotEmpty){
                                  theData[1] = descriptionController.text.trim();
                                }
                                if(newColor){
                                  theData[6] = newColorData.toString();
                                }
                                if(newDay){
                                  theData[3] = hasDay;
                                  theData[4] = currentDateTime.toString();
                                }
                                theData[2] = currentEmoji;
                                todos[i] = theData.toString();

                                storeStringList(todos);
                                setState(() {
                                  body = buildListOfTodos();
                                });
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      }
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  void showEmojiPicker(List<Widget> emojis) {
     List allEmojis = <Widget>[
            makeEmojiTile("👩‍🎨"),
            makeEmojiTile("👨‍🎨"),
            makeEmojiTile("👩‍🔬"),                                            
            makeEmojiTile("👨‍🔬"),
            makeEmojiTile("👩‍🏭"),
            makeEmojiTile("👨‍🏭"),
            makeEmojiTile("👩‍🏫"),
            makeEmojiTile("👨‍🏫"),
            makeEmojiTile("👩‍🎓"),
            makeEmojiTile("👨‍🎓"),
            makeEmojiTile("👩‍⚕️"),
            makeEmojiTile("👨‍⚕️"),// 
            makeEmojiTile("⭐️"),
            makeEmojiTile("🌟"),
            makeEmojiTile("✨"),
            makeEmojiTile("⚡️"),
            makeEmojiTile("☄️"),
            makeEmojiTile("🔥"),
            makeEmojiTile("🌎"),
            makeEmojiTile("🎼"),
            makeEmojiTile("🎹"),
            makeEmojiTile("🥁"),//        
            makeEmojiTile("🎷"),
            makeEmojiTile("🎺"),
            makeEmojiTile("🎸"), 
            makeEmojiTile("🎻"),
            makeEmojiTile("✉️"),
            makeEmojiTile("✅"),
            makeEmojiTile("⁉️"),
            makeEmojiTile("🛑"),
            makeEmojiTile("🍕"),
            makeEmojiTile("🥑"),


          ];


    List<Widget> actionEmojis = <Widget>[
            makeEmojiTile("⭐️"),
            makeEmojiTile("🌟"),
            makeEmojiTile("✨"),
            makeEmojiTile("⚡️"),
            makeEmojiTile("🔥"),
            makeEmojiTile("✅"),
            makeEmojiTile("⁉️"),
            makeEmojiTile("🛑"),
          ];
           List peopleEmojis = <Widget>[
            makeEmojiTile("👩‍🎨"),
            makeEmojiTile("👨‍🎨"),
            makeEmojiTile("👩‍🔬"),                                            
            makeEmojiTile("👨‍🔬"),
            makeEmojiTile("👩‍🏭"),
            makeEmojiTile("👨‍🏭"),
            makeEmojiTile("👩‍🏫"),
            makeEmojiTile("👨‍🏫"),
            makeEmojiTile("👩‍🎓"),
            makeEmojiTile("👨‍🎓"),
            makeEmojiTile("👩‍⚕️"),
            makeEmojiTile("👨‍⚕️"),// 
          ];
    showModalBottomSheet(
                                        context: context,
                                        builder: (c){                                                        

                                          
                                          return Container(
                                            height: 360,
                                            color: Colors.white,
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    CupertinoButton(
                                                      child: Text("Cancel"),
                                                      onPressed: (){
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: DropdownButton(
                                                        isDense: true,
                                                        isExpanded: false,

                                                        hint: Text("Set Emojis"),
                                                        icon: Icon(Icons.menu),
                                                        items: [
                                                          DropdownMenuItem(
                                                            child: Text("Set Emojis "),
                                                            value: 0,
                                                          ),
                                                          DropdownMenuItem(
                                                            child: Text("All"),
                                                            value: 1,
                                                          ),
                                                          DropdownMenuItem(
                                                            child: Text("Actions"),
                                                            value: 2,
                                                          ),
                                                          DropdownMenuItem(
                                                            child: Text("People"),
                                                            value: 3,
                                                          )
                                                        ],
                                                        onChanged: (i){
                                                          Navigator.of(context).pop();
                                                          print("INDEX:::");
                                                          print(i);
                                                          if(i==0 || i ==1){
                                                            showEmojiPicker(allEmojis);
                                                          }else if(i == 2){
                                                            showEmojiPicker(actionEmojis);
                                                          }else{
                                                            showEmojiPicker(peopleEmojis);
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                      
                                                    
                                                  ],
                                                ),
                                                Container(
                                                  height: 290,
                                                  child: GridView.count(
                                                    crossAxisCount: 4,
                                                    children: emojis,
                                                  ),
                                                )
                                                ],
                                            ),
                                            );
                                        }
                                      );
  }

  static String listKey = "v1";

  void storeStringList(List<String> list) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(listKey, list);
  }

  Future<List<String>> getStringList() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(listKey);
  }
  Widget makeEmojiTile(String emoji){
    TextStyle emojiStyle = TextStyle(fontSize: 45);

    return GridTile(
      child: Center(child: CupertinoButton(child: Text(emoji,style: emojiStyle,),onPressed: (){
        print("EMOJIII");
        print(emoji);
        
        setState(() {
          currentEmoji = emoji.toString();

        });
        print(currentEmoji);
        Navigator.of(context).pop();
      })),
    );
  }
  
}
