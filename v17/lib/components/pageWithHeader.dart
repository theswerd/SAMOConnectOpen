import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:v17/components/topBar.dart';

class PageWithHeader extends StatelessWidget {
  PageWithHeader({@required this.title, @required this.body});
  final String title;
  final List<Widget> body;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: CustomScrollView(
        slivers: <Widget>[TopBar(this.title), ...this.body],
      ),
    );
  }
}
