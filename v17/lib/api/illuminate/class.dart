import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:v17/api/illuminate/assignment.dart';
import 'package:v17/api/illuminate/illuminate.dart';

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

  Future<bool> loadAssignments(String token) async {
    try {
      Response response = await get(
        IlluminateAPI.baseURL + this.url,
        headers: {
          "cookie": token,
        },
      );

      dom.Document html = parse(response.body);
      assignments = _formatGradebook(html);
      return true;
    } catch (e) {
      return false;
    }
  }

  List<Assignment> _formatGradebook(dom.Document html) {
    dom.Element theGradebook = html.getElementById("assignment_list");
    List<dom.Element> theAssignments = theGradebook.children.last.children;
    List<Assignment> formattedAssignments = [];
    for (dom.Element item in theAssignments) {
      String points = item.children[2].text.trim().split("\n").join(" ") ?? "";
      bool missing = item.children[2].text.trim() == "Missing";
      bool ace;
      try {
        ace = points.toString().split("/").first.trim() ==
                points.toString().split("/").last.trim() &&
            points != null &&
            points.split("/").length == 2;

      } catch (e) {
        ace = false;
      }

      bool extraCredit;
      try {
        extraCredit = points.toString().split("/").last.trim() == "-";
      } catch (e) {
        extraCredit = false;
      }

      bool graded;
      try {
        graded = points.toString().split("/").first.trim() != "-";
      } catch (e) {
        graded = true;
      }

      if (missing) {
        ace = false;
      }

      formattedAssignments.add(
        Assignment(
          pointsString: points,
          dueString: item.children[5].text.trim() ?? "",
          extraCredit: extraCredit,
          graded: graded,
          gradeString: item.children[3].text.trim() ?? "",
          category: item.children.first.text ?? "",
          missing: missing,
          ace: ace,
          name: item.children[1].children.first.text.toString(),
        ),
      );
    }
    return formattedAssignments;
  }

  // int get aces {}

  // int get missings {}
}
