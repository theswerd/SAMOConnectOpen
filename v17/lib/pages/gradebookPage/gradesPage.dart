import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:v17/api/illuminate/illuminate.dart';
import 'package:v17/api/illuminate/loginCredentials.dart';
import 'package:v17/components/pageWithHeader.dart';
import 'package:v17/constants.dart';
import 'package:local_auth_device_credentials/local_auth.dart';
import 'package:v17/pages/gradebookPage/loginPage.dart';

class GradesPage extends StatefulWidget {
  @override
  _GradesPageState createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  Widget body;
  IlluminateAPI illuminateAPI;
  LoginCredentials credentials;

  FlutterSecureStorage secureStorage;
  LocalAuthentication auth;

  bool loggedIn;

  @override
  void initState() {
    super.initState();

    loggedIn = false;
    initializeAPIs();
    body = LoginPage(this.illuminateAPI);
  }

  @override
  Widget build(BuildContext context) {
    return PageWithHeader(
      title: "Illuminate",
      body: [body],
    );
  }

  void initializeAPIs() async {
    this.illuminateAPI = new IlluminateAPI();
    this.secureStorage = new FlutterSecureStorage();
    this.auth = new LocalAuthentication();

    bool initialized = await this.illuminateAPI.init();

    if (initialized) {
      bool autoLoginEnabled = await this
              .secureStorage
              .read(key: SecureStorageKeys.storeLoginInfo) ==
          'true';
      if (autoLoginEnabled) {
        bool autoLoginApproval = await approveAutoLogin();
        if (autoLoginApproval) {
          this.credentials = await LoginCredentials.fromSecureStorage();
        }
      } else {}
    } else {
      //TODO: Show network failure stuff
    }
  }

  Future<bool> approveAutoLogin() async {
    bool approved;
    if (await auth.canCheckBiometrics) {
      approved = await attemptBiometricAuth();
    } else {
      approved = await attemptPasscodeAuth();
    }
    return approved;
  }

  Future<bool> attemptPasscodeAuth() async {
    bool succeeded = await auth.authenticate(
      useErrorDialogs: true,
      localizedReason:
          "Please verify your identity to auto-login to illuminate",
    );
    if (succeeded) {
      return true;
    } else {
      await showPlatformDialog(
        context: context,
        builder: (context) {
          return PlatformAlertDialog(
            title: Text("Authentication failed"),
            content: Text("We were unable to verify your identity"),
            actions: [
              PlatformDialogAction(
                child: Text("Try Again"),
                onPressed: () async {
                  succeeded = await attemptPasscodeAuth();
                  Navigator.pop(context);
                },
              ),
              PlatformDialogAction(
                child: Text("Login with password"),
                onPressed: () {
                  Navigator.pop(context);
                  return false;
                },
              )
            ],
          );
        },
      );
      return succeeded;
    }
  }

  Future<bool> attemptBiometricAuth() async {
    bool suceeded = await auth.authenticateWithBiometrics(
        localizedReason:
            "Please verify your identity to auto-login to illuminate");
    if (suceeded) {
      return true;
    } else {
      await showPlatformDialog(
        context: context,
        builder: (context) {
          return PlatformAlertDialog(
            title: Text("Authentication failed"),
            content: Text("We were unable to verify your identity"),
            actions: [
              PlatformDialogAction(
                child: Text("Try Again"),
                onPressed: () async {
                  suceeded = await attemptBiometricAuth();
                  Navigator.pop(context);
                },
              ),
              PlatformDialogAction(
                child: Text("Use device passcode"),
                onPressed: () async {
                  suceeded = await attemptPasscodeAuth();
                  Navigator.pop(context);
                },
              ),
              PlatformDialogAction(
                child: Text("Login with password"),
                onPressed: () {
                  suceeded = false;
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      );
      return suceeded;
    }
  }
}

class ConnectingToIlluminateLoadingIndicator extends StatelessWidget {
  const ConnectingToIlluminateLoadingIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          PlatformCircularProgressIndicator(),
          Container(height: 8),
          Text(
            "Connecting to Illuminate",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Constants.lightMBlackDarkMWhite(context),
            ),
          ),
        ],
      ),
    );
  }

  void attemptLogin(String username, String password) {}
}
