import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:v17/components/CustomListTile.dart';
import 'package:v17/components/pageWithHeader.dart';
import 'package:v17/constants.dart';
import 'package:v17/pages/developedBy.dart';

class LegalPage extends StatefulWidget {
  @override
  _LegalPageState createState() => _LegalPageState();
}

class _LegalPageState extends State<LegalPage> {
  String versionStr = "";

  @override
  void initState() {
    super.initState();

    getVersionStr();
  }

  @override
  Widget build(BuildContext context) {
    return PageWithHeader(
      title: "About the App",
      body: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate.fixed([
          Container(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "© 2020 Benjamin Swerdlow",
                  style: TextStyle(
                      color: Constants.lightMBlackDarkMWhite(context)),
                ),
                Text(
                  "\nSAMOHI Connect is not affiliated with SMMUSD in  any way. We are a completely student run project.",
                  style: TextStyle(
                      color: Constants.lightMBlackDarkMWhite(context)),
                ),
                Text("\nVersion " + this.versionStr ?? "",
                    style: TextStyle(
                        color: Constants.lightMBlackDarkMWhite(context)))
              ],
            ),
            color:
                Constants.isBright(context) ? Colors.white : Colors.grey[900],
          ),
          Container(height: 25),
          CustomListTile(title: "Developed By", onPressed: ()=>Navigator.of(context).push(
            isMaterial(context)?MaterialPageRoute(builder: (c)=>DevelopedBy()):CupertinoPageRoute(builder: (c)=>DevelopedBy())
          ),)
        ]))
      ],
    );
  }

  void getVersionStr() async{
    String packageVersion = await Constants.packageVersion(context);
    setState(() {
      this.versionStr = packageVersion;
    });
  }
}
