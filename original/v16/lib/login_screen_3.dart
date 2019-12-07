import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'color_loader_3.dart';
import 'MainPageAndroid.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginScreen3 extends StatefulWidget {
  @override

  static String tag = "LOGIN SCREEN";

  _LoginScreen3State createState() => new _LoginScreen3State();
}

class _LoginScreen3State extends State<LoginScreen3>
    with TickerProviderStateMixin {
    var mainColor = Colors.indigoAccent;
    TextEditingController emailSignUp;
    TextEditingController passwordSignUp;
    TextEditingController passwordConfirm;

    TextEditingController emailLogin;
    TextEditingController passwordLogin;

  //The code is commented because instead of manual scrolling with animation,
  //Now PageView is being used

  /*double scrollPercent = 0.0;
  Offset startDrag;
  double startDragPercentScroll;
  double dragDirection; // -1 for left, +1 for right

  AnimationController controller_minus1To0;
  AnimationController controller_0To1;
  CurvedAnimation anim_minus1To0;
  CurvedAnimation anim_0To1;

  final numCards = 3;

  void _onHorizontalDragStart(DragStartDetails details) {
    startDrag = details.globalPosition;
    startDragPercentScroll = scrollPercent;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final currDrag = details.globalPosition;
    final dragDistance = currDrag.dx - startDrag.dx;
    if (dragDistance > 0) {
      dragDirection = 1.0;
    } else {
      dragDirection = -1.0;
    }
    final singleCardDragPercent = dragDistance / context.size.width;

    setState(() {
      scrollPercent =
          (startDragPercentScroll + (-singleCardDragPercent / numCards))
              .clamp(0.0 - (1 / numCards), (1 / numCards));
      print(scrollPercent);
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (scrollPercent > 0.1666) {
      print("FIRST CASE");
      controller_0To1.forward(from: scrollPercent * numCards);
    } else if (scrollPercent < 0.1666 &&
        scrollPercent > -0.1666 &&
        dragDirection == -1.0) {
      print("SECOND CASE");
      controller_0To1.reverse(from: scrollPercent * numCards);
    } else if (scrollPercent < 0.1666 &&
        scrollPercent > -0.1666 &&
        dragDirection == 1.0) {
      print("THIRD CASE");
      controller_minus1To0.forward(from: scrollPercent * numCards);
    } else if (scrollPercent < -0.1666) {
      print("LAST CASE");
      controller_minus1To0.reverse(from: scrollPercent * numCards);
    }

    setState(() {
      startDrag = null;
      startDragPercentScroll = null;
    });
  }
  */
  Text titleWidget = Text("");

  AppBar theAppBar;
  GlobalKey<ScaffoldState> signUpKey =GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> loginKey =GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailSignUp =TextEditingController();
    passwordSignUp =TextEditingController();
    passwordConfirm =TextEditingController();

    emailLogin =TextEditingController();
    passwordLogin =TextEditingController();


    theAppBar =AppBar(
      backgroundColor: Colors.indigoAccent[700],
      title: titleWidget,
      leading: IconButton(
        icon: Icon(MdiIcons.homeOutline,color: Colors.white,),
        splashColor: Colors.yellow,
        onPressed: (){
          Navigator.of(context).pushNamed(MainWindowAndroid.tag);
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.info_outline),
          splashColor: Colors.yellow,
          onPressed: (){
            showAboutDialog(
              context: context,
              applicationName: "SAMO Connect",
              applicationVersion: "3.13",
              applicationIcon: Image.asset("assets/university.png",height: 50,),
              applicationLegalese: "In accordance with federal FERPA laws, SAMO Connect does not collect any student information, including student ID's or illuminate logins. "
            );
          },
        )
      ],
    );
    //The code is commented because instead of manual scrolling with animation,
    //Now PageView is being used

    /*
    controller_minus1To0 = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: -1.0,
      upperBound: 0.0,
    );
    controller_0To1 = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 0.0,
      upperBound: 1.0,
    );

    anim_minus1To0 = new CurvedAnimation(
      parent: controller_minus1To0,
      curve: Interval(0.10, 0.90, curve: Curves.bounceInOut),
    );
    anim_0To1 = new CurvedAnimation(
      parent: controller_0To1,
      curve: Interval(0.10, 0.90, curve: Curves.bounceInOut),
    );

    anim_0To1.addListener(() {
      scrollPercent = controller_0To1.value / numCards;
//      print(scrollPercent);
      setState(() {});
    });

    anim_minus1To0.addListener(() {
      scrollPercent = controller_minus1To0.value / numCards;
//      print(scrollPercent);
      setState(() {});
    });
    */
  }

  Widget HomePage() {
        return Scaffold(
          appBar: theAppBar,
          body:new Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.indigoAccent[700],
            image: DecorationImage(
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.1), BlendMode.dstATop),
              image: AssetImage('assets/backgroundv1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: new ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 50.0),
                child: Center(
                  child: Image.asset("assets/university.png",height: 150,)
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "SAMO Connect",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
    
                  ],
                ),
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 150.0),
                alignment: Alignment.center,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new OutlineButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: mainColor,
                    highlightedBorderColor: Colors.white,
                    onPressed: () => gotoSignup(),
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "SIGN UP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.white,
                    onPressed: () => gotoLogin(),
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "LOGIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: mainColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
    );
  }

  Widget LoginPage() {

    return Scaffold(
      key: loginKey,
      appBar: theAppBar,
      body:new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.15), BlendMode.dstATop),
          image: AssetImage('assets/backgroundv1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(30.0),
            child: Center(
              child: Icon(
                Icons.school,
                color: mainColor,
                size: 50.0,
              ),
            ),
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    "EMAIL",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: mainColor,
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: TextField(
                    obscureText: false,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'abc3@smmk12.org',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    controller: emailLogin,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 24.0,
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    "PASSWORD",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: mainColor,
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '*********',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    controller: passwordLogin,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 5.0,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: new FlatButton(
                  child: new Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  onPressed: () {
                    TextEditingController emailC =TextEditingController();
                    showCupertinoModalPopup(
                      
                      context: context,
                      builder: (c){
                        return CupertinoAlertDialog(
                          title: Text("Forgot Password?"),
                          
                          content: CupertinoTextField(
                            placeholder: "Email",
                            controller: emailC,
                          ),
                          actions: <Widget>[
                            CupertinoButton(
                              
                              child: Text("Cancel",style: TextStyle(color: Colors.red),),
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                            ),
                            CupertinoButton(
                              child: Text("Submit"),
                              onPressed: (){
                                Navigator.of(context).pop();

                                if(emailC.text!=""){
                                  FirebaseAuth.instance.sendPasswordResetEmail(email: emailC.text);
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (c){
                                      return CupertinoAlertDialog(
                                        title: Text("A password reset email has been set."),
                                        content: Text("Please note that outside emails cannot reach smmk12.org email adresses"),
                                        actions: <Widget>[
                                          CupertinoButton(
                                            child: Text("Ok"),
                                            onPressed: (){
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    }
                                  );
                                }
                              },
                            ),
                            
                          ],
                        );
                      }
                    );
                  },
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    color: mainColor,
                    onPressed: (){
                      loginPressed(emailLogin.text,passwordLogin.text);
                    },
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "LOGIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                new Expanded(
                  child: new Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(border: Border.all(width: 0.25)),
                  ),
                ),
                Text(
                  "OR SIGN UP WITH",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                new Expanded(
                  child: new Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(border: Border.all(width: 0.25)),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
            child: new Row(
              children: <Widget>[
                
                new Expanded(
                  child: new Container(
                    margin: EdgeInsets.only(left: 8.0),
                    alignment: Alignment.center,
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new FlatButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: Color(0Xffdb3236),
                            onPressed: () => {},
                            child: new Container(
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Expanded(
                                    child: new FlatButton(
                                      onPressed: ()=>{gotoSignup()},
                                      padding: EdgeInsets.only(
                                        top: 20.0,
                                        bottom: 20.0,
                                      ),
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            MdiIcons.google,
                                            color: Colors.white,
                                            size: 15.0,
                                          ),
                                          Text(
                                            " GOOGLE",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    )
    );
  }

  Widget SignupPage() {


    return Scaffold(
      key: signUpKey,
      appBar: theAppBar,
      body:new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.15), BlendMode.dstATop),
          image: AssetImage('assets/backgroundv1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(50.0),
            child: Center(
              child: Icon(
                Icons.school,
                color: mainColor,
                size: 50.0,
              ),
            ),
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    "EMAIL",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: mainColor,
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: TextField(
                    obscureText: false,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'abc3@smmk12.org',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    controller: emailSignUp,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 24.0,
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    "PASSWORD",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: mainColor,
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '*********',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    controller: passwordSignUp,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 24.0,
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    "CONFIRM PASSWORD",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: mainColor,
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '*********',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    controller: passwordConfirm,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 20.0,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: new FlatButton(
                  child: new Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  onPressed: () => {gotoLogin()},
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 50.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    color: mainColor,
                    onPressed: () {
                      print("YEPPERU");
                      print("EMAIL:::");
                      print(emailSignUp.text);
                      print("PASSWORDS::");
                      print(passwordSignUp.text);
                      print(passwordConfirm.text);
                      print("Sign Up Pressed");
                      signUpPressed(emailSignUp.text, passwordSignUp.text, passwordConfirm.text);
                    },
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "SIGN UP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
    );
  }

  gotoLogin() {
    //controller_0To1.forward(from: 0.0);
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }
  loginPressed(String email, String password) async{
    print("EMALLL");
    print(email);
    print("PASWORRD");
    print(password);
    final emptyEmailSnackbar = SnackBar(
      content: Text('Please input an email',style: TextStyle(color: Colors.white,fontSize: 17),),
      backgroundColor: Colors.red,
      action: 
      SnackBarAction(label: "OK",
        onPressed: (){
          signUpKey.currentState.hideCurrentSnackBar();
        },
        textColor: Colors.white,
        ),
      );
    final emptyPasswordSnackbar = SnackBar(
      content: Text('Please input a password',style: TextStyle(color: Colors.white,fontSize: 17),),
      backgroundColor: Colors.red,
      action: 
      SnackBarAction(label: "OK",
        onPressed: (){
          signUpKey.currentState.hideCurrentSnackBar();
        },
        textColor: Colors.white,
        ),
      );
    final unformattedEmailSnackbar = SnackBar(
      content: Text('Please input a real email',style: TextStyle(color: Colors.white,fontSize: 17),),
      backgroundColor: Colors.red,
      action: 
      SnackBarAction(label: "OK",
        onPressed: (){
          signUpKey.currentState.hideCurrentSnackBar();
        },
        textColor: Colors.white,
        ),
      );
    final noAccountSnackbar = SnackBar(
      content: Text('Please Sign Up',style: TextStyle(color: Colors.white,fontSize: 17),),
      backgroundColor: Colors.indigoAccent,
      action: 
      SnackBarAction(label: "OK",
        onPressed: (){
          signUpKey.currentState.hideCurrentSnackBar();
        },
        textColor: Colors.white,
        ),
      );
    final invalidPasswordSnackbar = SnackBar(
      content: Text('Invalid Password',style: TextStyle(color: Colors.white,fontSize: 17),),
      backgroundColor: Colors.red,
      action: 
      SnackBarAction(label: "OK",
        onPressed: (){
          signUpKey.currentState.hideCurrentSnackBar();
        },
        textColor: Colors.white,
        ),
      );
    final networkSnack = SnackBar(
      content: Text('Unknown Network Error',style: TextStyle(color: Colors.white,fontSize: 17),),
      backgroundColor: Colors.red,
      action: 
      SnackBarAction(label: "OK",
        onPressed: (){
          signUpKey.currentState.hideCurrentSnackBar();
        },
        textColor: Colors.white,
        ),
      );


    if(email!=""){
      if(password!=""){
        //FirebaseAuth.instance.signInWithCredential(TwitterAuthProvider.getCredential());
        Future<AuthResult> theUser = FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

        theUser.catchError((onError){
          loginKey.currentState.showSnackBar(invalidPasswordSnackbar);
        });
        AuthResult cUser = await theUser;
        if(cUser.user!=null){
            Navigator.of(context).pushNamed(MainWindowAndroid.tag);
          
        };
      }else{
        loginKey.currentState.showSnackBar(emptyPasswordSnackbar);
      }
    }else{
      loginKey.currentState.showSnackBar(emptyEmailSnackbar);
    }
  }
  signUpPressed(String email, String password, String passwordConfirm){
    final emptyEmailSnackbar = SnackBar(
      content: Text('Please input an email',style: TextStyle(color: Colors.white,fontSize: 17),),
      backgroundColor: Colors.red,
      action: 
      SnackBarAction(label: "OK",
        onPressed: (){
          signUpKey.currentState.hideCurrentSnackBar();
        },
        textColor: Colors.white,
        ),
      );
    final emptyPasswordSnackbar = SnackBar(
      content: Text('Please input a password',style: TextStyle(color: Colors.white,fontSize: 17),),
      backgroundColor: Colors.red,
      action: 
      SnackBarAction(label: "OK",
        onPressed: (){
          signUpKey.currentState.hideCurrentSnackBar();
        },
        textColor: Colors.white,
        ),
      );
    final passwordtoShortSnackbar = SnackBar(
      content: Text('Please make password atleast 6 characters long',style: TextStyle(color: Colors.white,fontSize: 17),),
      backgroundColor: Colors.red,
      action: 
      SnackBarAction(label: "OK",
        onPressed: (){
          signUpKey.currentState.hideCurrentSnackBar();
        },
        textColor: Colors.white,
        ),
      );
    final passwordsDontMatch = SnackBar(
      content: Text("Passwords don't match",style: TextStyle(color: Colors.white,fontSize: 17),),
      backgroundColor: Colors.red,
      action: 
      SnackBarAction(label: "OK",
        onPressed: (){
          signUpKey.currentState.hideCurrentSnackBar();
        },
        textColor: Colors.white,
        ),
      );
    final invalidEmail = SnackBar(
      content: Text("Please enter a valid email",style: TextStyle(color: Colors.white,fontSize: 17),),
      backgroundColor: Colors.red,
      action: 
      SnackBarAction(label: "OK",
        onPressed: (){
          signUpKey.currentState.hideCurrentSnackBar();
        },
        textColor: Colors.white,
        ),
    );

// Find the Scaffold in the widget tree and use it to show a SnackBar.
    if(email!=""){
      if(password!=""&&passwordConfirm!=""){
        if(password.length>=6){
          if(password==passwordConfirm){
            if(email.contains("@")&&email.split("@").last.contains(".")){
              showCupertinoModalPopup(
                context: context,
                builder: (c){
                  return CupertinoAlertDialog(
                    content: FutureBuilder<AuthResult>(
                      future:FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password),
                      builder: (c,s){
                        if(s.hasError){
                          String baseE = s.error.toString();
                          String baseE2 =baseE.split("(")[1].split(",").first;
                          return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("SERVER ERROR",style: TextStyle(fontSize: 18),),
                    Text(baseE2),
                    RaisedButton(
                      child: Text("OK"),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),

                  ],
                );
                        }else if(s.connectionState!=ConnectionState.done){
                          return ColorLoader3();
                        }else{
                          
                          return Column(
                            children: <Widget>[
                              Text("Sign Up Succesful"),
                              RaisedButton(
                                color: Colors.indigoAccent[700],
                                onPressed: (){
                                  Navigator.of(context).popAndPushNamed(MainWindowAndroid.tag);
                                },
                                child: Text("Great!",style: TextStyle(color: Colors.white),),
                              ),
                            ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        );
                      } 
                    },
                  ),
                );
              }
            );
            }else{
              signUpKey.currentState.showSnackBar(invalidEmail);
            }
          }else{
            signUpKey.currentState.showSnackBar(passwordsDontMatch);
          }
        }else{
          signUpKey.currentState.showSnackBar(passwordtoShortSnackbar);
        }
      }else{
        signUpKey.currentState.showSnackBar(emptyPasswordSnackbar);
      }
    }else{
      signUpKey.currentState.showSnackBar(emptyEmailSnackbar);
    }
  }
  gotoSignup() {
    //controller_minus1To0.reverse(from: 0.0);
    setState(() {
      titleWidget = Text("Sign Up");
    });
    build(context);
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  PageController _controller = new PageController(initialPage: 1, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
//      child: new GestureDetector(
//        onHorizontalDragStart: _onHorizontalDragStart,
//        onHorizontalDragUpdate: _onHorizontalDragUpdate,
//        onHorizontalDragEnd: _onHorizontalDragEnd,
//        behavior: HitTestBehavior.translucent,
//        child: Stack(
//          children: <Widget>[
//            new FractionalTranslation(
//              translation: Offset(-1 - (scrollPercent / (1 / numCards)), 0.0),
//              child: SignupPage(),
//            ),
//            new FractionalTranslation(
//              translation: Offset(0 - (scrollPercent / (1 / numCards)), 0.0),
//              child: HomePage(),
//            ),
//            new FractionalTranslation(
//              translation: Offset(1 - (scrollPercent / (1 / numCards)), 0.0),
//              child: LoginPage(),
//            ),
//          ],
//        ),
//      ),
        child: PageView(
          controller: _controller,
          physics: new AlwaysScrollableScrollPhysics(),
          children: <Widget>[LoginPage(), HomePage(), SignupPage()],
          scrollDirection: Axis.horizontal,
        ));
  }
}
