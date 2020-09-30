import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mdi/mdi.dart';
import 'package:v17/api/contentState.dart';
import 'package:v17/api/illuminate/GradebookFilter.dart';
import 'package:v17/api/illuminate/class.dart';
import 'package:v17/api/illuminate/illuminate.dart';
import 'package:flutter/src/cupertino/constants.dart'
    show kMinInteractiveDimensionCupertino;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:v17/components/gradeStateIcon.dart';
import 'package:v17/constants.dart';
import 'package:v17/pages/gradebookPage/assignmentFilterPage.dart';

import '../../api/illuminate/assignment.dart';
import '../../components/CustomListTile.dart';

class ClassPage extends StatefulWidget {
  final Class currentClass;
  final IlluminateAPI illuminateAPI;

  const ClassPage(this.currentClass, this.illuminateAPI);

  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> with TickerProviderStateMixin {
  ContentState gradebookContentState;

  int index;

  void page(int index) {
    setState(() {
      this.index = index;
    });
  }

  @override
  void initState() {
    super.initState();
    index = 0;

    loadGradebookContent();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        trailingActions: [
          Material(
            type: MaterialType.transparency,
            child: IconButton(
              icon: Icon(
                Mdi.filterVariant,
              ),
              onPressed: this.index == 0
                  ? () {
                      if (isMaterial(context)) {
                        showBarModalBottomSheet(
                          context: context,
                          builder: (c, s) {
                            return Scaffold(
                                body: AssignmentFilterPage(widget: widget));
                          },
                        ).then((value) {
                          setState(() {});
                        });
                      } else {
                        CupertinoScaffold.showCupertinoModalBottomSheet(
                          context: context,
                          enableDrag: true,
                          expand: true,
                          bounce: true,
                          useRootNavigator: true,
                          builder: (
                            context,
                            scrollController,
                          ) =>
                              AssignmentFilterPage(
                            widget: widget,
                          ),
                        );
                      }
                    }
                  : null,
            ),
          ),
        ],
        title: Text(
          widget.currentClass.name,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          if (isCupertino(context)) ...[
            SliverPersistentHeader(
              delegate: CupertinoTopSpacer(
                context,
              ),
            ),
            CupertinoSliverRefreshControl(
              onRefresh: this.loadGradebookContent,
            ),
          ],
          PlatformWidget(
            ios: (c) => CupertinoTopTabBar(
              setPage: this.page,
            ),
            android: (c) => AndroidTopTabBar(
              setPage: this.page,
            ),
          ),
          () {
            switch (this.gradebookContentState) {
              case ContentState.loading:
                return SliverFillRemaining(
                  child: Center(
                    child: PlatformCircularProgressIndicator(),
                  ),
                );
              case ContentState.loaded:
                switch (index) {
                  case 0:
                    return AssignmentsList(
                      gradebookContentState: gradebookContentState,
                      assignments: widget.currentClass.assignments
                          .where((assignment) => widget
                              .currentClass.gradebookFilter
                              .filter(assignment))
                          .toList(),
                    );
                  case 1:
                    return ClassAnalytics(
                      widget.currentClass,
                    );
                  default:
                    return SliverFillRemaining(
                      child: PlatformCircularProgressIndicator(),
                    );
                }
                break;
              default:
                return SliverFillRemaining(
                  child: PlatformCircularProgressIndicator(),
                );
              //TODO: BUILD ERROR VIEW

            }
          }(),
        ],
      ),
    );
  }

  Future<void> loadGradebookContent() async {
    setState(() {
      this.gradebookContentState = ContentState.loading;
    });
    ContentState newContentState =
        await widget.currentClass.loadAssignments(widget.illuminateAPI.token)
            ? ContentState.loaded
            : ContentState.error;
    setState(() {
      this.gradebookContentState = newContentState;
    });
  }
}

class ClassAnalytics extends StatefulWidget {
  const ClassAnalytics(
    this.currentClass, {
    Key key,
  }) : super(key: key);

  final Class currentClass;

  @override
  _ClassAnalyticsState createState() => _ClassAnalyticsState();
}

class _ClassAnalyticsState extends State<ClassAnalytics> {
  double percentTurnedIn;
  double percentPassing;
  double percentAced;

  @override
  void initState() {
    super.initState();
    percentTurnedIn = (widget.currentClass.assignments
                .where((element) => !element.missing)
                .length /
            widget.currentClass.assignments.length) *
        100;
    percentPassing = (widget.currentClass.assignments
                .where(
                  (element) =>
                      element.assignmentState == AssignmentState.Pass ||
                      element.assignmentState == AssignmentState.Excused ||
                      element.assignmentState == AssignmentState.Aced ||
                      element.assignmentState == AssignmentState.ExtraCredit ||
                      element.assignmentState == AssignmentState.UNKNOWN,
                )
                .length /
            widget.currentClass.assignments.length) *
        100;
    percentAced = (widget.currentClass.assignments
                .where((element) => element.ace)
                .length /
            widget.currentClass.assignments.length) *
        100;
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Text(
            this.widget.currentClass.grade,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Constants.lightMBlackDarkMWhite(
                context,
              ),
            ),
          ),
          AnimatedCircularChart(
            edgeStyle: SegmentEdgeStyle.round,
            percentageValues: true,
            chartType: CircularChartType.Radial,
            size: Size(
              MediaQuery.of(context).size.width - (60 * 2),
              MediaQuery.of(context).size.width - (60 * 2),
            ),
            holeLabel:
                this.widget.currentClass.percent.toStringAsFixed(2) + "%",
            labelStyle: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Constants.lightMBlackDarkMWhite(context),
            ),
            initialChartData: <CircularStackEntry>[
              CircularStackEntry(
                <CircularSegmentEntry>[
                  CircularSegmentEntry(
                    this.widget.currentClass.percent,
                    this.widget.currentClass.color,
                  ),
                  CircularSegmentEntry(
                    100 - this.widget.currentClass.percent,
                    Constants.isBright(
                      context,
                    )
                        ? CupertinoColors.systemGrey5
                        : CupertinoColors.systemGrey,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              height: 20,
              color: Constants.isBright(context)
                  ? CupertinoColors.systemGrey5
                  : CupertinoColors.systemGrey,
            ),
          ),
          Text(
            "Grade breakdown",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: Constants.lightMBlackDarkMWhite(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3 - (10 * 2),
                  child: Column(
                    children: [
                      AnimatedCircularChart(
                        edgeStyle: SegmentEdgeStyle.round,
                        percentageValues: true,
                        chartType: CircularChartType.Radial,
                        size: Size(
                          MediaQuery.of(context).size.width / 3 - (10 * 2),
                          MediaQuery.of(context).size.width / 3 - (10 * 2),
                        ),
                        holeLabel:
                            this.percentTurnedIn.toStringAsFixed(2) + "%",
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Constants.lightMBlackDarkMWhite(context),
                        ),
                        initialChartData: <CircularStackEntry>[
                          CircularStackEntry(
                            <CircularSegmentEntry>[
                              CircularSegmentEntry(
                                this.percentTurnedIn,
                                CupertinoColors.activeGreen,
                              ),
                              CircularSegmentEntry(
                                100 - this.percentTurnedIn,
                                Constants.isBright(
                                  context,
                                )
                                    ? CupertinoColors.systemGrey5
                                    : CupertinoColors.systemGrey,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        this.percentTurnedIn == 0 ? "0 Turned in" : "Turned in",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Constants.lightMBlackDarkMWhite(context),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3 - (10 * 2),
                  child: Column(
                    children: [
                      AnimatedCircularChart(
                        edgeStyle: SegmentEdgeStyle.round,
                        percentageValues: true,
                        chartType: CircularChartType.Radial,
                        size: Size(
                          MediaQuery.of(context).size.width / 3 - (10 * 2),
                          MediaQuery.of(context).size.width / 3 - (10 * 2),
                        ),
                        holeLabel: this.percentPassing.toStringAsFixed(2) + "%",
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Constants.lightMBlackDarkMWhite(context),
                        ),
                        initialChartData: <CircularStackEntry>[
                          CircularStackEntry(
                            <CircularSegmentEntry>[
                              CircularSegmentEntry(
                                this.percentPassing,
                                CupertinoColors.activeBlue,
                              ),
                              CircularSegmentEntry(
                                100 - this.percentPassing,
                                Constants.isBright(
                                  context,
                                )
                                    ? CupertinoColors.systemGrey5
                                    : CupertinoColors.systemGrey,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        this.percentPassing == 0
                            ? "0 Passing"
                            : "Assignments passed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Constants.lightMBlackDarkMWhite(context),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3 - (10 * 2),
                  child: Column(
                    children: [
                      AnimatedCircularChart(
                        edgeStyle: SegmentEdgeStyle.round,
                        percentageValues: true,
                        chartType: CircularChartType.Radial,
                        size: Size(
                          MediaQuery.of(context).size.width / 3 - (10 * 2),
                          MediaQuery.of(context).size.width / 3 - (10 * 2),
                        ),
                        holeLabel: this.percentAced.toStringAsFixed(2) + "%",
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Constants.lightMBlackDarkMWhite(context),
                        ),
                        initialChartData: <CircularStackEntry>[
                          CircularStackEntry(
                            <CircularSegmentEntry>[
                              CircularSegmentEntry(
                                this.percentAced,
                                CupertinoColors.systemYellow,
                              ),
                              CircularSegmentEntry(
                                100 - this.percentAced,
                                Constants.isBright(
                                  context,
                                )
                                    ? CupertinoColors.systemGrey5
                                    : CupertinoColors.systemGrey,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        this.percentAced == 0 ? "0 Assignments Aced" : "Aced",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Constants.lightMBlackDarkMWhite(context),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              height: 20,
              color: Constants.isBright(context)
                  ? CupertinoColors.systemGrey5
                  : CupertinoColors.systemGrey,
            ),
          ),
          if (widget.currentClass.assignments.length > 3) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(
                    show: false,
                  ),
                  axisTitleData: FlAxisTitleData(
                    leftTitle: AxisTitle(
                      titleText: "Percent (%)",
                      showTitle: true,
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Constants.lightMBlackDarkMWhite(
                          context,
                        ),
                      ),
                    ),
                    topTitle: AxisTitle(
                      titleText: "Assignment Progression",
                      showTitle: true,
                      textStyle: TextStyle(
                        fontSize: 22,
                        color: Constants.lightMBlackDarkMWhite(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    bottomTitle: AxisTitle(
                      titleText: "Assignments",
                      textStyle: TextStyle(
                          fontSize: 22,
                          color: Constants.lightMBlackDarkMWhite(context)),
                      showTitle: true,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: SideTitles(
                      showTitles: false,
                    ),
                    leftTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  barTouchData: BarTouchData(touchTooltipData:
                      BarTouchTooltipData(
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      (rod.y * 100).toStringAsFixed(1) + "%",
                      TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    );
                  })),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barsSpace: ((MediaQuery.of(context).size.width - 40) /
                              widget.currentClass.assignments.length) *
                          (1 / 3),
                      barRods: List.generate(
                        widget.currentClass.assignments.length,
                        (index) => BarChartRodData(
                          borderRadius: BorderRadius.circular(24),
                          color: Constants.isBright(context)
                              ? CupertinoColors.systemGrey4
                              : CupertinoColors.systemGrey,
                          y: () {
                            double value = widget
                                .currentClass.assignments[index].points.percent
                                .toDouble();

                            if (value.isNaN ||
                                value.isInfinite ||
                                value == 0 ||
                                value.runtimeType != double)
                              return 0.0.toDouble();

                            return value;
                          }(),
                          width: ((MediaQuery.of(context).size.width - 40) *
                                  (2 / 3)) /
                              widget.currentClass.assignments.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 100,
            ),
          ]
        ],
      ),
    );
  }
}

class AssignmentsList extends StatelessWidget {
  const AssignmentsList({
    Key key,
    @required this.gradebookContentState,
    @required this.assignments,
  }) : super(key: key);

  final ContentState gradebookContentState;
  final List<Assignment> assignments;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        List.generate(
          assignments.length,
          (index) {
            Assignment assignment = assignments[index];

            return CustomListTile(
              title: assignment.name,
              subtitle: assignment.pointsString,
              subtitleTextStyle: TextStyle(
                fontSize: 18,
              ),
              expansionSection: assignment.graded &&
                      (assignment.assignmentState !=
                              AssignmentState.NotGraded &&
                          assignment.assignmentState !=
                              AssignmentState.Excused &&
                          assignment.assignmentState !=
                              AssignmentState.UNKNOWN &&
                          assignment.assignmentState != AssignmentState.Missing)
                  ? Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    topRight: assignment.ace
                                        ? Radius.circular(20)
                                        : Radius.zero,
                                    bottomRight: assignment.ace
                                        ? Radius.circular(20)
                                        : Radius.zero,
                                  ),
                                  child: Container(
                                    height: 30,
                                    color: CupertinoColors.systemGreen,
                                    width: (MediaQuery.of(context).size.width -
                                            40) *
                                        assignment.points.percent,
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  child: Container(
                                    height: 30,
                                    color: Constants.isBright(context)
                                        ? CupertinoColors.systemGrey
                                        : CupertinoColors.darkBackgroundGray,
                                    width: (MediaQuery.of(context).size.width -
                                            40) *
                                        (1 - assignment.points.percent),
                                  ),
                                )
                              ],
                            ),
                            Center(
                              child: Text(
                                (assignment.points.percent * 100)
                                        .toStringAsFixed(1) +
                                    "%",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 10,
                        ),
                      ],
                    )
                  : null,
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 10,
              ),
              trailingWidget: GradeStateIcon(
                assignment.assignmentState,
              ),
            );
          },
        ),
      ),
    );
  }
}

class CupertinoTopTabBar extends StatefulWidget {
  const CupertinoTopTabBar({
    Key key,
    @required this.setPage,
  }) : super(key: key);
  final Function(int) setPage;
  @override
  _CupertinoTopTabBarState createState() => _CupertinoTopTabBarState();
}

class _CupertinoTopTabBarState extends State<CupertinoTopTabBar> {
  int selected;

  @override
  void initState() {
    super.initState();
    selected = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CupertinoSlidingSegmentedControl(
          children: <dynamic, Widget>{
            0: Text(
              "Assignments",
              style: TextStyle(
                color: Constants.lightMBlackDarkMWhite(context),
              ),
            ),
            1: Text(
              "Analytics",
              style: TextStyle(
                color: Constants.lightMBlackDarkMWhite(context),
              ),
            ),
          },
          groupValue: this.selected,
          onValueChanged: (v) {
            setState(() {
              selected = v;
            });
            widget.setPage(selected);
          },
        ),
      ),
    );
  }
}

class AndroidTopTabBar extends StatefulWidget {
  const AndroidTopTabBar({
    Key key,
    @required this.setPage,
  }) : super(key: key);
  final Function(int) setPage;
  @override
  _AndroidTopTabBarState createState() => _AndroidTopTabBarState();
}

class _AndroidTopTabBarState extends State<AndroidTopTabBar>
    with TickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: TabBar(
        onTap: (index) {
          widget.setPage(index);
        },
        controller: this.tabController,
        tabs: [
          Tab(
            text: "Assignments",
          ),
          Tab(
            text: "Analysis",
          )
        ],
      ),
    );
  }
}

class CupertinoTopSpacer extends SliverPersistentHeaderDelegate {
  final BuildContext context;

  CupertinoTopSpacer(this.context);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container();
  }

  @override
  double get maxExtent =>
      kMinInteractiveDimensionCupertino + MediaQuery.of(context).padding.top;

  @override
  double get minExtent =>
      kMinInteractiveDimensionCupertino + MediaQuery.of(context).padding.top;

  @override
  bool shouldRebuild(a) {
    return false;
  }
}
