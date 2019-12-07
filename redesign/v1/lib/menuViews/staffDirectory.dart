import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:localstorage/localstorage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:v1/config.dart';
import 'package:vibrate/vibrate.dart';

class StaffDirectory extends StatefulWidget {
  @override
  _StaffDirectoryState createState() => _StaffDirectoryState();
}

class _StaffDirectoryState extends State<StaffDirectory> with TickerProviderStateMixin{
  Widget body;
  Widget title;
  bool isSearching;
  FloatingActionButton floatingActionButton;
  List<Teacher> teachers;
  List<Teacher> activeTeachers;

  AnimationController searchButtonAnimationController;

  @override
  void initState() {
    super.initState();
    body = Center(child: CircularProgressIndicator());
    title = Text("Staff Directory");
    floatingActionButton = loadingFloatingActionButton;

    searchButtonAnimationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400)
    );
    isSearching = false;

    getTeachers();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AnimatedSwitcher(
        duration: Duration(milliseconds: 400),
        child: title,
      )),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
  getTeachers()async{
    Future<Response> teachersRaw = get("http://www.samohi.smmusd.org/Admin/staff.html");
    bool hasError = false;
    teachersRaw.catchError((error){
      print("ERROR");
      print(error);
      hasError = true;
    });
    if(hasError){
      setState(() {
        body = Column(
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
                getTeachers();
              },
            )
          ],
        );
      });
      return;
    }
    Response response = await teachersRaw;
    String data = response.body;
    dom.Document doc = parse(data);
    List teachersData = doc.body.children[0].children[0].children[0].children.last.children[0].children.last.children[0].children;
    teachersData.removeAt(0);
    try {
      teachers = parseTeacherData(teachersData);
      activeTeachers = teachers;
    } catch (e) {
      setState(() {
        body = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("We couldn't understand the schools staff directory", textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
            Divider(),
            RaisedButton(
              child: Text("Try again?"),
              onPressed: (){
                setState(() {
                  body = Center(child: CircularProgressIndicator());
                });
                getTeachers();
              },
            )
          ],
        );
      });
    }
    //FINISHED GETTING DATA
    setState(() {
      body = teacherListView();
      floatingActionButton = searchButton();
    });
  }
  FloatingActionButton searchButton(){
    return FloatingActionButton(
      child: AnimatedIcon(
        icon: AnimatedIcons.search_ellipsis,
        progress: searchButtonAnimationController,
      ),
      onPressed: (){
        Widget newTitle;
        FocusNode focusNode = new FocusNode();

        if(isSearching){
          isSearching = false;
          searchButtonAnimationController.reverse();
          newTitle = Text("Staff Directory");
          setState(() {
            title = newTitle;
          });
        }else{
          isSearching = true;
          searchButtonAnimationController.forward();
          newTitle = Padding(
            padding: const EdgeInsets.symmetric(vertical:8.0),
            child: TextField(
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: "Search Staff",
                border: UnderlineInputBorder()
              ),
              onChanged: (v){
                activeTeachers = [];
                print("SEARCH ACTIVE");
                for (Teacher teacher in teachers) {
                  if(
                    teacher.name.toUpperCase().contains(v.toUpperCase())//||
                    // teacher.room.toUpperCase().contains(v.toUpperCase())||
                    // teacher.department.toUpperCase().contains(v.toUpperCase())||
                    // teacher.email.toUpperCase().contains(v.toUpperCase())||
                    // teacher.ext.toUpperCase().contains(v.toUpperCase())){
                  ){
                    print(teacher.name);
                    activeTeachers.add(teacher);
                  }
                }
                setState(() {
                  body = teacherListView();
                });
              },
            ),
          );
          setState(() {
            title = newTitle;
            FocusScope.of(context).requestFocus(focusNode);
          });
        }
        
      },
    );
  }
  ListView teacherListView(){
    return ListView.separated(
      
      padding: EdgeInsets.all(30),
      itemCount: activeTeachers.length,
      separatorBuilder: (c,i)=>Container(height: 30),
      itemBuilder: (c,i)=>RaisedButton(
        padding: EdgeInsets.all(20),
        elevation: 25,
        onPressed: (){},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(activeTeachers[i].name, style: TextStyle(fontSize: 20)),
              Text(activeTeachers[i].room, style: TextStyle(fontSize: 18))
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Ext: " + activeTeachers[i].ext, style: TextStyle(fontSize: 18)),
              Text(activeTeachers[i].house, style: TextStyle(fontSize: 18))
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SelectableText(
                activeTeachers[i].email,
                style: TextStyle(fontSize: 20, color: Colors.blue),
                onTap: (){
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc){
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Wrap(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(activeTeachers[i].name+"'s email is "+teachers[i].email, style: TextStyle(fontSize: 18),),
                            ),
                            ListTile(
                              trailing: Icon(Icons.share),
                              title: Text('Share'),
                              onTap: () async{
                                Navigator.pop(context);
                                await Share.share(activeTeachers[i].name+"'s email is "+teachers[i].email);
                                Vibrate.feedback(FeedbackType.success);
                              }          
                            ),
                            ListTile(
                              trailing: Icon(Icons.content_copy),
                              title: Text('Copy'),
                              onTap: () {
                                 Navigator.pop(context);
                                 Clipboard.setData(ClipboardData(text: activeTeachers[i].email));
                                 Vibrate.feedback(FeedbackType.success);
                              },          
                            ),
                          ],
                        ),
                      );
                      },
                    );
                  }
                ),
              //Text(teachers[i].email, style: TextStyle(fontSize: 18)),
              activeTeachers[i].hasWebsite()?FloatingActionButton(
                mini: true,
                child: Icon(MdiIcons.linkVariant),
                heroTag: i.toString(),
                tooltip: "Launch "+activeTeachers[i].name+"'s website",
                onPressed: ()=>launch(activeTeachers[i].website)
                ,
              ):Container()
            ],
          ),
        ],),
      ),
    );
  }
  parseTeacherData(List teachers){
    print("Parsing teacher data");
    List<Teacher> teachersList = new List();
    try {
      for (dom.Element teacherEl in teachers) {
        try {
          Teacher teacher;
          String teacherNameUnformatted = teacherEl.children.first.firstChild.text;
          String teacherNameFormatted = teacherNameUnformatted.split(", ").last+" "+teacherNameUnformatted.split(", ").first;
          String ext = teacherEl.children[1].text;
          String room = teacherEl.children[2].text;
          String dep = teacherEl.children[3].text;

          String house;
          try {
            house = teacherEl.children[4].text.toString();
          } catch (e) {
            house = "";
          };
          String email = teacherEl.children[5].text;
          print(teacherNameFormatted);
          String website; 
          bool hasWebsite = false;
          try {
            if(teacherEl.children.first.children.last.attributes.containsKey('href')){
              website = teacherEl.children.first.children.last.attributes['href'];
              hasWebsite = true;
            }
          } catch (e) {}
          print(teacherNameFormatted);
          print(ext);
          print(room);
          print(dep);
          print(house);
          print(email);
          print("Website");
          print(website);
          teacher = new Teacher(
            name: teacherNameFormatted,
            department: dep,
            ext: ext,
            email: email,
            house: house,
            room: room,
            website: hasWebsite?website:null
          );
          teachersList.add(teacher);
        } catch (e) {
          print("ERROR PARSING TEACHER");
          print(e);
        }
      }

    } catch (e) {
      throw("Error Parsing teacher data");
    }
    return teachersList;
  }
  FloatingActionButton loadingFloatingActionButton = FloatingActionButton(
    child: CircularProgressIndicator(backgroundColor: Colors.white,),
    onPressed: (){},
  );
}

class Teacher{
  String name;
  String room;
  String department;
  String house;
  String ext;
  String email;
  String website;
  Teacher(
    {
      @required this.name,
      @required this.ext,
      @required this.email,
      @required this.room,
      @required this.department,
      @required this.house,
      this.website
    }
  );

  bool hasWebsite()=>website!=null;
}