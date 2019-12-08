//
//clubs.removeAt(0); 
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';

class ClubDirectory extends StatefulWidget {
  @override
  _ClubDirectoryState createState() => _ClubDirectoryState();
}

class _ClubDirectoryState extends State<ClubDirectory> {
  Widget title;
  FloatingActionButton floatingActionButton;
  Widget body;

  List<Club> allClubs = [];
  List<Club> activeClubs = [];

  @override
  void initState() {
    super.initState();
    title = Text("Club Directory");
    floatingActionButton = FloatingActionButton(
      child: CircularProgressIndicator(backgroundColor: Colors.white),
      onPressed: (){},
    );
    body = Center(child: CircularProgressIndicator());
    getClubs();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:AnimatedSwitcher(
          child: title,
          duration: Duration(milliseconds: 400),
        )
      ),
    );
  }
  getClubs() async{
    Future<Response> responseFuture = get("http://www.samohi.smmusd.org/Students/clubs/index.html");
    bool hasError = false;
    responseFuture.catchError((error){
      setState(() {
        body = networkErrorView(getClubs);
      });
      hasError = true;
    });
    if(hasError){
      return;
    }
    Response response = await responseFuture;
    try {
      dom.Document document = parse(response.body);
      List clubsUnformatted = document.body.children[0].children[0].children[0].children[4].children[0].children[0].children[0].children[2].children[0].children[0].children[0].children;
      clubsUnformatted.removeAt(0);
      parseClubs(clubsUnformatted);
    } catch (e) {
      setState(() {
        body = networkErrorView(getClubs);
      });
    } 
  }
  Column networkErrorView(Function reload) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("We are having trouble connecting right now", textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
          Divider(),
          RaisedButton(
            child: Text("Try again?"),
            onPressed: (){
              setState(() {
                body = Center(child: CircularProgressIndicator());
              });
              reload();
            },
          )
        ],
      );
  }

  void parseClubs(List clubsUnformatted) {
    for (dom.Element element in clubsUnformatted) {
      try {
        String name = element.children[0].text.trim();
        String room = element.children[1].text.trim();
        String day  = element.children[2].text.trim();
        String advisor  = element.children[3].text.trim();
        String description = element.children[4].text.trim();
        Club club = Club(
          name: name,
          room: room,
          day: day,
          advisor: advisor,
          description: description
        );
        allClubs.add(club);
      } catch (e) {
      }
      activeClubs = allClubs;

      
      
    }
  }
}

class Club {
  String name;
  String room;
  String day;
  String advisor;
  String description;
  
  Club(
    {
      @required this.name,
      @required this.room,
      @required this.advisor,
      @required this.day,
      @required this.description
    }
  );

}