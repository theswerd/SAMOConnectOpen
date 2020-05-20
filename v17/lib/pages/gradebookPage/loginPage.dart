import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mdi/mdi.dart';
import 'package:v17/api/contentState.dart';
import 'package:v17/api/illuminate/illuminate.dart';
import 'package:v17/constants.dart';
import 'package:v17/pages/gradebookPage/Textfield.dart';
import 'package:v17/pages/gradebookPage/loggedInPage.dart';
import 'gradesPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage(this.illuminateAPI);

  final IlluminateAPI illuminateAPI;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool autoLogin;
  TextEditingController usernameController, passwordController;
  ContentState loginContentState;

  @override
  void initState() {
    super.initState();

    this.usernameController = new TextEditingController();
    this.passwordController = new TextEditingController();

    loginContentState = ContentState.none;

    autoLogin = false;
  }

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Check your grades",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Constants.lightMBlackDarkMWhite(context)
                            .withOpacity(.8),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            GradebookTextField(
              label: "Username",
              controller: this.usernameController,
              icon: Mdi.idCard,
            ),
            SizedBox(
              height: 25,
            ),
            GradebookTextField(
              label: "Password",
              controller: this.passwordController,
              icon: Mdi.lockOutline,
              obscureText: true,
            ),
            Container(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Enable auto-login",
                  style: TextStyle(
                    color: Constants.lightMBlackDarkMWhite(context),
                    fontSize: 20,
                  ),
                ),
                PlatformSwitch(
                  value: this.autoLogin,
                  activeColor: Constants.primary,
                  onChanged: (v) {
                    setState(() {
                      autoLogin = v;
                    });
                  },
                ),
              ],
            ),
            Container(
              height: 10,
            ),
            Wrap(
              children: [
                Text(
                  Platform.isIOS
                      ? "Your login information will be scored locally on your device's keychain."
                      : "Your login information will be stored locally with an AES secret key that is encrypted with RSA and RSA key is stored in your devices KeyStore.",
                  style: TextStyle(
                    color: Constants.lightMBlackDarkMWhite(
                      context,
                    ).withOpacity(.8),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  FlatButton(
                    textColor: Constants.isBright(context)
                        ? Colors.white
                        : Constants.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(16),
                    color: Constants.isBright(context)
                        ? Constants.primary
                        : Colors.grey[350],
                    child: Column(
                      children: [
                        Align(
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        AnimatedSwitcher(
                          transitionBuilder: (w, a) => ScaleTransition(
                            scale: a,
                            child: w,
                          ),
                          child: loginStateIndicator(),
                          duration: Duration(
                            milliseconds: 500,
                          ),
                        )
                      ],
                    ),
                    splashColor:
                        Constants.isBright(context) ? Constants.primary : null,
                    onPressed: () async {
                      setState(() {
                        loginContentState = ContentState.loading;
                      });
                      await widget.illuminateAPI.attemptLogin(
                        this.usernameController.text,
                        this.passwordController.text,
                      );
                      if (await widget.illuminateAPI.verifyLogin) {
                        setState(() {
                          this.loginContentState = ContentState.loaded;
                        });
                        await Navigator.of(context).push(
                          platformPageRoute(
                            context: context,
                            builder: (c) => LoggedInPage(widget.illuminateAPI),
                          ),
                        );
                        setState(() {
                          this.loginContentState = ContentState.none;
                        });
                      } else {
                        setState(() {
                          this.loginContentState = ContentState.error;
                        });
                        await Future.delayed(
                          Duration(milliseconds: 550),
                        );
                        setState(() {
                          this.loginContentState = ContentState.none;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loginStateIndicator() {
    switch (loginContentState) {
      case ContentState.none:
        return Container();
      case ContentState.loaded:
        return Column(
          children: [
            Container(
              height: 8,
            ),
            LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                Colors.green,
              ),
            ),
          ],
        );

      case ContentState.loading:
        return Column(
          children: [
            Container(
              height: 8,
            ),
            LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                Constants.primary,
              ),
            ),
          ],
        );

      case ContentState.error:
        return Column(
          children: [
            Container(
              height: 8,
            ),
            LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                Colors.red,
              ),
            ),
          ],
        );
      default:
        return Container();
    }
  }
}
