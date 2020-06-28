
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:v17/api/illuminate/assignment.dart';

class GradeStateIcon extends StatelessWidget {
  final AssignmentState state;

  const GradeStateIcon(
    this.state, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        4,
      ),
      child: Container(
        height: 28,
        width: 28,
        color: () {
          switch (this.state) {
            case AssignmentState.Aced:
              return CupertinoColors.systemYellow;
            case AssignmentState.Pass:
              return CupertinoColors.activeGreen;
            case AssignmentState.Excused:
              return CupertinoColors.systemBlue;
            case AssignmentState.ExtraCredit:
              return CupertinoColors.systemYellow;
            case AssignmentState.Fail:
              return CupertinoColors.destructiveRed;
            case AssignmentState.Missing:
              return CupertinoColors.systemRed;
            case AssignmentState.NotGraded:
              return CupertinoColors.systemGrey;
            case AssignmentState.UNKNOWN:
              return CupertinoColors.systemGrey;
            default:
              return CupertinoColors.systemGrey;
          }
        }(),
        child: Center(
          child: Icon(
            () {
              switch (this.state) {
                case AssignmentState.Aced:
                  return Icons.star;
                case AssignmentState.Pass:
                  return Icons.thumb_up;
                case AssignmentState.Excused:
                  return Icons.remove;
                case AssignmentState.ExtraCredit:
                  return Icons.arrow_upward;
                case AssignmentState.Fail:
                  return Mdi.exclamationThick;
                case AssignmentState.Missing:
                  return Mdi.headQuestion;
                case AssignmentState.NotGraded:
                  return Mdi.minus;
                case AssignmentState.UNKNOWN:
                  return Mdi.alertCircle;
                default:
                  return Mdi.alertCircle;
              }
            }(),
            size: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
