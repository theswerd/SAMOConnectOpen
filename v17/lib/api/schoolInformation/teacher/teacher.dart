import 'package:flutter/foundation.dart';

class Teacher {
  String name;
  String room;
  String website;
  List<String> department;
  String ext;
  String email;
  bool administration;
  bool incomplete;
  String house;

  Teacher({
    @required this.name,
    @required this.department,
    @required this.email,
    this.ext,
    this.room,
    this.website,
    this.administration = false,
    this.house,
    this.incomplete = false,
  });

  bool shouldIncludeInSearch(String searchString) {
    if (this.name.contains(searchString) ||
        this.department.contains(searchString) ||
        this.email.contains(searchString) ||
        (this.ext ?? "").contains(searchString) ||
        (this.website ?? "").contains(searchString) ||
        (this.website ?? "").contains(searchString)) {
      return true;
    } else {
      return false;
    }
  }
}
