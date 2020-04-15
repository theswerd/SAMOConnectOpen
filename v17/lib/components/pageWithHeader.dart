import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:v17/components/topBar.dart';

class PageWithHeader extends StatelessWidget {
  PageWithHeader({@required this.title, @required this.body, this.titleBig = true});
  final String title;
  final bool titleBig;
  final List<Widget> body;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isMaterial(context)?null:Colors.transparent,
      child: CustomScrollView(
        slivers: <Widget>[TopBar(this.title,), ...this.body],
      ),
    );
  }
}
