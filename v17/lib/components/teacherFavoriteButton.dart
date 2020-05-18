import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mdi/mdi.dart';
import 'package:v17/api/schoolInformation/teacher/teacher.dart';
import 'package:v17/constants.dart';

class TeacherFavoriteButton extends StatefulWidget {
  const TeacherFavoriteButton({
    Key key,
    @required this.teacher,
  }) : super(key: key);

  final Teacher teacher;

  @override
  _TeacherFavoriteButtonState createState() => _TeacherFavoriteButtonState();
}

class _TeacherFavoriteButtonState extends State<TeacherFavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      android: (c) => IconButton(
        icon: Icon(
          widget.teacher.isFavorite ? Icons.star : Icons.star_border,
        ),
        color: widget.teacher.isFavorite ? Colors.yellow : Colors.blue,
        onPressed: setFavorite,
      ),
      ios: (c) => IconButton(
        icon: Icon(
          this.widget.teacher.isFavorite ? Mdi.star : Mdi.starOutline,
          color: this.widget.teacher.isFavorite
              ? CupertinoColors.systemYellow
              : CupertinoColors.activeBlue,
        ),
        onPressed: setFavorite,
      ),
    );
  }

  Future setFavorite() async {
    LocalStorage storage = LocalStorage(LocalStorageKeys.favoriteTeachers);
    await storage.ready;
    List favorites = storage.getItem("favorites") ?? [];
    if (favorites.contains(this.widget.teacher.name)) {
      favorites.remove(this.widget.teacher.name);
    } else {
      favorites.add(this.widget.teacher.name);
    }
    setState(() {
      this.widget.teacher.setFavorite =
          favorites.contains(this.widget.teacher.name);
    });
    storage.setItem("favorites", favorites);
  }
}
