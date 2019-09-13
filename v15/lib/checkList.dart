import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:localstorage/localstorage.dart';
import 'color_loader_3.dart';

import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
//Checklist item -- Title, Subtitle, Color, Emoji
class Checklist extends StatefulWidget {
  @override
  _ChecklistState createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  LocalStorage checklistStorage;
  Widget body = Center(child: ColorLoader3(),);
  bool readyG = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    checklistStorage = LocalStorage("checklist");
    checkReady(checklistStorage);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.baseColor,
        child: Icon(Icons.add),
        onPressed: (){
          if(readyG){
            Navigator.of(context).push(
              MaterialPageRoute(
                maintainState: false,
                fullscreenDialog: true,
                builder: (c)=>AddToChecklist(checklistStorage:checklistStorage)
              )
            ).then((value){
              setState(() {
                if(checklistStorage.getItem("items")!=null&&checklistStorage.getItem("items").isNotEmpty)
                body = checklistBuilder(checklistStorage.getItem("items"));
              });
            });
          }else{
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text("Sorry, your checklist isn't ready yet"),
                backgroundColor: Constants.baseColor,
                behavior: SnackBarBehavior.fixed,
                action: SnackBarAction(
                  label: "Ok",
                  onPressed: ()=>_scaffoldKey.currentState.hideCurrentSnackBar(),
                  textColor: Colors.white,
                ),
              )
            );
          }
        },
      ),
      body: body,
    );
  }
  

  void checkReady(LocalStorage theStorage) async{
    Future<bool> readyF = theStorage.ready;
    bool ready = await readyF;
    if(ready){
      readyG = true;
      List storageList = theStorage.getItem("items");
      if(storageList == null||storageList.isEmpty){
        setState(() {
          body = emptyChecklist();
        });
      }else{
        setState(() {
          body = checklistBuilder(storageList);
        });
      }
    }else{
      setState(() {
        try {
          theStorage.setItem("test", ['test','test','test']);
        } catch (e) {
        }
        
        body = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Sorry, we are having trouble accessing this device's local storage", style: TextStyle(color: Colors.black, fontSize: 19),),
            Text("Please check your settings to see if you are blocking our access somehow.", style: TextStyle(color: Colors.black, fontSize: 19))
          ],
        );
      });
    }
  }

  Widget emptyChecklist() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 22),
            children: [
              TextSpan(
                text: "Welcome to your "
              ),
              TextSpan(
                text: "School Checklist",
                style: TextStyle(fontWeight: FontWeight.bold)
              ),
              TextSpan(
                text: ". Press the "
              ),
              TextSpan(
                text: "blue button",
                style: TextStyle(color: Constants.baseColor, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: " at the bottom right of your screen to get started."
              ),
            ]
          ),
        )
      ]
    );
  }

  Widget checklistBuilder(List storageList) {
   //List theChecklistValues = List.generate(storageList.length, (i)=>false);
    return ListView.separated(
      itemCount: storageList.length,
      padding: EdgeInsets.all(25),
      separatorBuilder: (c,i)=>Container(height: 20,),
      itemBuilder: (c,i){
        Map currentMap = storageList[i];
        var diffenenceAbs = DateTime.fromMillisecondsSinceEpoch(currentMap['date']).difference(DateTime.now()).inDays.abs();
                return Container(
                  child: RaisedButton(
                    
                    splashColor: currentMap['hasColor']?Color(currentMap['color']):null,
                    color: Colors.white,
                    elevation: 10,
                    padding: EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 15
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(),
                                currentMap['hasDate']==true?
                                DateTime.fromMillisecondsSinceEpoch(currentMap['date']).isBefore(DateTime.now())?Text(diffenenceAbs.toString()+ (diffenenceAbs<=1?" Day Late":" Days Late"), style: TextStyle(color: Colors.red)):Container(height: 0,):Container(height: 0,)//==true is just error catching
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  SelectableText(currentMap['title'], style: TextStyle(fontSize: 20, color: Color(currentMap['color'])),),
                  currentMap['hasEmoji']==true?Text(currentMap['emoji'],style: TextStyle(fontSize: 28),):Container(height: 0),

                ],),
                Container(height: 10,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  SelectableText(currentMap['subtitle'], style: TextStyle(fontSize: 18, color: Colors.grey[700]),),
                ],
                ),
                
              ],
            ),
            Positioned(
              right: -10,
              bottom: -13,
              child: IconButton(icon: Icon(Icons.check_box_outline_blank, size: 30,),
                    padding: EdgeInsets.zero,
                    onPressed: (){
                      showCupertinoModalPopup(
                        context: context,
                        builder: (c)=>CupertinoAlertDialog(
                          title: Text("You did it?"),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: Text("No"),
                              isDefaultAction: false,
                              onPressed: (){
                                //storageList.removeAt(i);
                                setState(() {
                                  Navigator.of(context).pop();
                                  //body = storageList.isNotEmpty?checklistBuilder(storageList):emptyChecklist();
                                });
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text("Yes"),
                              isDefaultAction: true,
                              onPressed: (){
                                storageList.removeAt(i);
                                setState(() {
                                  Navigator.of(context).pop();
                                  body = storageList.isNotEmpty?checklistBuilder(storageList):emptyChecklist();
                                });
                              },
                            )
                          ],
                        )
                      );
                    },
                  ),

            )
            ],
          ),

            onPressed: (){},
          ),
        );
      },
    );
  }
}

class AddToChecklist extends StatefulWidget {
  AddToChecklist({@required this.checklistStorage});
  LocalStorage checklistStorage;
  @override
  _AddToChecklistState createState() => _AddToChecklistState();
}

class _AddToChecklistState extends State<AddToChecklist> {
  TextEditingController titleController;
  TextEditingController subtitleController;
  String emoji = "";
  Color color = Colors.black;
  Color selectedColor = Colors.blue;
  bool hasDate = false;
  bool hasEmoji = false;
  bool hasColor = false;
  DateTime currentDate = DateTime.now().add(Duration(days:1));
  DateTime theDate = DateTime.now(); //Just so its not null to stop any possible errors

  bool notification = true;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  LocalStorage checklistStorage;

  @override
  void initState() {
    super.initState();

    checklistStorage = widget.checklistStorage;
    print("Storage:");
    print(checklistStorage);
    titleController = new TextEditingController();
    subtitleController = new TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    List emojis = ["😀","😇","😂","😛", "🤑", "😎", "🤓", "🧐", "🤠","🤯","👩‍🏭", "👨‍🏭", "👩‍🔧", "👨‍🔧", "👩‍🌾", "👨‍🌾", "👩‍🍳", "👨‍🍳", "👩‍🎤", "👨‍🎤","👩‍🎨", "👨‍🎨", "👩‍🏫", "👨‍🏫", "👩‍🎓", "👨‍🎓", "👩‍💼", "👨‍💼", "👩‍💻", "👨‍💻", "👩‍🔬", "👨‍🔬", "👩‍🚀", "👨‍🚀", "👩‍⚕️" ,"👨‍⚕️", "👩‍⚖️", "👨‍⚖️", "👩‍✈️", "👨‍✈️", "💂‍", "🕵️‍", "🤶", "🎅","🍀","🎼", "🎹", "🥁", "🎷", "🎺", "🎸", "🎻","🏄‍", "🏊","🤽","⚽", "🏀", "🏈", "⚾", "🏐", "⚡", "🔥", "💥", "❄","⭐"];
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Add to Checklist"),
        backgroundColor: Constants.baseColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 30.0),
        child: ListView(
          children: <Widget>[
            Row(children: <Widget>[
              Text("Title:", style: TextStyle(fontSize: 18)),
            ],),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                suffixText: "Required",
                hintText: "Do math homework",
                border: UnderlineInputBorder()
              ),
            ),
            Container(height: 40,),
            Row(children: <Widget>[
              Text("Subtitle:", style: TextStyle(fontSize: 18)),
            ],),
            TextField(
              controller: subtitleController,
              decoration: InputDecoration(
                hintText: "Very important",
                border: UnderlineInputBorder()
              ),
            ),
            Container(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Text("What Day:", style: TextStyle(fontSize: 18)),
              CupertinoButton.filled(
                child: Text(hasDate?"Change Day":"Add Day"),
                onPressed: (){
                  showModalBottomSheet(
                    context: context,
                    builder: (c){

                      return Container(
                        height: 400,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CupertinoButton(child: Text(hasDate?"Remove Date":"Cancel"),onPressed: (){Navigator.of(context).pop(); setState(() {
                                  hasDate = false;
                                });},),
                                CupertinoButton(child: Text(hasDate?"Change Date":"Add Date"),onPressed: (){
                                  Navigator.of(context).pop();
                                  setState(() {
                                    hasDate = true;
                                    theDate = currentDate;
                                  });
                                },)
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(0),
                              height: 340,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: currentDate,
                                onDateTimeChanged: (newDate){
                                  currentDate = newDate;
                                  print(newDate);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  );
                },
              )
            ],),
            Container(height: hasDate?/*15*/0:0,),
            hasDate?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Text("Add Notification:", style: TextStyle(fontSize: 18)),
                // CupertinoSwitch(
                //   value: notification,
                //   onChanged: (v){},
                // )
            ],
            ):Container(height: 0,),
            Container(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Text("Emoji:", style: TextStyle(fontSize: 18)),
              CupertinoButton.filled(
                child: Text(hasEmoji?"Current Emoji: "+emoji:"Add Emoji"),
                onPressed: (){
                  showModalBottomSheet(
                    context: context,
                    builder: (c){

                      return Container(
                        height: 400,
                        child: Column(

                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CupertinoButton(
                                  child: Text(hasEmoji?"Clear Emoji":"Cancel"),
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                    setState(() {
                                      hasEmoji = false;
                                      emoji = "";
                                    });
                                  },
                                ),
                                CupertinoButton(
                                  child: Text(hasEmoji?"Change Emoji":"Add Emoji"),
                                  onPressed: (){},
                                )
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(0),
                              height: 340,
                              child: GridView.builder(
                                itemCount: emojis.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
                                itemBuilder: (c,i)=>GridTile(
                                  child: Center(child:CupertinoButton(child: Text(emojis[i], style: TextStyle(fontSize: 30),), onPressed: (){
                                    Navigator.of(context).pop();
                                    setState(() {
                                      emoji = emojis[i].toString().trim();
                                      hasEmoji = true;
                                    });
                                   
                                    
                                  },)),
                                ),
                              )
                            ),
                          ],
                        ),
                      );
                    }
                  );
                },
              )
            ],),
            Container(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Color:", style: TextStyle(fontSize: 18)),
                CupertinoButton.filled(
                child: Text(hasColor?"Change Color":"Add Color",),
                onPressed: ()=>showModalBottomSheet(
                  context: context,
                  builder: (c)=>Container(
                    height: 325,
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CupertinoButton(child: Text(hasColor?"Remove Color":"Cancel",),onPressed: (){Navigator.of(context).pop();
                            setState(() {
                              hasColor = false;
                              color = Colors.black;
                            });
                            }
                            ),
                            CupertinoButton(child: Text(hasColor?"Change Color":"Add Color",),onPressed: (){
                              Navigator.of(context).pop();
                              setState(() {
                                hasColor = true;
                                color = selectedColor;
                              });
                            }

                            )
                        ],),
                        Container(
                          width: MediaQuery.of(context).size.width-15,
                          height: 250,child: MaterialColorPicker(
                          allowShades: false,
                          //selectedColor: color,
                          onlyShadeSelection: true,
                          onMainColorChange: (c){
                            selectedColor = c;
                          },
                          
                        ),),
                      ],
                    ),
                  )
                ),
                ),
            ],),
            Container(height: 50,),
            RaisedButton(
              color: Constants.baseColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              child: Container(height: 80,child: Center(
                child: Text("Add to Checklist", style: TextStyle(color: Colors.white, fontSize: 21),),),),
              onPressed: (){
                String title = titleController.text;
                String subtitle = subtitleController.text;
                
                if(title.isNotEmpty){
                  List originalList = checklistStorage.getItem('items')!=null?checklistStorage.getItem('items'):new List();
                  Map newTodo = new Map();
                  newTodo['title']=title;
                  newTodo['subtitle'] = subtitle;
                  newTodo['color'] = color.value;
                  newTodo['hasColor'] = hasColor;
                  newTodo['date'] = theDate.millisecondsSinceEpoch;
                  newTodo['hasDate'] = hasDate;
                  newTodo['emoji'] = emoji;
                  newTodo['hasEmoji'] = hasEmoji;
                  originalList.insert(0,newTodo);
                  print(originalList);
                  checklistStorage.setItem('items',originalList);
                  Navigator.of(context).pop();
                }else{
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      backgroundColor: Constants.baseColor,
                      content: Text("Please fill in a title"),
                      behavior: SnackBarBehavior.floating,
                      action: SnackBarAction(
                        label: "Ok",
                        textColor: Colors.white,
                        onPressed: (){
                          _scaffoldKey.currentState.hideCurrentSnackBar();
                        },
                      ),
                    )
                  );
                }
              },
            )
            
          ],
        ),
      ),
    );
  }
}