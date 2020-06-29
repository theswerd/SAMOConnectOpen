import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v17/constants.dart';

class CustomListTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final String trailingText;
  final Widget trailingWidget;
  final Widget leadingWidget;
  final Widget expansionSection;
  final TextStyle trailingTextStyle;
  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;
  final EdgeInsets padding;
  final Function onPressed;
  CustomListTile({
    @required this.title,
    this.subtitle = "",
    this.trailingText = "",
    this.trailingWidget,
    this.leadingWidget,
    this.padding = const EdgeInsets.all(12.0),
    this.trailingTextStyle = const TextStyle(),
    this.titleTextStyle = const TextStyle(),
    this.subtitleTextStyle = const TextStyle(),
    this.expansionSection,
    this.onPressed,
  });

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  bool get trailingIsWidget => widget.trailingWidget != null;

  bool expanded;

  @override
  void initState() {
    super.initState();
    expanded = false;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        //onTap: this.onPressed,
        onTap: widget.expansionSection != null
            ? () {
                setState(() {
                  this.expanded = !this.expanded;
                });
                if (widget.onPressed != null) widget.onPressed();
              }
            : widget.onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Divider(
              height: 1,
              color: Colors.grey[300],
            ),
            Padding(
              padding: this.widget.padding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Row(
                        children: [
                          if (widget.leadingWidget != null) ...[
                            widget.leadingWidget,
                            Container(
                              width: 8,
                            )
                          ],
                          Text(
                            this.widget.title,
                            style: this.widget.titleTextStyle.merge(
                                  TextStyle(
                                    color: Constants.lightMBlackDarkMWhite(
                                      context,
                                    ),
                                  ),
                                ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      this.trailingIsWidget
                          ? this.widget.trailingWidget
                          : Text(
                              this.widget.trailingText,
                              style: TextStyle(
                                color: CupertinoTheme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.grey[850]
                                    : Colors.grey[500],
                              ).merge(
                                this.widget.trailingTextStyle,
                              ),
                            ),
                    ],
                  ),
                  if (this.widget.subtitle.isNotEmpty)
                    Text(
                      this.widget.subtitle,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        height: 1.2,
                        color: Constants.isBright(context)
                            ? Colors.grey[800]
                            : Colors.grey[350],
                      ).merge(
                        widget.subtitleTextStyle,
                      ),
                    )
                ],
              ),
            ),
            if (widget.expansionSection != null)
              AnimatedContainer(
                duration: Duration(
                  milliseconds: 500,
                ),
                child: this.expanded
                    ? widget.expansionSection
                    : Container(
                        height: 0,
                      ),
              ),
            Divider(
              height: 1,
              color: Colors.grey[350],
            ),
          ],
        ),
      ),
    );
  }
}
