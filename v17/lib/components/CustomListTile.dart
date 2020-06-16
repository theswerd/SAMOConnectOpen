import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v17/constants.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String trailingText;
  final Widget trailingWidget;
  final TextStyle trailingTextStyle;
  final Function onPressed;
  bool get trailingIsWidget => trailingWidget != null;

  CustomListTile({
    @required this.title,
    this.subtitle = "",
    this.trailingText = "",
    this.trailingWidget,
    this.trailingTextStyle = const TextStyle(),
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      //onTap: this.onPressed,
      onTap: this.onPressed,
      child: Column(
        children: <Widget>[
          Divider(height: 1, color: Colors.grey[300]),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      this.title,
                      style: TextStyle(
                        color: Constants.lightMBlackDarkMWhite(
                          context,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    this.trailingIsWidget
                        ? this.trailingWidget
                        : Text(
                            this.trailingText,
                            style: TextStyle(
                              color: CupertinoTheme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.grey[850]
                                  : Colors.grey[500],
                            ).merge(
                              this.trailingTextStyle,
                            ),
                          ),
                  ],
                ),
                if (this.subtitle.isNotEmpty)
                  Text(
                    this.subtitle,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      height: 1.2,
                      color: Constants.isBright(context)
                          ? Colors.grey[800]
                          : Colors.grey[350],
                    ),
                  )
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey[350]),
        ],
      ),
    );
  }
}
