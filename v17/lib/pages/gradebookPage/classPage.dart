import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mdi/mdi.dart';
import 'package:v17/api/contentState.dart';
import 'package:v17/api/illuminate/class.dart';
import 'package:v17/api/illuminate/illuminate.dart';
import 'package:flutter/src/cupertino/constants.dart'
    show kMinInteractiveDimensionCupertino;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:v17/constants.dart';

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

  @override
  void initState() {
    super.initState();

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
              onPressed: () {
                if (isMaterial(context)) {
                  showBarModalBottomSheet(
                    context: context,
                    builder: (c, s) {
                      return Container();
                    },
                  );
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
                        Column(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Filter",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Constants.lightMBlackDarkMWhite(
                                                    context),
                                          ),
                                        ),
                                        Text(
                                          "Find the assignments you want",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Constants.lightMBlackDarkMWhite(
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
                      ],
                    ),
                  );
                }
              },
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
          SliverPersistentHeader(
            delegate: TopTabBarDelegate(),
            floating: true,
          ),
          mainContent(),
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

  Widget mainContent() {
    switch (this.gradebookContentState) {
      case ContentState.loading:
        return SliverFillRemaining(
          child: Center(child: PlatformCircularProgressIndicator()),
        );
      case ContentState.loaded:
        return SliverList(
          delegate: SliverChildListDelegate(
            List.generate(
              widget.currentClass.assignments.length,
              (index) {
                Assignment assignment = widget.currentClass.assignments[index];
                return CustomListTile(
                  title: assignment.name,
                  trailingWidget: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      4,
                    ),
                    child: Container(
                      color: (){
                        assignment.assignmentState;
                        return Colors.green;
                      }(),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      default:
        return SliverToBoxAdapter(child: Container());
      //TODO BUILD ERROR VIEW
    }
  }
}

class TopTabBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlap,
  ) {
    return PlatformWidget(
      ios: (c) => CupertinoTopTabBar(),
      android: (c) => AndroidTopTabBar(),
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate a) => true;
}

class CupertinoTopTabBar extends StatefulWidget {
  const CupertinoTopTabBar({
    Key key,
  }) : super(key: key);

  @override
  _CupertinoTopTabBarState createState() => _CupertinoTopTabBarState();
}

class _CupertinoTopTabBarState extends State<CupertinoTopTabBar> {
  String selected;

  @override
  void initState() {
    super.initState();
    selected = "all";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoSlidingSegmentedControl(
        children: <dynamic, Widget>{
          "all": Text(
            "All",
            style: TextStyle(
              color: Constants.lightMBlackDarkMWhite(context),
            ),
          ),
          "assignments": Text(
            "Assignments",
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
        },
      ),
    );
  }
}

class AndroidTopTabBar extends StatefulWidget {
  const AndroidTopTabBar({
    Key key,
  }) : super(key: key);

  @override
  _AndroidTopTabBarState createState() => _AndroidTopTabBarState();
}

class _AndroidTopTabBarState extends State<AndroidTopTabBar>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: TabController(
        vsync: this,
        length: 2,
      ),
      tabs: [
        Tab(
          text: "Assignments",
        ),
        Tab(
          text: "Analysis",
        )
      ],
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
