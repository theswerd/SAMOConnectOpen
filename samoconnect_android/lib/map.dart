

import 'package:flutter/material.dart';
import 'color_loader_3.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart' as mIcons;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart'; 
import 'package:webview_flutter/webview_flutter.dart';
class MapClass extends StatefulWidget {
  static String tag = "MAPP";
  @override
  _MapClassState createState() => new _MapClassState();
}

class _MapClassState extends State<MapClass> {

  double officeColor=BitmapDescriptor.hueBlue;
  Set<Marker> buildings = {
      Marker(
       markerId: MarkerId("Construction Zone"),
       position: LatLng(34.0129,-118.48647),
       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
       infoWindow: InfoWindow(
         title: "Construction Zone",
         snippet: "Projected to finish in 2021"
       ),
       
     ),
 
       Marker(
         markerId: MarkerId("Innovation"),
         
         icon: BitmapDescriptor.defaultMarker,
         position: LatLng(34.01367,-118.4858),
         infoWindow: InfoWindow(
           title: "I Building",
           snippet: "The innovation building"
         ),
         zIndex: 5
     ),
     Marker(
         markerId: MarkerId("English"),
         
         icon: BitmapDescriptor.defaultMarker,
         position: LatLng(34.0122,-118.48505),
         infoWindow: InfoWindow(
           title: "E Building",
           snippet: "The English Building"
         ),
         zIndex: 5
     ),
     Marker(
         markerId: MarkerId("History"),
         
         icon: BitmapDescriptor.defaultMarker,
         position: LatLng(34.0119,-118.48562),
         infoWindow: InfoWindow(
           title: "H Building",
           snippet: "The History Building"
         ),
         zIndex: 5
     ),
      Marker(
         markerId: MarkerId("Buisiness"),
         
         icon: BitmapDescriptor.defaultMarker,
         position: LatLng(34.0123,-118.48595),
         infoWindow: InfoWindow(
           title: "B Building",
           snippet: "The Buisiness Building"
         ),
         zIndex: 5
     ),
     Marker(
         markerId: MarkerId("Language"),
         
         icon: BitmapDescriptor.defaultMarker,
         position: LatLng(34.01165,-118.48490),
         infoWindow: InfoWindow(
           title: "L Building",
           snippet: "The Language Building"
         ),
         zIndex: 5
     ),
    Marker(
      markerId: MarkerId("Music"),
      icon: BitmapDescriptor.defaultMarker,
         position: LatLng(34.01165,-118.48690),
         infoWindow: InfoWindow(
           title: "Music Building",
           snippet: "Split between band, orchestra, and choir"
         ),
    ),
    Marker(
      markerId: MarkerId("T Building"),
      icon: BitmapDescriptor.defaultMarker,
         position: LatLng(34.01227,-118.4872),
         infoWindow: InfoWindow(
           title: "T Building",
           snippet: "The Temporary Buildings"
         ),
    ),
    Marker(
      markerId: MarkerId("North Gym"),
      icon: BitmapDescriptor.defaultMarker,
         position: LatLng(34.0112,-118.4873),
         infoWindow: InfoWindow(
           title: "North Gym",
           //snippet: ""
         ),
    ),//34.010829,-118.487066
    Marker(
      markerId: MarkerId("South Gym"),
      icon: BitmapDescriptor.defaultMarker,
         position: LatLng(34.010539,-118.486558),
         infoWindow: InfoWindow(
           title: "South Gym",
           //snippet: ""
         ),
    ),
    Marker(
      markerId: MarkerId("Pool"),
      icon: BitmapDescriptor.defaultMarker,
         position: LatLng(34.010829,-118.487066),
         infoWindow: InfoWindow(
           title: "The Pool",
           //snippet: ""
         ),
    ),//34.010539,-118.486558
    Marker(
      markerId: MarkerId("Cafeteria"),
      icon: BitmapDescriptor.defaultMarker,
         position: LatLng(34.011295,-118.485936),
         infoWindow: InfoWindow(
           title: "Cafeteria",
           //snippet: ""
         ),
    )
  };
  // buildings.add(constructionZone);

//34.012108,-118.485392
  Set<Marker> rooms = {
    Marker(
      markerId: MarkerId("I House Office"),
      position: LatLng(34.013830,-118.486247),
      infoWindow: InfoWindow(
        title: "I House Office",
        snippet: "Located on the second floor of the Innovation building"
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ),
     Marker(
      markerId: MarkerId("M House Office"),
      position: LatLng(34.012058,-118.485748),
      infoWindow: InfoWindow(
        title: "M House Office",
        snippet: "Located on the first floor of the History building"
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ),
    Marker(
      markerId: MarkerId("O House Office"),
      position: LatLng(34.012558,-118.485775),
      infoWindow: InfoWindow(
        title: "O House Office",
        snippet: "Located on the first floor of the Buisiness building near the main entrance, at B122"
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ),
    Marker(
      markerId: MarkerId("S House Office"),
      position: LatLng(34.011429,-118.485271),
      infoWindow: InfoWindow(
        title: "S House Office",
        snippet: "Located on the second floor of the Language building"
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ),
     Marker(
      markerId: MarkerId("H House Office"),
      position: LatLng(34.012354,-118.485239),
      infoWindow: InfoWindow(
        title: "H House Office",
        snippet: "Located on the first floor of the English building"
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ),
    Marker(
      markerId: MarkerId("Main Office"),
      position: LatLng(34.011562,-118.486354),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      infoWindow: InfoWindow(
        title: "Main Office",
        snippet: "The office of Dr.Shelton"
      ),
    ),
    Marker(
      markerId: MarkerId("Library"),
      position: LatLng(34.011731,-118.484778),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      infoWindow: InfoWindow(
        title: "Library",

        snippet: "The second floor Language Building"
      ),
    ),
    Marker(
      markerId: MarkerId("ASB"),
      position: LatLng(34.012220,-118.486247),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      infoWindow: InfoWindow(
        title: "ASB Room",
        snippet: "The room of our Student Council"
      ),
    ),
    Marker(
      markerId: MarkerId("Art"),
      position: LatLng(34.012108,-118.485392),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      infoWindow: InfoWindow(
        title: "Art Gallery",
       //snippet: "The room of our Student Council"
      ),
    )

//34.011429,-118.485271
  };
  GoogleMap googleMap(Set<Marker> buildings) {
    return GoogleMap(
   compassEnabled: true,
   
   initialCameraPosition: CameraPosition(target: LatLng(34.012,-118.487),zoom: 17,tilt: 10),
   mapType: MapType.normal,
   myLocationEnabled: true,
   markers: buildings,
   
   
 );
  }
  Widget body =Container(
    color: Colors.white,
    child: Center(child: ColorLoader3(),),
  );
  Widget mapWithRooms =Center(child: ColorLoader3(),);
  Widget mapWithBuildings = Container(
    color: Colors.white,
    child: Center(child: ColorLoader3(),),
  );
  Widget mapWithAll = Container(
    color: Colors.white,
    child: Center(child: ColorLoader3(),),
  );
  
  @override
  void initState() { 
    super.initState();
    setState(() {
      mapWithAll =googleMap(buildings.union(rooms));
      mapWithBuildings = googleMap(buildings);
      mapWithRooms =googleMap(rooms);
      body = mapWithAll;
    });
   // mapWithBuildings = googleMap(buildings) ;
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    body: body,
    floatingActionButton: UnicornDialer(
          parentButtonBackground: Colors.indigoAccent[700],
          hasBackground: false,
          orientation: 1,
          parentButton: Icon(Icons.menu),
          finalButtonIcon: Icon(Icons.close),
          childButtons: [
             UnicornButton(
              hasLabel: true,
              labelText: "All",
              currentButton: FloatingActionButton(
                mini: true,
                backgroundColor: Color(0xFFFE304F),
                //foregroundColor: Colors.white,
                child: Container(child:Image.asset("assets/university.png",color: Colors.white,),padding: EdgeInsets.only(left:7,right: 7,top: 4,bottom: 10),),
                onPressed: (){
                  //setState(() {
                    setState(() {
                      body =mapWithAll;
                    });
                 // });
                },
              ),
            ),

            UnicornButton(
              hasLabel: true,
              labelText: "Important Rooms",
              currentButton: FloatingActionButton(
                mini: true,
                backgroundColor: Colors.indigoAccent[700],
                child: Icon(MdiIcons.door),
                onPressed: (){
                  setState(() {
                    body =mapWithRooms;
                  });
                },
              ),
            ),
                     UnicornButton(
              hasLabel: true,
              labelText: "Buildings",
              currentButton: FloatingActionButton(
                mini: true,
                backgroundColor: Color(0xFF4FFE30),
                //foregroundColor: Colors.white,
                child: Container(child:Image.asset("assets/office-block.png",color: Colors.white,),padding: EdgeInsets.only(left:4,right: 4,top: 4,bottom: 6),),
                onPressed: (){
                  //setState(() {
                    setState(() {
                      body =mapWithBuildings;
                    });
                 // });
                },
              ),
            ),

          ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        

     
   );
    return body;
  }
 
}

