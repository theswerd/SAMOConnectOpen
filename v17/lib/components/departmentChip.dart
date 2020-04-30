import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:v17/api/schoolInformation/departments/department.dart';
import 'package:v17/constants.dart';
import 'package:v17/pages/schoolInfo/departmentsPage.dart';

class DepartmentChip extends StatelessWidget {
  final Department department;
  DepartmentChip(this.department);
  @override
  Widget build(BuildContext context) {
    return ActionChip(
      onPressed: ()=>Navigator.of(context).push(
        platformPageRoute(context: context, builder: (c)=>DepartmentsPage(department))
      ),
      elevation: 0,
      backgroundColor: Constants.isBright(context)?darken(this.department.color):this.department.color,
      labelStyle: TextStyle(color: Colors.white),
      label: Text(this.department.name),
    );
  }

  Color darken(Color c, {int percent = 20}) {
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.fromARGB(
        c.alpha,
        (c.red * f).round(),
        (c.green  * f).round(),
        (c.blue * f).round()
    );
}

}