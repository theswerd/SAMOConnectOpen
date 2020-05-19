import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:v17/api/illuminate/illuminate.dart';

class Gradebook {
  final List<Class> classes;

  Gradebook({
    @required this.classes,
  });
}

class Class {
  final String name;
  final String grade;
  final double percent;
  final String lastUpdated;
  final String url;
  final String teacher;
  final Color color;

  Class({
    @required this.name,
    @required this.grade,
    @required this.percent,
    @required this.lastUpdated,
    @required this.url,
    @required this.teacher,
    @required this.color,
  });

  factory Class.fromHTML(dom.Element grade /*CLASS*/) {
    Color color;
    double gradePercent;

    //PARSING COLOR
    try {
      color = Color(
        int.parse(
          "0xff" +
              grade.attributes['style']
                  .split("#")
                  .last
                  .toString()
                  .toLowerCase(),
        ),
      );
    } catch (e) {
      color = Colors.black;
    }

    //PARSING PERCENT
    try {
      gradePercent = double.parse(
        grade.children.first.innerHtml
            .split(" ")
            .last
            .split('%')
            .first
            .toString(),
      );
    } catch (e) {
      gradePercent = 100;
    }

    return Class(
      name: grade.children[1]?.innerHtml ?? "",
      url: grade.children[2].children.first.attributes['href'],
      lastUpdated: grade.children[4].innerHtml ?? "",
      teacher: grade.children[3].innerHtml,
      grade: grade.children.first.innerHtml.split(" ")?.first ?? "",
      color: color,
      percent: gradePercent,
    );
  }

  List<Assignment> assignments;

  Future<bool> loadAssignments(String token) {}
  // int get aces {}

  // int get missings {}
}

class Assignment {
  final String name;
  final String total;

  Assignment(this.name, this.total);
}
