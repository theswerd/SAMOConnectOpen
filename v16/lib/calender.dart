import 'package:flutter/material.dart';
import 'constants.dart';
import 'color_loader_3.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart'as dom;

import 'package:localstorage/localstorage.dart';

class Calendar extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
 static String tag = "CalenderView";
  Calendar();

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  _CalendarState createState() => new _CalendarState();
}

class _CalendarState extends State<Calendar> with TickerProviderStateMixin {
  Widget calendarBody;
  static String currentDay = DateTime.now().year.toString()+"-"+DateTime.now().month.toString()+"-"+DateTime.now().day.toString()+"-V2";
  LocalStorage theStorage;
  @override
  void initState() {

      Widget networkCalendar =  StreamBuilder(
       //stream:http.get("https://calendar.google.com/calendar/htmlembed?mode=AGENDA&src=smmk12.org_21bhbi3q00vuvdf2rak3rrrll8%40group.calendar.google.com").asStream(),
       stream:http.get("https://calendar.google.com/calendar/htmlembed?title=Santa%20Monica%20High%20School%20Calendar&mode=AGENDA&height=600&wkst=1&bgcolor=%23ffffff&src=smmk12.org_21bhbi3q00vuvdf2rak3rrrll8%40group.calendar.google.com&color=%23875509&src=8tn1onqvkup6g281q19s6oon3s%40group.calendar.google.com&color=%230F4B38&src=smmk12.org_tfdd6j1jr5hatfbcj87rro5k9c%40group.calendar.google.com&color=%23125A12&src=smmk12.org_7qnt6q53j7934lvcl0t754of9c%40group.calendar.google.com&color=%23711616&src=smmk12.org_4h8qa262239su4p66islu1e5vg%40group.calendar.google.com&color=%2323164E&src=smmk12.org_t60qs7u1uktrievfsk7gq5c73s%40group.calendar.google.com&color=%23182C57&src=smmk12.org_8umjrnuec40aa66o36lhd1huh8%40group.calendar.google.com&color=%23333333&src=smmk12.org_u8qc6umps8tqttms2sg3456jg8%40group.calendar.google.com&color=%236B3304&ctz=America%2FLos_Angeles").asStream(),
       builder: (c,s){
         if(s.hasError){
           return Center(child:
               RichText(
                 textAlign: TextAlign.center,
                 
                               text: TextSpan(
                                 children: <TextSpan>[
                                   TextSpan(text: "Sorry, it looks like your ",style: TextStyle(color: Colors.black, fontSize: 18)),
                                   TextSpan(text: "offline",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black, fontSize: 18))

                                 ]
                               ),
                             )
             
           ); 
         }
         if(s.connectionState!=ConnectionState.done){
           return Center(child:ColorLoader3());
         }else{
           http.Response response = s.data;
           //FULL DOCUMENT
           dom.Document p1 = parse(response.body); 
           //BODY
           dom.Element p2 = p1.body;
           //CALENDER
           dom.Element p3 = p2.getElementsByClassName("view-container")[0];
           //UNFORMATTED DAYS
           List<dom.Element> p4 = p3.children;
           
           List days = formatDays(p4);
           storeDays(days);

           return calendarViewMakerV2(days);
         }
       },
     );
    super.initState();
    calendarBody = networkCalendar;
      checkStorage();
    
    }
    
      @override
      Widget build(BuildContext context) {
      
       return Scaffold(
         body: calendarBody
         
         );
      }
    ListView calendarViewMakerV2(List days) {
            return ListView.builder(
                   itemCount: days.length,
                   itemBuilder: (c,i){
                     Map today = days[i];
                     return Container(
                       padding: EdgeInsets.symmetric(horizontal:30,vertical: 20),
                       child:Card(
                         color: Colors.white,
                         
                       elevation: 10,
                       child: Column(
                         
                         children: <Widget>[
                           Row(children: <Widget>[
                             Container(
                               padding: EdgeInsets.only(left:20,top: 20),
                               child: 
                             Text(today["date"],style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),)
                             )
                           ],),
                          // Text(today["events"].length.toString()),
                           Container(
                             height: (today["events"].length*125).toDouble(),
                             child: ListView.builder(
                               itemCount: today["events"].length,
                               itemBuilder: (c,i){
                                 List todaysEvenst= today["events"];
                                 String time =  todaysEvenst[i]['time'];
                                 if(time ==""){
                                   time = "All Day";
                                 }
                                 String event = todaysEvenst[i]['event'];
                                 return Container(
                                   padding: EdgeInsets.all(20),
                                   child: RaisedButton(
                                     onPressed: (){},
                                     padding: EdgeInsets.all(15),
                                     color: Colors.white,
                                     elevation: 10,
                                     child: Column(  
                                       children: <Widget>[
                                        Text(time, style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                                        Container(height: 5,),
                                        Text(event,style: TextStyle(color: Colors.grey[700],fontSize: 18),textAlign: TextAlign.center,)
                                       ],),
                                   ),
                                 );
                               },
                             ),
                             )
                       
                       ],
                       ),
                       //child: Text(today.toString()),
                     ),
                     
                     );
                   },
                 );
           }
       
       ListView calendarViewMaker(List days) {
            return ListView.builder(
                   itemCount: days.length,
                   itemBuilder: (c,i){
                     Map today = days[i];
                     return Container(
                       padding: EdgeInsets.symmetric(horizontal:30,vertical: 20),
                       child:Card(
                         color: Colors.white,
                         
                       elevation: 10,
                       child: Column(
                         
                         children: <Widget>[
                           Row(children: <Widget>[
                             Container(
                               padding: EdgeInsets.only(left:20,top: 20),
                               child: 
                             Text(today["day"],style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),)
                             )
                           ],),
                          // Text(today["events"].length.toString()),
                           Container(
                             height: (today["events"].length*125).toDouble(),
                             child: ListView.builder(
                               itemCount: today["events"].length,
                               itemBuilder: (c,i){
                                 String time =  today["events"][i][0];
                                 if(time ==""){
                                   time = "All Day";
                                 }
                                 String event = today["events"][i][1];
                                 return Container(
                                   padding: EdgeInsets.all(20),
                                   child: RaisedButton(
                                     onPressed: (){},
                                     padding: EdgeInsets.all(15),
                                     color: Colors.white,
                                     elevation: 10,
                                     child: Column(  
                                       children: <Widget>[
                                        Text(time, style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                                        Container(height: 5,),
                                        Text(event,style: TextStyle(color: Colors.grey[700],fontSize: 18),textAlign: TextAlign.center,)
                                       ],),
                                   ),
                                 );
                               },
                             ),
                             )
                       
                       ],
                       ),
                       //child: Text(today.toString()),
                     ),
                     
                     );
                   },
                 );
           }

  void checkStorage() async{
    LocalStorage theStorage =  LocalStorage("calendar");
    Future<bool> ready = theStorage.ready;
    if(await ready){
      List calendar = theStorage.getItem(currentDay);
      if(calendar==null){
        theStorage.clear();
        return;
      }else{
        setState(() {
          calendarBody = calendarViewMakerV2(calendar);
        });
      }
    }
  }

  void storeDays(List days) async{
    LocalStorage theStorage =  LocalStorage("calendar");
    Future<bool> ready = theStorage.ready;
    if(await ready){
      
      theStorage.clear();
      theStorage.setItem(currentDay, days);
        
    }

    
  }
          //  void setCalendarType() async{
          //    LocalStorage theStorage =  LocalStorage("calendar");
          //    Future<bool> ready = theStorage.ready;
          //   if(await ready){
              
            
          //     print("READDYY:");
          //     print(await ready);
          //   List allStorage;
          //   try {
          //     allStorage = theStorage.getItem(currentDay);
          //   } catch (e) {
          //   }
          //   allStorage = theStorage.getItem(currentDay);
          //   if(allStorage==null){
          //     //Sometimes it won't work till data is inputted
          //     theStorage.setItem("tryWork", ['1','2','3']);
          //     theStorage.clear();
              
          //   }else{
          //     setState(() {
          //       calendarBody = calendarViewMaker(allStorage);

          //     });
          //   }
          //   }else{
          //     setState(() {
          //       calendarBody = Container(color: Colors.orange,);
          //     });
          //     return;
          //   }
        
          // }
        
          // void storeTodaysCalendar(List days) async{
          //   LocalStorage theStorage =  LocalStorage("calendar");
          //    Future<bool> ready = theStorage.ready;
          //   if(await ready){
          //     theStorage.setItem(currentDay, days);
          //   }else{
          //     return;
          //   }
            
        
          // }
        
          

     }

  
List formatDays(List<dom.Element> unFDays) {
    List format = [];
    //REmoves the styler
    unFDays.removeAt(0);

    for (dom.Element day in unFDays) {
      Map todaysMap = new Map();
      print("NEW DAYYY");
      String dayStr = "";
      try {
        String dayStrMby = day.getElementsByClassName("date").first.text;
        if(dayStrMby!=null){
          dayStr = dayStrMby;
        }
      } catch (e) {
      }
      todaysMap['date'] = dayStr;
      //The Events
      dom.Element eventsC = day.getElementsByClassName("events").first;
      List<dom.Element> unFEvents = eventsC.children.first.children;
      List<Map> formattedEvents = [];

      for (dom.Element item in unFEvents) {
        try {
          Map formattedItem = new Map();
          String time = item.getElementsByClassName("event-time").first.text;
          if(time.trim().isEmpty){
            time="All Day";
          }
          formattedItem['time'] = time==null?"All Day":time;
          String event = item.getElementsByClassName("event-summary").first.text;
          formattedItem['event'] = event==null?" ":event;
          //print(formattedItem);
          formattedEvents.add(formattedItem);
        } catch (e) {
        }
      } 
      print("\n");
      todaysMap['events'] = formattedEvents;
      format.add(todaysMap);
    }
    print(format);
    return format;
  }
      
 
  