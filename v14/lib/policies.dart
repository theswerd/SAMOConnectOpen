import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';
import 'color_loader_3.dart';
import 'package:flutter/cupertino.dart';
import 'constants.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:firebase_mlkit_language/firebase_mlkit_language.dart';


class PolicyPage extends StatefulWidget {

  static String tag = "Policies";
  @override
  _PolicyPageState createState() => _PolicyPageState();
  
}

class _PolicyPageState extends State<PolicyPage> with TickerProviderStateMixin {
  List allPolicies = [];
  List usedPolicies = [];
  Widget title;
  bool searching =false;
  double textSize = 14;
  List<Widget> actions = [];
  List currentPolicies = [];
  String currentLanguage = SupportedLanguages.English;
  AnimationController animationC;
  Widget body;
  LanguageTranslator englishToSpanish;
  LanguageTranslator englishToFrench;
  LanguageTranslator englishToChinese;
  LanguageTranslator englishToSomeRandomLanguage;
  Icon translateIcon = Icon(MdiIcons.translate);
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() { 
    textSize = 14;
    // allPolicies = [    
    // // 
    // ];
    englishToSpanish = FirebaseLanguage.instance.languageTranslator(SupportedLanguages.English, SupportedLanguages.Spanish);
    englishToFrench = FirebaseLanguage.instance.languageTranslator(SupportedLanguages.English, SupportedLanguages.French);
    englishToChinese = FirebaseLanguage.instance.languageTranslator(SupportedLanguages.English, SupportedLanguages.Chinese);
    englishToChinese = FirebaseLanguage.instance.languageTranslator(SupportedLanguages.English, SupportedLanguages.Urdu);

    animationC = new AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    currentPolicies = allPolicies;
    usedPolicies = currentPolicies;
    title = Text("Policies");
    actions = [
      Tooltip(
        message: "Powered by Google Translate",
        child: IconButton(
          icon: translateIcon,
          splashColor: Colors.yellowAccent,
          onPressed: (){
            showCupertinoModalPopup(
              context: context,
              builder: (c)=>CupertinoActionSheet(
                cancelButton: Constants.cancelAction(context),
                title: Text("Languages"),
                actions: <Widget>[
                    CupertinoActionSheetAction(
                    child: Text("Spanish"),
                    onPressed: () async{
                      
                      Navigator.of(context).pop();
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(content: Text("Translating to Spanish can take up to 30 seconds depending on your device"),action: SnackBarAction(label: "Ok",textColor: Colors.white,onPressed: ()=>_scaffoldKey.currentState.hideCurrentSnackBar()),backgroundColor: Constants.baseColor,behavior: SnackBarBehavior.fixed,duration: Duration(seconds: 15),)
                      );
                      List newList = [];
                      for (Map policy in allPolicies) {
                        Map newPolicy = policy;
                        String newName = await englishToSpanish.processText(policy['name']);
                        // String newDescription = await englishToSpanish.processText(policy['name']);
                        if(policy['inlineView']){
                          newPolicy['type'][0] = newName;
                          String newDescription = await englishToSpanish.processText(newPolicy['type'][1]);
                          newPolicy['type'][1] = newDescription;
                        }
                        
                        newPolicy['name'] = newName;
                        newList.add(newPolicy);
                      }
                      setState(() {
                        setState(() {
                          translateIcon = Icon(MdiIcons.translateOff);
                        });
                        currentLanguage = SupportedLanguages.Spanish;
                        currentPolicies = newList;
                        body = bodyMaker(currentPolicies);
                      });
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: Text("French"),
                    onPressed: () async{
                      Navigator.of(context).pop();
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(content: Text("Translating to French can take up to 30 seconds depending on your device"),action: SnackBarAction(label: "Ok",textColor: Colors.white,onPressed: ()=>_scaffoldKey.currentState.hideCurrentSnackBar()),backgroundColor: Constants.baseColor,behavior: SnackBarBehavior.fixed,duration: Duration(seconds: 15),)
                      );
                      List newList = [];
                      for (Map policy in allPolicies) {
                        Map newPolicy = policy;
                        String newName = await englishToFrench.processText(policy['name']);
                        // String newDescription = await englishToSpanish.processText(policy['name']);
                        if(policy['inlineView']){
                          newPolicy['type'][0] = newName;
                          String newDescription = await englishToFrench.processText(newPolicy['type'][1]);
                          newPolicy['type'][1] = newDescription;
                        }
                        
                        newPolicy['name'] = newName;
                        newList.add(newPolicy);
                      }
                      setState(() {
                        currentLanguage = SupportedLanguages.French;
                        currentPolicies = newList;
                        //body = bodyMaker(newList);
                      });
                    },
                  ),
                ],
              )
            );
          },
        ),
      ),
      IconButton(
        splashColor: Colors.yellow,
        color: Colors.white,
        icon: Icon(Icons.format_size),
        onPressed: (){
          if(textSize==14){
            print("MINI TEXT");
            setState(() {
              textSize=18;
            });
          }else{
            setState(() {
              textSize=14;
            });
          }
        },
      ),
      IconButton(
        splashColor: Colors.yellow,
        color: Colors.white,
        icon: Icon(Icons.info_outline),
        onPressed: (){
          Constants.showInfoBottomSheet(
            [
              Constants.officialWebsiteAction(context, "http://www.samohi.smmusd.org/About/policies/index.html"),
              CupertinoActionSheetAction(
                child: Text("Share"),
                onPressed: (){
                  Share.share("Think your in trouble? Lucky SAMO Connect has the school policies -- https://samoconnect.page.link/SamoConnect");
                  //launch("http://www.samohi.smmusd.org/About/policies/index.html");
                },
              ),
              Constants.ratingAction(context),
              CupertinoActionSheetAction(
                child: Text("Extra Info"),
                onPressed: () {

                  showCupertinoModalPopup(
                    context: context,
                    builder: (c){
                      return CupertinoAlertDialog(
                        title: Text("Extra Info"),
                        content: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(text: "The policy view is a list of the 18 policies shown on "),
                              TextSpan(text: "The SAMOHI Policy Page",style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: ". This data is "),
                              TextSpan(text: "stored locally",style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: " as the policies don't change often. \n\nYou may notice some of the policies are empty. This is because we couldn't fit them on here, and don't want to mischaracterize them in our summaries."),
                            ]
                          ),
                        ),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text("Ok"),
                            onPressed: (){
                              Constants.pop(context);
                            },
                          )
                        ],
                      );
                    }
                  );
                },
              )
            ], 
            context
            );
          },
        ),
      // IconButton(
      //   splashColor: Colors.yellow,
      //   color: Colors.white,
      //   icon: Icon(Icons.search),
      //   onPressed: (){
      //     Vibrate.feedback(FeedbackType.light);
      //     if(searching){
      //       searching =false;
      //       setState(() {
      //         title =Text("Policies");
      //       });
      //     }else{
      //       searching =true;
      //       setState(() {
      //         title =Container(
      //       padding: EdgeInsets.symmetric(vertical:6),
      //       child:TextField(
      //       style: TextStyle(color: Colors.white),

      //       decoration: InputDecoration(
      //         labelText: "Policy Name",
      //         labelStyle: TextStyle(color: Colors.white),
      //         focusedBorder: borderMaker(Colors.yellow),
      //         enabledBorder: borderMaker(Colors.white),
      //         border: borderMaker(Colors.lightBlue),
              
      //       ),
      //       onChanged: (a){
      //         usedPolicies = [];
      //         for (Map policy in currentPolicies) {

      //             if(policy["name"].toString().toUpperCase().contains(a.toUpperCase())){
      //               usedPolicies.add(policy);
      //             }
                
      //         }
      //         setState(() {
      //           body =bodyMaker(usedPolicies);
      //         });
      //       },
      //     )
      //     );

      //       });
      //     }
          
      //   },
      // )
    ];
   // 

  }
  

  @override
  Widget build(BuildContext context) {
    body =bodyMaker(usedPolicies);
   // 


    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        child: AnimatedIcon(icon:AnimatedIcons.search_ellipsis,progress:animationC),
        backgroundColor: Constants.baseColor,
        onPressed: (){
          if(searching){
            animationC.reverse();
            searching =false;
            setState(() {
              title =Text("Policies");
            });
          }else{
            animationC.forward();

            searching =true;
            setState(() {
              title =Container(
            padding: EdgeInsets.symmetric(vertical:6),
            child:TextField(
            style: TextStyle(color: Colors.white),

            decoration: InputDecoration(
              labelText: "Policy Name",
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: borderMaker(Colors.yellow),
              enabledBorder: borderMaker(Colors.white),
              border: borderMaker(Colors.lightBlue),
              
            ),
            onChanged: (a){
              usedPolicies = [];
              for (Map policy in currentPolicies) {

                  if(policy["name"].toString().toUpperCase().contains(a.toUpperCase())){
                    usedPolicies.add(policy);
                  }
                
              }
              setState(() {
                body =bodyMaker(usedPolicies);
              });
            },
          )
          );

            });
          }
          
        
      

        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent[700],
        title: AnimatedSwitcher(child: title, duration: Duration(milliseconds: 400),transitionBuilder: (w,a)=>ScaleTransition(scale: a,child: w,),),
        actions: actions,
      ),
      body: body,
    );
  }

  ListView bodyMaker(usedPolicies) {
    return ListView.separated(
    itemCount: usedPolicies.length,
    padding: EdgeInsets.symmetric(horizontal:25),
    separatorBuilder: (c,i)=>Container(height: 20,),
    itemBuilder: (c,i){
      Widget info =Container(height: 0,);
      if(usedPolicies[i]["inlineView"]==true){
        info =Text(usedPolicies[i]["type"][1],style: TextStyle(fontSize: textSize,));
      }
      return RaisedButton(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: <Widget>[
              Text(usedPolicies[i]["name"],style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.start,textScaleFactor: textSize/16>=1?textSize/16:1,),
              Expanded(
                child: Container(),
              ),
              CupertinoButton(
              child: Text("Website"),
              padding: EdgeInsets.zero,
              onPressed: (){
                launch(usedPolicies[i]["website"]);
              },
              )
            ],),
              info

            
            
          ],
        ),
        color: Colors.white,
        onPressed: () async{
          //String spanishPolicy = await englishToSpanish.processText(usedPolicies[i]["type"][1]);

          if(usedPolicies[i]["inlineView"]){
            policyDialog(usedPolicies[i]["type"][0], usedPolicies[i]["type"][1]);
          }
        },
      );
    },
  );
  }

  policyDialog(String title, String description){
    showCupertinoModalPopup(
      context: context,
      builder: (c){
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(description),
        //  actionScrollController: ScrollController(),
          actions: <Widget>[
            CupertinoDialogAction(
              
              isDefaultAction: true,
              child: Text("Share"),
              onPressed: (){
                Share.share("The SAMOHI "+title+": \n"+description+"\n\n To see all the SAMOHI Policies, check out SAMO Connect -- https://samoconnect.page.link/SamoConnect");
                //Navigator.of(context).pop();
              }
            ),
            CupertinoDialogAction(
              isDefaultAction: false,
              child: Text("Copy"),
              onPressed: (){
                //Share.share("The SAMOHI "+title+": \n"+description+"\n\n To see all the SAMOHI Policies, check out SAMO Connect -- https://samoconnect.page.link/SamoConnect");
                Clipboard.setData(ClipboardData(text: description));
                Navigator.of(context).pop();
              }
            ),
      
            
            CupertinoDialogAction(
              isDefaultAction: false,
              child: Text("Copy"),
              onPressed: (){
                //Share.share("The SAMOHI "+title+": \n"+description+"\n\n To see all the SAMOHI Policies, check out SAMO Connect -- https://samoconnect.page.link/SamoConnect");
                Clipboard.setData(ClipboardData(text: description));
                Navigator.of(context).pop();
              }
            ),

            CupertinoDialogAction(
              child: Text("Ok"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            
             
          ],
        );
      }
    );
 }
}
OutlineInputBorder borderMaker(Color color) {
   return OutlineInputBorder(
              borderSide: BorderSide(color: color),
              borderRadius: BorderRadius.circular(10)
            );
 }
