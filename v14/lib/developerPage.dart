import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';
import 'constants.dart';

class DeveloperPage extends StatefulWidget {
 static String tag = "developerPage";
  @override
  _DeveloperPageState createState() => _DeveloperPageState();
}

class _DeveloperPageState extends State<DeveloperPage> {
  double fontSize = 15;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Developed By"),
        backgroundColor: Colors.indigoAccent[700],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            color: Colors.white,
            splashColor: Colors.yellowAccent,
            onPressed: (){
              Share.share("Wanna know about SAMO Connect? Check out the developer page! -- https://samoconnect.page.link/SamoConnect");
            },
          ),
          IconButton(
            icon: Icon(Icons.info_outline),
            splashColor: Colors.yellow,
            onPressed: (){
                          
              },
          ),
          IconButton(
            icon: Icon(Icons.format_size),
            splashColor: Colors.yellow,
            onPressed: (){
              if(fontSize==15){
                setState(() {
                  fontSize= 20;
                });
              }else{
                setState(() {
                  fontSize = 15;
                });
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: <Widget>[
          Text(
            "Main Developers",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),
          ),
          Container(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset("assets/ofMap.gif"),
                )
              ],
            ),
          )
        ],
      )
      
    );
  }
}
