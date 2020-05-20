import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:v17/api/schoolInformation/departments/department.dart';
import 'package:v17/api/schoolInformation/teacher/teacher.dart';
import 'package:v17/api/schoolInformation/teacher/teachers.dart';
import 'package:v17/components/SliverSearchBar.dart';
import 'package:v17/components/teacherListTile.dart';
import 'package:v17/constants.dart';

class DepartmentsPage extends StatefulWidget {
  final Department department;

  DepartmentsPage(this.department);

  @override
  _DepartmentsPageState createState() => _DepartmentsPageState();
}

class _DepartmentsPageState extends State<DepartmentsPage> {
  List<Teacher> departmentTeachers;
  List<Teacher> searchedTeachers;

  @override
  void initState() {
    super.initState();

    this.departmentTeachers = teachers
        .where((element) =>
            element.department.any((element) => element == widget.department))
        .toList();
    this.searchedTeachers = this.departmentTeachers;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isMaterial(context)
          ? null
          : Constants.isBright(context) ? Colors.white : Colors.black,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverSearchBar(
            searchFunction: (String searchString) {
              setState(() {
                try {
                  this.searchedTeachers = this
                      .departmentTeachers
                      .where((element) =>
                          element.shouldIncludeInSearch(searchString))
                      .toList();
                } catch (e) {
                  print(e);
                }
              });
              print(this.searchedTeachers.length);
            },
            title: this.widget.department.name,
          ),
          SliverList(
            delegate: SliverChildListDelegate(List.generate(
                this.searchedTeachers.length,
                (index) => TeacherListTile(
                      teacher: this.searchedTeachers[index],
                    ))),
          )
        ],
      ),
    );
  }
}
