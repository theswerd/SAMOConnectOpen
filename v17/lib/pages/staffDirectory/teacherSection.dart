import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:v17/api/schoolInformation/teacher/teacher.dart';
import 'package:v17/api/schoolInformation/teacher/teachers.dart';
import 'package:v17/components/teacherListTile.dart';
import 'package:v17/constants.dart';

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
  LocalStorage localStorage;
  @override
  void initState() {
    super.initState();
    teacherList = teachers;

    getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        List.generate(
          teacherList.length,
          (index) {
            Teacher teacher = this.teacherList[index];
            return TeacherListTile(
              teacher: teacher,
            );
          },
        ),
      ),
    );
  }

  set search(String searchString) {
    try {
      setState(() {
        teacherList = teachers
            .where(
              (element) => element.shouldIncludeInSearch(
                searchString,
              ),
            )
            .toList();
      });
    } catch (e) {}
  }

  void getFavorites() async {
    this.localStorage = new LocalStorage(LocalStorageKeys.favoriteTeachers);
    await this.localStorage.ready;
    List favorites = this.localStorage.getItem("favorites") ?? [];
    favorites.forEach(
      (teacherName) {
        int index = this.teacherList.indexWhere(
              (teacher) => teacher.name == teacherName,
            );
        setState(
          () {
            this.teacherList[index].setFavorite = true;
          },
        );
      },
    );
    orderTeachers();
  }

  void orderTeachers() {
    setState(
      () {
        this.teacherList.sort((a, b) {
          return !a.isFavorite ? 1 : 0;
        });
        Teacher first = this.teacherList.first;
        this.teacherList.removeAt(0);
        this.teacherList.add(first);
      },
    );
  }
}
