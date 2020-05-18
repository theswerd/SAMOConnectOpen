import 'package:flutter/foundation.dart';
import 'package:v17/api/schoolInformation/departments/department.dart';

class Teacher {
  String name;
  String room;
  String website;
  List<Department> department;
  String ext;
  String email;
  bool administration;
  bool incomplete;
  String house;
  bool isFavorite = false;

  set setFavorite(bool favorite) {
    this.isFavorite = favorite;
  }

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
    if (this.name.toLowerCase().contains(searchString.toLowerCase()) ||
        this.department.any((element) =>
            element.name.toLowerCase().contains(searchString.toLowerCase())) ||
        this.email.toLowerCase().contains(searchString.toLowerCase()) ||
        (this.ext ?? "").toLowerCase().contains(searchString.toLowerCase()) ||
        (this.website ?? "").toLowerCase()
            .contains(searchString.toLowerCase()) ||
        searchString.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool get hasWebsite {
    return (website ?? "").isNotEmpty;
  }
}
