import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:v17/api/schoolInformation/departments/department.dart';
import 'package:v17/api/schoolInformation/teacher/teacher.dart';
import 'package:v17/api/schoolInformation/teacher/teachers.dart';
import 'package:v17/components/departmentChip.dart';
import 'package:v17/components/pageWithHeader.dart';
import 'package:v17/components/teacherFavoriteButton.dart';
import 'package:v17/components/teacherListTile.dart';
import 'package:v17/constants.dart';
import 'package:vibrate/vibrate.dart';

class TeacherPage extends StatelessWidget {
  final Teacher teacher;
  TeacherPage(this.teacher);

  @override
  Widget build(BuildContext context) {
    Divider sectionDivider = Divider(
      color: Constants.isBright(context) ? Colors.grey[700] : Colors.grey[400],
    );
    return PageWithHeader(
      trailing: TeacherFavoriteButton(
        teacher: this.teacher,
      ),
      title: this.teacher.name,
      body: <Widget>[
        SliverPadding(
          padding: EdgeInsets.all(12),
          sliver: SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                Text("Contact information",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Constants.lightMBlackDarkMWhite(context))),
                sectionDivider,
                Wrap(
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    ContactInformationSection(
                      title: "Email",
                      buttonString: this.teacher.email,
                      shareString:
                          "${this.teacher.name}'s email is ${this.teacher.email}.",
                      copyString: this.teacher.email,
                    ),
                    Container(
                      width: 10,
                    ),
                    if (this.teacher.ext != null)
                      ContactInformationSection(
                        title: "Extension",
                        buttonString: this.teacher.ext,
                        shareString:
                            "${this.teacher.name}'s extension is ${this.teacher.ext}.",
                        copyString: this.teacher.ext,
                      ),
                  ],
                ),
                if (this.teacher.hasWebsite) ...[
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Website",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Constants.lightMBlackDarkMWhite(context),
                      fontSize: 20,
                    ),
                  ),
                  PlatformButton(
                    child: Text("Open ${this.teacher.name}'s website"),
                    onPressed: () {
                      launch(this.teacher.website);
                    },
                  ),
                  PlatformButton(
                    child: Text("Copy link to ${this.teacher.name}'s website"),
                    onPressed: () {
                      Vibrate.feedback(FeedbackType.success);
                      Clipboard.setData(
                          ClipboardData(text: this.teacher.website));
                    },
                  ),
                ],
                if (this.teacher.department.isNotEmpty) ...[
                  Text(
                    "Departments",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Constants.lightMBlackDarkMWhite(context)),
                  ),
                  sectionDivider,
                  SizedBox(
                    height: 5,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: List.generate(
                      this.teacher.department.length,
                      (index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 2),
                          child:
                              DepartmentChip(this.teacher.department[index])),
                    ),
                  ),
                  if (this.teacher.department.any((searchingDepartment) =>
                      teachers
                          .where((teacher) => teacher.department.any(
                              (searchedTeacherDepartment) =>
                                  searchedTeacherDepartment.name ==
                                  searchingDepartment.name))
                          .length >
                      1)) ...[
                    Text(
                      "Coworkers",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Constants.lightMBlackDarkMWhite(context),
                        fontSize: 22,
                      ),
                    ),
                    ...this.teacher.department.map(
                      (Department department) {
                        List<Teacher> teachersInDepartment = teachers
                            .where((teacher) => teacher.department.any(
                                (searchedTeacherDepartment) =>
                                    searchedTeacherDepartment.name ==
                                    department.name))
                            .toList();

                        teachersInDepartment.remove(this.teacher);
                        if (teachersInDepartment.length >= 1) {
                          return ExpansionTile(
                            leading: Text(
                              department.name,
                              style: TextStyle(
                                  color:
                                      Constants.lightMBlackDarkMWhite(context),
                                  fontSize: 22),
                            ),
                            title: Container(),
                            initiallyExpanded: true,
                            children: List.generate(
                              teachersInDepartment.length,
                              (index) => TeacherListTile(
                                teacher: teachersInDepartment[index],
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ]
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ContactInformationSection extends StatelessWidget {
  final String copyString;
  final String title;
  final String shareString;
  final String buttonString;

  const ContactInformationSection({
    @required this.title,
    @required this.copyString,
    @required this.shareString,
    @required this.buttonString,
  });

  TextStyle titleTextStyle(BuildContext context) => TextStyle(
        color: Constants.lightMBlackDarkMWhite(context),
        fontSize: 18,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          this.title,
          textAlign: TextAlign.center,
          style: titleTextStyle(context),
        ),
        PlatformButton(
          child: Text(this.buttonString),
          onPressed: () {
            showPlatformModalSheet(
              context: context,
              builder: (v) {
                return PlatformWidget(
                  android: (c) => BottomSheet(
                    onClosing: () {},
                    builder: (c) => Column(
                      children: <Widget>[
                        ListTile(
                          title: Text("Copy"),
                          trailing: Icon(Icons.content_copy),
                          onTap: () => copy(c),
                        ),
                        ListTile(
                          title: Text("Share"),
                          trailing: Icon(Icons.share),
                          onTap: () => share(c),
                        ),
                      ],
                    ),
                  ),
                  ios: (c) => CupertinoActionSheet(
                    title: Text(this.shareString),
                    cancelButton: CupertinoActionSheetAction(
                      onPressed: () => Navigator.pop(c),
                      child: Text("Cancel"),
                    ),
                    actions: <Widget>[
                      CupertinoActionSheetAction(
                        onPressed: () => copy(c),
                        child: Text("Copy"),
                      ),
                      CupertinoActionSheetAction(
                        onPressed: () => share(c),
                        child: Text("Share"),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  void copy(BuildContext context) {
    Vibrate.feedback(FeedbackType.success);
    Clipboard.setData(ClipboardData(text: this.copyString));
    Navigator.pop(context);
  }

  void share(BuildContext context) {
    Share.share(this.shareString);
    Navigator.pop(context);
  }
}
