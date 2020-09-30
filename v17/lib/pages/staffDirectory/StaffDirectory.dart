import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:v17/components/SliverSearchBar.dart';
import 'package:v17/constants.dart';
import 'package:v17/pages/staffDirectory/teacherSection.dart';

class StaffDirectory extends StatefulWidget {
  @override
  _StaffDirectoryState createState() => _StaffDirectoryState();
}

class _StaffDirectoryState extends State<StaffDirectory> {
  TeacherSection teacherSection;

  @override
  void initState() {
    super.initState();

    this.teacherSection = TeacherSection();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverSearchBar(
          title: "Staff Directory",
          hintText: "Search SAMOHI staff",
          searchFunction: _searchSections,
        ),
        this.teacherSection,
      ],
    );
  }

  void _searchSections(String searchString) {
    this.teacherSection.search = searchString;
  }
}
