import 'package:flutter/foundation.dart';

class Teacher {
  String name;
  String room;
  String website;
  List<String> department;
  String ext;
  String email;

  Teacher({
    @required this.name,
    @required this.department,
    @required this.email,
    @required this.ext,
    this.room,
    this.website,
  });
}
