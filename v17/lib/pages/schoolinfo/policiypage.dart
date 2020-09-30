import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:v17/components/pageWithHeader.dart';

// ignore: must_be_immutable
class Policy extends StatelessWidget {
  String awnser =
      "Students must attend class unless excused by an administrator at the request of a parent or teacher, or the student is participating in a school-related activity.  Students are responsible to attend all classes, to be on time, and to come prepared for instruction.";
  @override
  Widget build(BuildContext context) {
    return PageWithHeader(title: "Policy", body: <Widget>[
      SliverList(
          delegate: SliverChildListDelegate([
        Policies(
          text: awnser,
          title: "Attendence",
        ),
        Policies(
          text: "dskfjkdsjfskjdkjkfjkdjsfkjksjkdfjkjfkjdskjfkj",
          title: "Attendence",
        )
      ]))
    ]);
  }
}

// ignore: must_be_immutable
class Policies extends StatelessWidget {
  Policies({@required this.text, @required this.title});
  String text;
  String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: DropdownButton(
          value: 1,
          items: [
            DropdownMenuItem(
              child: Text(title),
              value: 1,
            ),
            DropdownMenuItem(
              child: Text(text),
              value: 2,
            ),
          ],
          onChanged: (_) {}),
    );
  }
}
