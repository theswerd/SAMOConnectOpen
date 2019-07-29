
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:share/share.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rounded_modal/rounded_modal.dart';
class Constants{
  static Future<void> shareString(String shareStr) => Share.share(shareStr);
  static Color baseColor = Colors.indigoAccent[700];
  static void giveARating() {
    LaunchReview.launch(
      iOSAppId: "1465501734",
      androidAppId: "com.swerd.SamoConnect"
    );
  }
  static CupertinoActionSheetAction cancelAction(BuildContext context){
    return CupertinoActionSheetAction(
      isDestructiveAction: true,
      child: Text("Cancel"),
      onPressed: (){
        Constants.pop(context);
      },
    );
  }
  static void showInfoBottomSheet(List<CupertinoActionSheetAction> theactions, BuildContext context){
    showCupertinoModalPopup(
      context: context,
      builder: (c){
        return CupertinoActionSheet(
          
          actions: theactions,
          title: Text("Extra Info"),
          cancelButton: CupertinoActionSheetAction(
            
            child: Text("Cancel"),
            isDestructiveAction: true,
            onPressed: (){
              Constants.pop(context);
            },
          ),
        );
      }
    );
  }
  static CupertinoActionSheetAction ratingAction(BuildContext context) {
    return CupertinoActionSheetAction(
      child: Text("Give Us A Good Rating?"),
      onPressed: (){
        Navigator.of(context).pop();
        Constants.giveARating();
      },
    );
  }
  static Text basicText(String theText){
    return Text(theText,style: TextStyle(color: Colors.black));
  }
  static CupertinoActionSheetAction officialWebsiteAction(BuildContext context, String officialWebsite) {
    return CupertinoActionSheetAction(
      child: Text("Official Website"),
      onPressed: (){
        Navigator.of(context).pop();
        launch(officialWebsite);
      },
    );
  }
  static void pop(BuildContext context){
    Navigator.of(context).pop();
  }
  static CupertinoActionSheetAction actionWithPop(BuildContext context, String title, String url) {
    return CupertinoActionSheetAction(
      child: Text(title),
      onPressed: (){
        Navigator.of(context).pop();
        launch(url);
      },
    );
  }
}