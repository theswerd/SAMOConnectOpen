import 'package:flutter/foundation.dart';

class Assignment {
  final String name;
  final String gradeString;
  final String dueString;
  final String category;
  final String pointsString;
  final bool graded;
  final bool missing;
  final bool extraCredit;
  final bool ace;

  Assignment({
    @required this.name,
    @required this.gradeString,
    @required this.dueString,
    @required this.category,
    @required this.pointsString,
    @required this.graded,
    @required this.missing,
    @required this.extraCredit,
    @required this.ace,
  });
}
