import 'package:flutter/material.dart';
import 'package:v17/components/CustomListTile.dart';
import 'package:v17/components/pageWithHeader.dart';
import 'package:v17/constants.dart';

class DevelopedBy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageWithHeader(
      title: "Developers",
      body: <Widget>[
        SliverList(delegate: SliverChildListDelegate.fixed([
          CustomListTile(title: "Benjamin Swerdlow", trailingText: "Founder/\nLead developer", subtitle: " - Created SAMOHI Connect in 9th grade\n - Developed versions v0-v9 on his own\n - Leads current development team",),
          CustomListTile(title: "Jason Telanoff", trailingText: "Developer", subtitle: " - Translated app to Espanól\n - Assisted in developing ______",),
          CustomListTile(title: "Henry Marks", trailingText: "Developer", subtitle: " - Assisted in developing ______",),
          CustomListTile(title: "Jessica Golden", trailingText: "Designer", subtitle: " - Designed Logo",),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Thank you so much to all of our users and to the people who inspired this project.", textAlign: TextAlign.center, style: TextStyle(color: Constants.lightMBlackDarkMWhite(context).withOpacity(.9)),),
          )
        ]))
      ],
    );
  }
}