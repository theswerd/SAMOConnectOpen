import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:v17/components/SliverSearchBar.dart';
import 'package:v17/constants.dart';
import 'package:v17/pages/schoolInfo/teacherSection.dart';

class SchoolInfo extends StatefulWidget {
  @override
  _SchoolInfoState createState() => _SchoolInfoState();
}

class _SchoolInfoState extends State<SchoolInfo> {
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
          title: "School Information",
          hintText: "Search school information",
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
