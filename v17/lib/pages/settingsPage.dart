import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v17/components/CustomListTile.dart';
import 'package:v17/components/pageWithHeader.dart';
import 'package:v17/constants.dart';
import 'package:v17/pages/developedBy.dart';
import 'package:v17/pages/legalPage.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isCurrentlyMaterial;

  bool analyticsEnabled;
  bool storeIlluminateLogin;
  bool customizedExperience;

  SharedPreferences sharedPreferences;

  String packageNumber;

  @override
  void initState() {
    super.initState();

    checkSharedPreferences();
    checkAppVersion();
  }

  @override
  Widget build(BuildContext context) {
    this.isCurrentlyMaterial = isMaterial(context);

    return PageWithHeader(
      title: "Settings",
      body: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate.fixed(
            <Widget>[
              SizedBox(
                height: 24,
              ),
              CustomListTile(
                title: "App Theme",
                trailingText: isMaterial(context) ? "Material" : "Cupertino",
                onPressed: () => showPlatformModalSheet(
                  context: context,
                  builder: (c) => PlatformWidget(
                    android: (_) => BottomSheet(
                        onClosing: () {},
                        builder: (c) => Column(
                              children: <Widget>[
                                ListTile(
                                    title: Text("Material"),
                                    subtitle: Text("Android"),
                                    trailing: this.isCurrentlyMaterial
                                        ? Icon(Icons.check)
                                        : null,
                                    onTap: () {
                                      PlatformProvider.of(context)
                                          .changeToMaterialPlatform();
                                    }),
                                ListTile(
                                    title: Text("Cupertino"),
                                    subtitle: Text("iOS"),
                                    trailing: this.isCurrentlyMaterial
                                        ? null
                                        : Icon(Icons.check),
                                    onTap: () {
                                      PlatformProvider.of(context)
                                          .changeToCupertinoPlatform();
                                    }),
                              ],
                            )),
                    ios: (_) => CupertinoActionSheet(
                        title: Text("App Theme"),
                        cancelButton: CupertinoActionSheetAction(
                            child: Text("Cancel"),
                            onPressed: () => Navigator.pop(_)),
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                              child: Text("Material"),
                              onPressed: () => PlatformProvider.of(context)
                                  .changeToMaterialPlatform()),
                          CupertinoActionSheetAction(
                              child: Text("Cupertino"),
                              onPressed: () {
                                Navigator.pop(_);
                              }),
                        ]),
                  ),
                ),
              ),
              Container(
                height: 40,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: Text("Data & Analytics",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Constants.lightMBlackDarkMWhite(context))),
              ),
              CustomListTile(
                title: "Analytics enabled",
                subtitle:
                    "Allow us to collect data using Google Analytics so we can improve your experience with SAMOHI Connect.",
                trailingIsWidget: true,
                trailingWidget: PlatformSwitch(
                    activeColor: Constants.primary,
                    value: this.analyticsEnabled ?? false,
                    onChanged: (v) {
                      setState(() {
                        this.analyticsEnabled = !this.analyticsEnabled;
                      });
                      keyToValueBool("analyticsEnabled", this.analyticsEnabled);
                    }),
                onPressed: () => setState(() {
                  this.analyticsEnabled = !this.analyticsEnabled;
                  keyToValueBool("analyticsEnabled", this.analyticsEnabled);
                }),
              ),
              CustomListTile(
                  title: "Enable Illuminate Auto-Login",
                  subtitle:
                      "Allow us to store your Illuminate login on your device so you can auto-login.",
                  trailingIsWidget: true,
                  trailingWidget: PlatformSwitch(
                      activeColor: Constants.primary,
                      value: this.storeIlluminateLogin ?? false,
                      onChanged: (v) {
                        setState(() {
                          this.storeIlluminateLogin =
                              !(this.storeIlluminateLogin ?? false);
                        });
                        keyToValueBool(
                            "storeIlluminateLogin", this.storeIlluminateLogin);
                      }),
                  onPressed: () {
                    setState(() {
                      this.storeIlluminateLogin =
                          !(this.storeIlluminateLogin ?? false);
                    });
                    keyToValueBool(
                        "storeIlluminateLogin", this.storeIlluminateLogin);
                  }),
              CustomListTile(
                  title: "Enable Customized Experience",
                  subtitle:
                      "Allow us to log your usage on your device so you can get customized search suggestions.",
                  trailingIsWidget: true,
                  trailingWidget: PlatformSwitch(
                      activeColor: Constants.primary,
                      value: this.customizedExperience ?? false,
                      onChanged: (v) {
                        setState(() {
                          this.customizedExperience =
                              !(this.customizedExperience ?? false);
                        });
                        keyToValueBool(
                            "customizedExperience", this.storeIlluminateLogin);
                      }),
                  onPressed: () {
                    setState(() {
                      this.customizedExperience =
                          !(this.customizedExperience ?? false);
                    });
                    keyToValueBool(
                        "customizedExperience", this.storeIlluminateLogin);
                  }),
              CustomListTile(
                title: "Clear data",
                subtitle:
                    "This will clear all data currently stored on you. This will not clear past analytics data as it is not personally identifiable.",
                onPressed: () => showPlatformDialog(
                  context: context,
                  builder: (c) => PlatformAlertDialog(
                    title: Text("Are you sure?"),
                    content: Text(
                        "This action cannot be undone. Your Illuminate login, and search and news preferences will be deleted."),
                    actions: <Widget>[
                      PlatformDialogAction(
                          child: Text("Cancel"),
                          onPressed: () => Navigator.pop(c)),
                      PlatformDialogAction(
                          child: Text("Clear Data"),
                          onPressed: () => Navigator.pop(
                              c) /*TODO: IMPLEMENT STORING DATA AND THEN THE NON STORING */)
                    ],
                  ),
                ),
              ),
              Container(height: 40),
              Container(
                height: 40,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: Text("App Information",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Constants.lightMBlackDarkMWhite(context))),
              ),
              CustomListTile(
                  title: "App Version", trailingText: this.packageNumber ?? ""),
              CustomListTile(title: "Build", trailingText: "Production"),
              CustomListTile(
                title: "About the app",
                onPressed: () => Navigator.of(context).push(isMaterial(context)
                    ? MaterialPageRoute(builder: (c) => LegalPage())
                    : CupertinoPageRoute(builder: (c) => LegalPage())),
              ),
              CustomListTile(
                title: "View developers",
                onPressed: () {
                  Navigator.of(context).push(isMaterial(context)
                      ? MaterialPageRoute(builder: (c) {
                          return DevelopedBy();
                        })
                      : CupertinoPageRoute(builder: (c) {
                          return DevelopedBy();
                        }));
                },
              ),
              Container(
                height: 40,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: Text("Other",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Constants.lightMBlackDarkMWhite(context))),
              ),
              CustomListTile(title: "Report a bug"),
              CustomListTile(title: "Join the team"),
              Container(height: 105),
            ],
          ),
        )
      ],
    );
  }

  void keyToValueBool(String key, bool value) async {
    try {
      this.sharedPreferences.setBool(key, value);
    } catch (e) {}
  }

  void checkSharedPreferences() async {
    this.sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      this.storeIlluminateLogin =
          sharedPreferences.getBool("storeIlluminateLogin") ?? false;

      this.analyticsEnabled =
          sharedPreferences.getBool("analyticsEnabled") ?? false;

      this.customizedExperience =
          sharedPreferences.getBool("customizedExperience") ?? false;
    });
  }

  void checkAppVersion() async {
    String packageInfo = await Constants.packageVersion(context);
    setState(() {
      this.packageNumber = packageInfo;
    });
  }
}
