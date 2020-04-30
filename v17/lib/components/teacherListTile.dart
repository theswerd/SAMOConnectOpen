import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mdi/mdi.dart';
import 'package:v17/api/schoolInformation/teacher/teacher.dart';
import 'package:v17/components/departmentChip.dart';
import 'package:v17/constants.dart';
import 'package:v17/pages/schoolInfo/teacherPage.dart';

class TeacherListTile extends StatelessWidget {
  const TeacherListTile({
    @required this.teacher,
  });

  final Teacher teacher;

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      ios: (c) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => Navigator.of(context).push(CupertinoPageRoute(
              builder: (c) => TeacherPage(this.teacher),
            )),
            child: GestureDetector(
              onHorizontalDragEnd: (v) =>
                  Navigator.of(context).push(CupertinoPageRoute(
                builder: (c) => TeacherPage(this.teacher),
              )),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 4),
                          child: Text(
                            teacher.name,
                            style: TextStyle(
                              color: Constants.isBright(context)
                                  ? Colors.grey[800]
                                  : Colors.grey[300],
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            alignment: WrapAlignment.start,
                            children: List.generate(
                              teacher.department.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 4.0, right: 4.0),
                                child: DepartmentChip(
                                  teacher.department[index]
                                )
                                
                              ),
                            ),
                          ),
                        ),
                        Divider(
                            height: 1,
                            color: Constants.isBright(context)
                                ? Colors.grey[500]
                                : Colors.grey[300]),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Mdi.starOutline),
                    onPressed: () {},
                  ),
                  Icon(
                    CupertinoIcons.right_chevron,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      android: (c) {
        return ListTile(
          title: Text(teacher.name),
          subtitle: Text(teacher.department.map((e) => e.name).join(', ')),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (c) => TeacherPage(teacher),
            ),
          ),
        );
      },
    );
  }
}
