import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';

class Constants {
  static void giveARating() {
    LaunchReview.launch(
      iOSAppId: "1465501734",
      androidAppId: "com.swerd.SamoConnect"
    );
  }
}