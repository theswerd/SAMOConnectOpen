import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mdi/mdi.dart';
import 'package:v17/api/schoolInformation/teacher/teacher.dart';
import 'package:v17/api/schoolInformation/teacher/teachers.dart';
import 'package:v17/components/teacherListTile.dart';
import 'package:v17/constants.dart';
import 'package:v17/pages/schoolInfo/teacherPage.dart';

class TeacherSection extends StatefulWidget {
  _TeacherSectionState childState = _TeacherSectionState();
  set search(String searchValue) {
    childState.search = searchValue;
  }

  @override
  _TeacherSectionState createState() => this.childState;
}

class _TeacherSectionState extends State<TeacherSection> {
  List<Teacher> teacherList;
  @override
  void initState() {
    super.initState();
    teacherList = teachers;
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate:
          SliverChildListDelegate(List.generate(teacherList.length, (index) {
        Teacher teacher = this.teacherList[index];
        return TeacherListTile(teacher: teacher);
      })),
    );
  }

  set search(String searchString) {
    try {
      setState(() {
        teacherList = teachers
            .where((element) => element.shouldIncludeInSearch(searchString))
            .toList();
      });
      print(teacherList.length);
    } catch (e) {}
  }
}
