import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:v17/components/pageWithHeader.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageWithHeader(
      title: "News",
      body: [
        PlatformWidget(
          ios: (c) => CupertinoSliverRefreshControl(),
          android: (c)=>SliverToBoxAdapter(child: Container(),),
         
        )
      ],
    );
  }
}
