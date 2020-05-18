import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter/widgets.dart';

class Flextime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (BuildContext context){
        return Material(
          child: Column(
            children: [
             
            ],
          ),
        );
      },
    );
  }
}