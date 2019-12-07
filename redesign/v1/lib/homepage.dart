import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'config.dart';

import 'menuViews/staffDirectory.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      title: Text("SAMOHI Connect"),
      frontLayer: Container(),
      backLayer: ListView(children: <Widget>[
        ListTile(
          title: Text("Staff Directory", style: TextStyle(color: Colors.white),),
          subtitle: Text("Find Teachers", style: TextStyle(color: Colors.grey[100])),
          trailing: Icon(MdiIcons.teach, color: Colors.white,),
          onTap: ()=>Navigator.of(context).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              maintainState: true,
              builder: (c)=>StaffDirectory()
            )
          ),
        ),
        ListTile(
          title: Text("Flex Time", style: TextStyle(color: Colors.white),),
          subtitle: Text("Sign Ups", style: TextStyle(color: Colors.grey[100])),
          trailing: Icon(MdiIcons.timer, color: Colors.white),
          onTap: (){},
        ),
        ListTile(
          title: Text("Schedule", style: TextStyle(color: Colors.white),),
          subtitle: Text("School Bell Schedule", style: TextStyle(color: Colors.grey[100])),
          trailing: Icon(MdiIcons.clockOutline, color: Colors.white),
          onTap: (){},
        ),
        ListTile(
          title: Text("Policies", style: TextStyle(color: Colors.white),),
          subtitle: Text("SAMOHI School Policies", style: TextStyle(color: Colors.grey[100])),
          trailing: Icon(MdiIcons.ruler, color: Colors.white),
          onTap: (){},
        ),
        ListTile(
          title: Text("Clubs", style: TextStyle(color: Colors.white),),
          subtitle: Text("Club Directory", style: TextStyle(color: Colors.grey[100])),
          trailing: Icon(MdiIcons.cardsClub, color: Colors.white),
          onTap: (){},
        ),
        ListTile(
          title: Text("Daily Bulletin", style: TextStyle(color: Colors.white),),
          subtitle: Text("Today's Info", style: TextStyle(color: Colors.grey[100])),
          trailing: Icon(MdiIcons.bulletinBoard, color: Colors.white),
          onTap: (){},
        ),
        ListTile(
          title: Text("Clever", style: TextStyle(color: Colors.white),),
          subtitle: Text("For College", style: TextStyle(color: Colors.grey[100])),
          trailing: Icon(MdiIcons.brain, color: Colors.white),
          onTap: (){},
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal:16, vertical: 10),
          child: Row(children: <Widget>[
            Text("Contact your house:", style: TextStyle(fontSize: 16, color: Colors.white),)
          ],),
        ),
        ListTile(
          title: Text("S House", style: TextStyle(color: Colors.white),),
          trailing: Icon(MdiIcons.alphaSCircle, color: Colors.white),
          onTap: (){},
        ),
        ListTile(
          title: Text("M House", style: TextStyle(color: Colors.white),),
          trailing: Icon(MdiIcons.alphaMCircle, color: Colors.white),
          onTap: (){},
        ),
        ListTile(
          title: Text("O House", style: TextStyle(color: Colors.white),),
          trailing: Icon(MdiIcons.alphaOCircle, color: Colors.white),
          onTap: (){},
        ),
        ListTile(
          title: Text("H House", style: TextStyle(color: Colors.white),),
          trailing: Icon(MdiIcons.alphaHCircle, color: Colors.white),
          onTap: (){},
        ),
        ListTile(
          title: Text("I House", style: TextStyle(color: Colors.white),),
          trailing: Icon(MdiIcons.alphaICircle, color: Colors.white),
          onTap: (){},
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal:16, vertical: 10),
          child: Row(children: <Widget>[
            Text("Other:", style: TextStyle(fontSize: 16, color: Colors.white),)
          ],),
        ),
        ListTile(
          title: Text("Settings", style: TextStyle(color: Colors.white),),
          trailing: Icon(MdiIcons.settingsOutline, color: Colors.white),
          onTap: (){},
        ),
        ListTile(
          title: Text("About Us", style: TextStyle(color: Colors.white),),
          subtitle: Text("Get to know the SAMOHI Connect team", style: TextStyle(color: Colors.grey[100])),
          trailing: Icon(MdiIcons.accountGroup, color: Colors.white),
          onTap: (){},
        ),
        ListTile(
          title: Text("Discliamer", style: TextStyle(color: Colors.white),),
          subtitle: Text("Not affiliated with SMMUSD", style: TextStyle(color: Colors.grey[100])),
          trailing: Icon(MdiIcons.scaleBalance, color: Colors.white),
          onTap: (){},
        ),
      ],),
    );
  }
}