import 'package:flutter/material.dart';
import 'package:v17/components/pageWithHeader.dart';
import 'package:v17/pages/schoolinfo/policiypage.dart';
import "package:v17/components/CustomListTile.dart";
import '../../constants.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageWithHeader(title: "Information", body: <Widget>[
      SliverList(
          delegate: SliverChildListDelegate([
        CustomListTile(title: "Policy"),
        CustomData(
          name: "Policy's",
          routingpage: Policy(),
        ),
        CustomData(
          name: "Bell Schedule",
          routingpage: null,
        ),
        CustomData(
          name: "Map",
          routingpage: null,
        ),
        CustomData(
          name: "Whatever",
          routingpage: null,
        ),
        CustomData(
          name: "Whatever",
          routingpage: null,
        ),
        CustomData(
          name: "Whatever",
          routingpage: null,
        ),
        CustomData(
          name: "Whatever",
          routingpage: null,
        ),
        CustomData(
          name: "Whatever",
          routingpage: null,
        ),
        CustomData(
          name: "Whatever",
          routingpage: null,
        ),
        CustomData(
          name: "Whatever",
          routingpage: null,
        ),
      ]))
    ]);
  }
}

class CustomData extends StatelessWidget {
  CustomData({
    @required this.name,
    @required this.routingpage,
  });

  final String name;
  final dynamic routingpage;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: InkWell(
          child: Container(
              color: Constants.isBright(context)
                  ? Colors.grey[200]
                  : Colors.grey[800],
              height: MediaQuery.of(context).size.height / 16,
              child: Center(
                child: Text(
                  name,
                  textScaleFactor: 1.5,
                ),
              )),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => routingpage),
            );
          },
        ));
  }
}
