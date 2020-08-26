import 'package:flutter/material.dart';
import 'package:v17/components/pageWithHeader.dart';
import 'package:v17/pages/schoolinfo/schooldata.dart';
import 'package:v17/pages/schoolinfo/policiypage.dart';

var data = new SchoolData();

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageWithHeader(title: "Information", body: <Widget>[
      SliverList(
          delegate: SliverChildListDelegate([
        Padding(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                    color: Colors.blue,
                    height: MediaQuery.of(context).size.height / 5,
                    child: Center(
                      child: Text(
                        data.policies,
                        textScaleFactor: 1.5,
                      ),
                    )),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Policy()),
                );
              },
            ))
      ]))
    ]);
  }
}
