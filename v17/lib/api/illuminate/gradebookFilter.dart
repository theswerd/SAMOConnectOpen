import 'package:v17/api/illuminate/assignment.dart';

class GradebookFilter {
  List<AssignmentState> allowedAssignments = AssignmentState.values.toList();
  void addAssignmentState(
    AssignmentState assignmentState,
  ) {
    this.allowedAssignments.add(assignmentState);
  }

  void removeAssignmentState(
    AssignmentState assignmentState,
  ) {
    this.allowedAssignments.remove(assignmentState);
  }

  bool isAssignmentStateSelected(
    AssignmentState assignmentState,
  ) {
    return allowedAssignments.contains(assignmentState);
  }

  bool filter(Assignment assignment){
    return isAssignmentStateSelected(assignment.assignmentState);
  }

  void reset() {
    this.allowedAssignments = AssignmentState.values;
  }
}
