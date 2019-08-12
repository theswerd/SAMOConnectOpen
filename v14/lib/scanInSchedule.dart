import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:v14/color_loader_3.dart';
import 'constants.dart';
import 'package:localstorage/localstorage.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class AddMySchedule extends StatefulWidget {

  static String tag = "scanInSchedule";
  @override
  _AddMyScheduleState createState() => _AddMyScheduleState();
}

class _AddMyScheduleState extends State<AddMySchedule> {
  Widget body;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final LocalStorage storage = new LocalStorage('schedule');

  @override
  void initState() {
    super.initState();

    body = bodyBuilder(FutureBuilder(
          future: storage.ready,
          builder: (BuildContext context, snapshot) {
            if (snapshot.data == true) {
              List data = storage.getItem('schedule');
              if(data!=null){
                List schedule = data;
                return ListView.builder(
                  itemCount: schedule.length,
                  itemBuilder: (c,i)=>ListTile(title: Text(schedule[i].toString()),),
                );
              }else{
                return Scaffold(
                  body: Center(child: Text("You can now scan your schedule into SAMO Connect, that will allow you to have special class notifications and a personalized schedule.", textAlign: TextAlign.center,),),
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: Constants.baseColor,
                    child: Icon(MdiIcons.camera),
                    onPressed: (){
                      try {
                        checkCamera();
                      } catch (e) {
                        print(e);
                      }
                      
    
                    },
                  ),
                );
              }
              
            } else {
              return Center(child: ColorLoader3(),);
            }
          },
        ),context);
      

     }
  @override
  Widget build(BuildContext context) {
        
    return AnimatedSwitcher(child:body, duration: Duration(seconds: 2),);
  }

  void checkCamera() async{
    
      showCupertinoModalPopup(
        context: context,
        builder:(c)=>CupertinoActionSheet(
          title: Text("Scan in schedule"),
          message: Text("When scanning in your schedule, please only scan in the courses section. If you need an example, check it out by pressing the info button and clicking to view the example."),
          cancelButton:Constants.cancelAction(context),
          actions:[
            CupertinoActionSheetAction(
              child: Text("Take Photo"),
              onPressed: () async{
                File theSchedule = await ImagePicker.pickImage(source: ImageSource.camera);
                if(theSchedule != null){
                  final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
                  try {
                    getData(theSchedule, textRecognizer);
                  } catch (e) {
                    print(e);
                    
                  }
                  }
              },
            ),
            CupertinoActionSheetAction(
              child: Text("Photo Gallery"),
              onPressed: () async{
                File theSchedule = await ImagePicker.pickImage(source: ImageSource.gallery);
                if(theSchedule != null){
                  final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
                  try {
                    getData(theSchedule, textRecognizer);
                  } catch (e) {
                  }
                }
              },
            )
          ]
        )
      );
    
    

  }

  Future getData(File theSchedule, TextRecognizer textRecognizer) async {
    Navigator.of(context).pop();
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(theSchedule);
    // _scaffoldKey.currentState.showSnackBar(
    //   SnackBar(
    //     content: Text("Analyzing your data can take up to 20 seconds"),
    //     backgroundColor: Constants.baseColor,
    //     duration: Duration(seconds: 3),
    //   )
    // );
    final VisionText visionText = await textRecognizer.processImage(visionImage);
    print("WE GOT EMMM");
    print(visionText.text.toString());
    List<TextBlock> blocks = visionText.blocks;
    if(blocks.first.text.toUpperCase().trim()=="COURSE"){
      
    }
    List formattedBlocks = [];
    for (int i = 0; i < blocks.length; i++) {
      TextBlock block = blocks[i];
      if(i!=0){
        List allInThisBlock = block.text.split("\n");
        formattedBlocks.addAll(allInThisBlock);
      }
    }
    setState(() {
       body = bodyBuilder(AnimatedList(
          initialItemCount: formattedBlocks.length,
          itemBuilder: (c,i,a){
            return ListTile(
              title: Text(formattedBlocks[i]),
            );
          },
      ),
      context
       );
    });
  }
  
}
Widget bodyBuilder(Widget body, BuildContext context){
  final LocalStorage storage = new LocalStorage('schedule');

  return Scaffold(
    appBar: AppBar(
      backgroundColor: Constants.baseColor,
      title: Text("Your Schedule"),
      actions: <Widget>[
        IconButton(
          icon:Icon(Icons.info_outline),
          splashColor: Colors.yellowAccent,
          onPressed: ()=>Constants.showInfoBottomSheet(
            [
              CupertinoActionSheetAction(child: Text("Clear"),onPressed: (){storage.setItem("schedule",null);Navigator.of(context).pop();},),
              CupertinoActionSheetAction(child: Text("Example"),onPressed: ()=>showCupertinoModalPopup(
                context: context,
                builder: (c)=>CupertinoAlertDialog(
                  title: Text("Example:"),
                  content: Container(
                    height: 600,
                    child: Image.asset("assets/"),
                    ),

                ) 
              )

              ),

            ], context),
          ),

      ],
    ),
  );
}