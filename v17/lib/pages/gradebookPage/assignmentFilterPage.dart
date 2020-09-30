import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v17/api/illuminate/GradebookFilter.dart';
import 'package:v17/api/illuminate/assignment.dart';
import 'package:v17/components/CustomListTile.dart';
import 'package:v17/components/gradeStateIcon.dart';
import 'package:v17/constants.dart';
import 'package:v17/pages/gradebookPage/classPage.dart';

class AssignmentFilterPage extends StatelessWidget {
  const AssignmentFilterPage({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final ClassPage widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Constants.isBright(context)
              ? CupertinoColors.extraLightBackgroundGray
              : CupertinoColors.darkBackgroundGray,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Filter",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Constants.lightMBlackDarkMWhite(
                              context,
                            ),
                          ),
                        ),
                        Text(
                          "Find the assignments you want",
                          style: TextStyle(
                            fontSize: 16,
                            color: Constants.lightMBlackDarkMWhite(
                              context,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CupertinoButton(
                      borderRadius: BorderRadius.circular(30),
                      padding: EdgeInsets.all(4),
                      color: Constants.isBright(context)
                          ? CupertinoColors.lightBackgroundGray
                          : CupertinoColors.systemGrey4,
                      child: Icon(
                        Icons.close,
                        color: Constants.isBright(context)
                            ? null
                            : Colors.grey[350],
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
        Container(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Sort by state",
              style: TextStyle(
                color: Constants.lightMBlackDarkMWhite(
                  context,
                ),
              ),
            ),
          ),
        ),
        AssignmentStateFilterTile(
          assignmentState: AssignmentState.Aced,
          filter: widget.currentClass.gradebookFilter,
          title: "Aced",
        ),
        AssignmentStateFilterTile(
          assignmentState: AssignmentState.ExtraCredit,
          filter: widget.currentClass.gradebookFilter,
          title: "Extra Credit",
        ),
        AssignmentStateFilterTile(
          assignmentState: AssignmentState.Pass,
          filter: widget.currentClass.gradebookFilter,
          title: "Pass",
        ),
        AssignmentStateFilterTile(
          assignmentState: AssignmentState.Excused,
          filter: widget.currentClass.gradebookFilter,
          title: "Excused",
        ),
        AssignmentStateFilterTile(
          assignmentState: AssignmentState.Fail,
          filter: widget.currentClass.gradebookFilter,
          title: "Fail",
        ),
        AssignmentStateFilterTile(
          assignmentState: AssignmentState.Missing,
          filter: widget.currentClass.gradebookFilter,
          title: "Missing",
        ),
        AssignmentStateFilterTile(
          assignmentState: AssignmentState.NotGraded,
          filter: widget.currentClass.gradebookFilter,
          title: "Not Graded",
        ),
        AssignmentStateFilterTile(
          assignmentState: AssignmentState.UNKNOWN,
          filter: widget.currentClass.gradebookFilter,
          title: "Unknown",
        ),
      ],
    );
  }
}

class AssignmentStateFilterTile extends StatefulWidget {
  final GradebookFilter filter;
  final AssignmentState assignmentState;
  final String title;

  const AssignmentStateFilterTile({
    @required this.assignmentState,
    @required this.filter,
    @required this.title,
  });

  @override
  _AssignmentStateFilterTileState createState() =>
      _AssignmentStateFilterTileState();
}

class _AssignmentStateFilterTileState extends State<AssignmentStateFilterTile> {
  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: widget.title,
      leadingWidget: GradeStateIcon(this.widget.assignmentState),
      trailingWidget:
          this.widget.filter.isAssignmentStateSelected(widget.assignmentState)
              ? Icon(Icons.check)
              : Container(),
      onPressed: () => setState(() {
        this.widget.filter.isAssignmentStateSelected(widget.assignmentState)
            ? this.widget.filter.removeAssignmentState(widget.assignmentState)
            : this.widget.filter.addAssignmentState(widget.assignmentState);
      }),
    );
  }
}
