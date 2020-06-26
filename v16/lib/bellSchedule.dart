import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'color_loader_3.dart';

import 'package:share/share.dart';

import 'constants.dart';

class BellSchedule extends StatefulWidget {

  static String tag = "bell-schedule";
  BellSchedule();

  @override
  _BellScheduleState createState() => _BellScheduleState();
}

class _BellScheduleState extends State<BellSchedule>
    with SingleTickerProviderStateMixin {
      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.baseColor,
        title: Text("Bell Schedule"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            color: Colors.white,
            splashColor: Colors.yellowAccent,
            onPressed: (){
              Share.share("Worried about being late for classes? Luckily the bell schedule is available on SAMO Connect -- https://samoconnect.page.link/SamoConnect");
            },
          ),
          IconButton(
            icon: Icon(Icons.info_outline),
            splashColor: Colors.yellowAccent,
            onPressed: (){
              Constants.showInfoBottomSheet(
                [
                  Constants.officialWebsiteAction(context, "http://www.samohi.smmusd.org/Students/bells.html"),
                  Constants.ratingAction(context),
                  CupertinoActionSheetAction(
                    child: Text("Extra Info"),
                    onPressed: (){
                      showCupertinoModalPopup(
                        context: context,
                        builder: (c){
                          return CupertinoAlertDialog(
                            title: Text("Extra Info"),
                            content: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                
                                children: [
                                  TextSpan(text: "This data is stored on the "),
                                  TextSpan(text: "SAMO Connect",style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: " server. It is networked so it is "),
                                  TextSpan(text: "always up to date with special schedules.",style: TextStyle(fontWeight: FontWeight.bold)),
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
                context);
            },
          ),  
        ],
      ),
      body: FutureBuilder(
        future: Firestore.instance.collection("schedule").getDocuments(),
        builder: (c,snapshot){
          if(snapshot.hasError){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Handshake Failure",style: TextStyle(fontSize: 20),)
              ],
            );
          }else if(snapshot.connectionState!=ConnectionState.done ){
          return loadingList();

          }else{
            QuerySnapshot snapdata =snapshot.data;
            List schedules =snapdata.documents;
            return ListView.separated(
              itemCount: schedules.length,
              separatorBuilder: (c,i){
                return Container(height: 30,);
              },
              itemBuilder: (c,i){
                DocumentSnapshot todaysScheduleDoc = schedules[i];
                Map<String,dynamic> todaysSchedule =todaysScheduleDoc.data;
                String todaysScheduleDay = todaysSchedule["day"];
                String todaysScheduleNotes =todaysSchedule["notes"];
                List todaysTimes =todaysSchedule["times"];
                List todaysClasses =todaysSchedule["classes"];
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child:RaisedButton(
                  
                  color: Colors.white,
                  elevation: 10,
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                      builder: (c){return SingleSchedule(todaysScheduleDay,todaysClasses,todaysTimes,todaysScheduleNotes);}
                    )
                    );
                  },
                  child: Container(
                    height: 350,
                    padding: EdgeInsets.symmetric(vertical:15,horizontal: 10),
                    child: Column(
                      
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(todaysScheduleDay,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                            Expanded(child: Container(),),
                            Text(todaysScheduleNotes,style: TextStyle(fontSize: 16,color: Colors.grey[600]),)
                          ],
                        ),
                        Container(height: 10,),
                        Container(height: 260,child: 
                        ListView.separated(
                          separatorBuilder: (c,i){
                            return Container(height: 20,);
                          },
                          itemBuilder: (c,i2){
                            return Container(
                              height: 50,
                              child: RaisedButton(
                                color: Colors.blue[50],
                                elevation: 15,
                                onPressed: (){

                                },
                                child: Row(
                                  children: <Widget>[
                                    Text(todaysClasses[i2]),
                                    Expanded(child: Container(),),
                                    Text(todaysTimes[i2])
                                  ],
                                ),
                                ),
                              );
                            
                          },
                          itemCount: todaysClasses.length,

                        )
                        )
                      ],
                    ),
                  ),
                )
                );
              },
            );
          }
        },
      ),
    );
   }
}

class loadingList extends StatelessWidget {
  const loadingList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 30,
      separatorBuilder: (c,i){
        
        return Container(height: 30,);
      },
      itemBuilder: (c,i){
        double loadingheight = 150;
        return Container(
          height: loadingheight,
          padding: EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.center,
          child: RaisedButton(
            
            color: Colors.white,
            elevation: 15,
            child: Container(
              height: loadingheight,
              width: MediaQuery.of(context).size.width,
              child:ColorLoader3()),
            onPressed: (){
              
            },
          ),
          );
      },

    );
  }
}


class SingleSchedule extends StatefulWidget {

  static String tag = "Single-Schedule";
  String day;
  String notes;
  List classes;
  List times;
  SingleSchedule(this.day,this.classes,this.times,this.notes );

  @override
  _SingleScheduleState createState() => _SingleScheduleState(day,classes,times,notes);
}

class _SingleScheduleState extends State<SingleSchedule>
    with SingleTickerProviderStateMixin {
    String day;
    String notes;
    List classes;
    List times;

  _SingleScheduleState(this.day,this.classes,this.times,this.notes);

  @override
  Widget build(BuildContext context) {
    
    
    print( "DATA");
    print(day);
    print(classes);
    print(times);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent[700],
        title: Text(day),
        centerTitle: true,
        actions: <Widget>[Center(child:Text(notes)),Container(width: 20,)],
      ),
      body: ListView.separated(
        itemCount: classes.length,
        separatorBuilder: (c,i){
          return Container(height: 30,);
        },
        itemBuilder: (context,i){
          return Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: RaisedButton(
              color: Colors.white,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              onPressed: (){},
              child: Row(children: <Widget>[
                Text(classes[i],style:TextStyle(color: Colors.black,fontSize: 22)),
                Expanded(child: Container(),),
                Text(times[i],style:TextStyle(color: Colors.black,fontSize: 20))
              ],),
            ),
          );
        },
      ),
      
      );
  }
      
}

