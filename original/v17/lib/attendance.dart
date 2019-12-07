import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';

class Attendance extends StatefulWidget {
 static String tag = "attendancePage";
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  double fontSize = 15;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance"),
        backgroundColor: Colors.indigoAccent[700],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            color: Colors.white,
            splashColor: Colors.yellowAccent,
            onPressed: (){
              Share.share("Think your in trouble for being late? Check the attendance policy on SAMO Connect -- https://samoconnect.page.link/SamoConnect");
            },
          ),
          IconButton(
            icon: Icon(Icons.info_outline),
            splashColor: Colors.yellow,
            onPressed: (){
              showCupertinoModalPopup(
                context: context,
                builder: (c){
                  return CupertinoActionSheet(
                    title: Text("Extra Info"),
                    cancelButton: CupertinoActionSheetAction(
                      child: Text("Cancel",style:TextStyle(color:Colors.red)),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                    actions: <Widget>[
                      CupertinoActionSheetAction(
                        child: Text("Official Attendance Policy"),
                        onPressed: (){
                          launch("http://www.samohi.smmusd.org/Admin/attendance.html");
                        },
                      ),
                      CupertinoActionSheetAction(
                        child: Text("Education Code 48205"),
                        onPressed: (){
                          launch("http://www.nphs.org/news/pdf/AttendanceCAEDCode.pdf");
                        },
                      ),
                      CupertinoActionSheetAction(
                      child: Text("Give Us A Good Rating?"),
                      onPressed: (){
                        Navigator.of(context).pop();
                        LaunchReview.launch(
                          iOSAppId: "1465501734"
                        );
                        //launch("https://api.mapbox.com/styles/v1/swerd/cjw4hcm3u1xkd1cnw1zswdrub.html?fresh=true&title=true&access_token=pk.eyJ1Ijoic3dlcmQiLCJhIjoiY2p3NGV3bzBnMWhnaDQ5cXZlMHgzZG5rNyJ9.d_agU8wGRZYZUHOmrrHBjQ#16.1/34.011844/-118.486192/0");
                      },
                    ),
                    ],
                  );
                }
              );
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
        children: <Widget>[
          ListTile(
            title: Text("Basic Information"),
            subtitle: Text("Overview"),
            leading: Container(child:Image.asset("assets/university.png"),height: 30,width: 30,),
          ),
          Container(
            child:Text(
              """Students must attend class unless excused by an administrator at the request of a parent or teacher, or the student is participating in a school-related activity.  Students are responsible to attend all classes, to be on time, and to come prepared for instruction.\n\nSamohi’s attendance policy requires students to make up unexcused absences once they accrue 12 or more period absences. They can make up these absences by attending Super Saturday/Tutoring/On Campus Community Service etc. Making up unexcused absences does not clear attendance from Illuminate as this is legal documentation of classroom attendance. Due to state and district policies, students will continue to receive notifications from the district regarding excessive absences/truancy.\n\nAll students returning from an absence must first report to their House Office.\n\n""",
              style: TextStyle(color: Colors.black,fontSize: fontSize),
              ),
            padding: EdgeInsets.symmetric(horizontal: 15),
            ),
             ListTile(
            title: Text("Excused Absenses"),
            leading: Icon(Icons.check,color: Colors.green,),
            subtitle: Text("A student's absence shall be excused for the following reasons"),
          ),
          Container(
            child:Text("""1. Personal illness (Education Code 48205)\n\n2. Quarantine under the direction of a county or city health officer (Education Code 48205)\n\n3. Medical, dental, optometric, or chiropractic appointment (Education Code 48205)\n\n4.Attendance at funeral services for a member of the immediate family*, which shall be limited to one day if the service is conducted in California or three days if the service is conducted out of state. (Education Code 48205)\n\n5.Jury duty in the manner provided by law (Education Code 48205)\n\n6.The illness or medical appointment during school hours of a child to whom the student is the custodial parent (Education Code 48205)\n\n7.Upon advance written request by the parent/guardian and the approval of the principal or designee, justifiable personal reasons including, but not limited to: (Education Code 48205) \n\t\t\ta. Appearance in court\n\t\t\tb. Attendance at a funeral service\n\t\t\tc. Observation of a holiday or ceremony of his/her religion\n\t\t\td. Attendance at religious retreats not to exceed four hours per semester\n\t\t\te. Attendance at an employment conference\n\t\t\tf. Attendance at an educational conference on the legislative or judicial process offered by a nonprofit organization\n\n8. Service as a member of a precinct board for an election pursuant to Elections Code 12302 (Education Code 48205)\n\n9. Participation in religious exercises or to receive moral and religious instruction in accordance with district policy (Education Code 46014)\n\n""",
              style: TextStyle(color: Colors.black,fontSize: fontSize),
              ),
            padding: EdgeInsets.symmetric(horizontal: 15),
            ),
          ListTile(
            title: Text("Unexcused Absenses"),
            leading: Icon(Icons.close,color: Colors.red,),
          ),
          Container(
            child:Text("""Parent Excuse:  An absence with parental permission but not under the "excused absence" section.  Absences to visit relatives or to attend a marriage or vacation are considered unexcused absences. The student may be allowed to make up missed assignments, at the discretion of the teacher.\n\nTruancy:  An absence from class or classes without the parent's or school's knowledge or prior permission.  A student will receive a “C” (for “cut”) for each class missed and will not be allowed to make up missed work.  Students who exhibit a continual problem with attendance will be referred to the Student Attendance Review Board (SARB).\n\nSuspension:  The temporary removal of a student from school, one to five days in length. Schoolwork may be made up, at the discretion of the teacher.\n\nEmergency Disaster:  An emergency due to fire, flood, or major disaster.  Students will be allowed to make up the work.""",
              style: TextStyle(color: Colors.black,fontSize: fontSize),
              ),
            padding: EdgeInsets.symmetric(horizontal: 15),
            ),
        ],
      ),
    );
  }
}
