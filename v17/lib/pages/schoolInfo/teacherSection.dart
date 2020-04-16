import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:v17/api/schoolInformation/teacher/teacher.dart';
import 'package:v17/api/schoolInformation/teacher/teachers.dart';
import 'package:v17/constants.dart';

class TeacherSection extends StatefulWidget {
  @override
  _TeacherSectionState createState() => _TeacherSectionState();
}

class _TeacherSectionState extends State<TeacherSection> {
  String searchString;
  List<Teacher> teacherList = teachers;
  @override
  void initState() {
    super.initState();
    this.searchString = "";
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate:
          SliverChildListDelegate(List.generate(teacherList.length, (index) {
        Teacher teacher = teacherList[index];
        return PlatformWidget(
          ios: (c) {
            return Material(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 4),
                    child: Text(
                      teacher.name,
                      style: TextStyle(
                          color: Constants.isBright(context)?Colors.grey[800]:Colors.grey[300],
                          fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.start,
                      children: List.generate(
                        teacher.department.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 4.0, right: 4.0),
                          child: Chip(
                            label: Text(teacher.department[index]),
                            backgroundColor: Colors.blueAccent,
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                      height: 1,
                      color: Constants.isBright(context)?Colors.grey[500]:Colors.grey[300]),
                ],
              ),
            );
          },
          android: (c) {
            return ListTile(
              title: Text(teacher.name),
              subtitle: Text(teacher.department.join(", ")),
            );
          },
        );
      })),
    );
  }

  set search(String searchString) {
    setState(() {
      this.searchString = searchString;
    });
  }
}
