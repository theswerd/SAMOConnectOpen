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

<<<<<<< HEAD
class _PolicyPageState extends State<PolicyPage> with TickerProviderStateMixin {
  final List allPolicies = [
=======
class _PolicyPageState extends State<PolicyPage> {
  List allPolicies = [];
  List usedPolicies = [];
  Widget title;
  bool searching =false;
  double textSize;
  List<IconButton> actions = [];

  Widget body;

  @override
  void initState() { 
    textSize = 14;
    // allPolicies = [    
    // // 
    // ];

    super.initState();
    allPolicies= [
>>>>>>> parent of 3819e4a... 4.04 iOS Update ready
    {
      "name":"Attendance Policy Q&A",
      "website":"http://www.samohi.smmusd.org/About/policies/AttendanceQandA.pdf",
      "inlineView":false
    },
    {
      "name": "Dance Guidelines", 
      "website":"http://www.samohi.smmusd.org/About/policies/index.html#Dance",
      "inlineView":true,
      "type":["Dance Guidelines", "Dance Guidelines\n1. Students are expected to behave and dress in a respectful manner befitting the Santa Monica-Malibu Unified School District Dress Code.\n2. All students are expected to dance appropriately with respect for themselves, their partners, and others. (No suggestive dancing).\n3. Final interpretation of appropriate dance is at the discretion of the chaperones. Students will be given one warning and on the next offense will be asked to leave the dance.\n4. Guests under 21 years of age may attend a Samohi event with prior written approval of the Administration in charge of Activities. Requests for approval must be submitted no fewer than 7 days prior to the scheduled activity."]

    },
    {
      "name":"Forbidden on Campus",
      "website":"http://www.samohi.smmusd.org/About/policies/index.html#Forbidden",
      "inlineView":true,
      "type":["Forbidden on Campus","__ Tobacco, drugs, drug paraphernalia, alcoholic beverages.\n__ Weapons (or any item used as a weapon) and any items that resembles a weapon.\n__ Wallet chains, toys such as water pistols and super soakers.\n__ Any other items that school officials consider dangerous or hazardous.\n__ Permanent markers, glue, or aerosol canisters.\n__ Roller skates/blades, skateboards may be carried. Their use on campus is prohibited. Bicycles shall be locked at the racks adjacent to the 7th & Michigan entrance.\n\nStudents found in possession of the above listed items will be suspended for a maximum of 5 days and possibly recommended for expulsion. Students, lockers and personal receptacles are subject to search, and forbidden items are subject to seizure and / or confiscation."]
    }, 
    {
      "name":"Homework Policy",
      "website":"http://www.samohi.smmusd.org/Admin/pdf/HomeworkPolicy030515.pdf",
      "inlineView":false
    },
    {
      "name":"Attendance/Tardy Policy",
      "website":"http://www.samohi.smmusd.org/About/policies/AttendanceTardyPolicy.pdf",
      "inlineView":false
    },
    {
      "name":"Discipline/Counseling",
      "website":"http://www.samohi.smmusd.org/About/policies/index.html#Discipline%20Procedures",
      "inlineView":true,
      "type":["Discipline/Counseling Procedures", "A Discipline Referral is completed by a faculty member when a student violates a class or school rule. Sample offenses include profanity/vulgarity, disrupting class, and defiance (refusing to do what a teacher or any school staff person asks). School staff persons have disciplinary authority anywhere on campus and at all school events. Serious violations of the Education Code such as fighting, smoking, and use or possession of alcohol, drugs or weapons will result in a student being referred for suspension or expulsion."]
    },
    {
      "name":"Gambling",
      "website":"http://www.samohi.smmusd.org/About/policies/index.html#Gambling",
      "inlineView":true,
      "type":["Gambling", "Samohi has a policy of NO GAMBLING."]
    },
    {
      "name":"Sexual Harassment",
      "website":"http://www.samohi.smmusd.org/About/policies/index.html#Harass",
      "inlineView":true,
      "type":["Sexual Harassment", "The Board of Education prohibits sexual harassment of any student by any person. Teachers shall discuss the policy with their students in age-appropriate ways and students will be taught that they need not endure any form of sexual harassment. An student who engages in sexual harassment may be subject to disciplinary action up to and including expulsion."]
    },
    {
      "name":"Academic Honesty Policy",
      "website":"http://www.samohi.smmusd.org/About/policies/index.html#Academic",
      "inlineView":true,
      "type":["Academic Honesty Policy", "Samohi believes that personal integrity is basic to all solid achievement and that students will reach their full potential only be being honest with themselves and others. Samohi also believes that academic integrity is basic to the progress of the school community toward rich learning and the respect of outside communities. Samohi expects all students to respect the educational purposes underlying all school activities and also expects administration, faculty, and staff to provide an environment that encourages honesty. Students caught cheating will receive a zero on the assignment."]
    },
    {
      "name":"Discipline Referrals",
      "website":"http://www.samohi.smmusd.org/About/policies/index.html#Discipline%20Referral",
      "inlineView":true,
      "type":["Discipline Referrals", "A Discipline Referral is completed by a faculty member when a student violates a class or school rule. Sample offenses include profanity/vulgarity, disrupting class, and defiance (refusing to do what a teacher or any school staff person asks). School staff persons have disciplinary authority anywhere on campus and at all school events. Serious violations of the Education Code such as fighting, smoking, and use or possession of alcohol, drugs or weapons will result in a student being referred for suspension or expulsion."]
    },
    {
      "name":"Hat Policy",
      "website":"http://www.samohi.smmusd.org/About/policies/index.html#Hat",
      "inlineView":true,
      "type":["Hat Policy","Santa Monica High School will permit students to wear hats and caps on campus in order to protect students from the sun. All students are required to adhere to the following guidelines when wearing hats or caps on campus.\n\nHats may only be worn outside of school buildings. Hats worn inside school buildings, including classrooms, may be confiscated.\nStudents may wear any of the following hats or caps:\n__ School hats or caps provided by an authorized ASB organization.\n__ Authorized ASB organizations include hats or caps sold in the Vikes' Inn, by a school athletic team or otherwise approved by ASB.\n__ Plain blue or gold hats or caps.\n__ Students may not wear any other hats or caps. Hats or caps with commercial logos are not permitted. In addition, bandanas, scarves, headbands, or any other kind of head coverings are not allowed.\n__ Approved hats or caps that have been altered are not allowed. \n\nStudents who violate any part of this hat policy will be given the opportunity to remove the hat, cap or other head covering. If this corrective action does not result in a positive outcome, students will be considered in defiance of authority and additional disciplinary action will be imposed."]
    },
    {
      "name":"Student Code of Conduct",
      "website":"http://www.samohi.smmusd.org/About/policies/index.html#Student%20Code",
      "inlineView":true,
      "type":["Student Code of Conduct","__ Be in your seat and prepared to work when the bell rings.\n__ Meet all school and class deadlines including homework, projects, and papers. Do all required coursework.\n__ Bring required materials to class everyday including your ID card and Student planner.\n__ Engage actively in listening and learning. No talking when the teacher is talking or when a student is presenting a question or answer.\n__ Be honest. No cheating, plagiarism, or theft.\n__ Show respect toward yourself and others, use appropriate language, refrain from hurtful behavior or language, and disruptive activity.\n__ Be accountable. Take responsibility for your own actions.\n__ Dress appropriately for school. No head coverings in the classroom.\n__ Only water is allowed in the classroom. No eating, drinking, or chewing gum.\n__ Keep electronic devices turned off and out of sight. No headphones are to be worn in the classroom.\n__ Help to maintain a clean and safe learning environment. Throw your trash in the designated receptacle."]
    },
    {
      "name":"Class Drop Policy",
      "website":"http://www.samohi.smmusd.org/Students/dropping.html",
      "inlineView":false,
    },
    {
      "name":"Dress Code",
      "website":"http://www.samohi.smmusd.org/About/policies/index.html#Dress",
      "inlineView":true,
      "type":["Dress Code","""In accordance with policy set forth by the Santa Monica-Malibu Board of Education (BP5132) students shall not express themselves in ways that are "obscene, libelous, or slanderous." In its desire to keep district schools and students free from the harmful influence of gangs; the Board also prohibits "the presence of any apparel; jewelry, accessory, notebook or manner of grooming which by virtue of its color, arrangement, trademark, or any other attribute, denotes membership in any such group." Students who violate any part of this dress code will be given an opportunity to change into their own clothing or to school-provided alternative clothing. The Administration reserves the right to make final determination as to the appropriateness of dress."""]
    },
    {
      "name":"Hazing Policy",
      "website":"http://www.samohi.smmusd.org/About/policies/index.html#Hazing",
      "inlineView":true,
      "type":["Hazing Policy",'As defined by the California Education Code "hazing" includes any method of initiation or pre-initiation into a student organization or any pastime or amusement engaged in with respect to such an organization which causes, or is likely to cause, bodily danger, physical harm, or personal degradation or disgrace resulting in physical or mental harm, to any student or other person attending any school; but the term "hazing" does not include customary athletic events or other similar contests or competition (California Education Code Section 32051).']
    },
    {
      "name":"Tobacco Free Campus",
      "website":"http://www.samohi.smmusd.org/About/policies/index.html#Tobacco",
      "inlineView":true,
      "type":["Tobacco Free Campus","The Board of Education finds and declares that it is in the best interest of the Santa Monica-Malibu Unified School District, its students and employees, and the public to:\n__ Prohibit the use of tobacco products in all district facilities and vehicles\n__ Prohibit the use of tobacco products at all times on District grounds. This prohibition applies to all employees, students, visitors and other persons at any activity or athletic event on property owned, leased or rented by or from the District."]
    },
    {
      "name":"Controlled Substance Policy",
      "website":"http://www.samohi.smmusd.org/About/policies/index.html#Controlled",
      "inlineView":true,
      "type":["Controlled Substance Policy","Unlawfully possessing, using, selling, being under the influence of, or otherwise furnishing to others a controlled substance or alcoholic beverage, or intoxicant of any kind, at any school activity or on any school district or adjacent property, is considered to be a threat to the educational process. For the offenses indicated, the student, under guidelines indicated below, may be subject to suspension, transfer to another school, expulsion and/or an obligation to complete the district counseling requirement."]
    },
    {
      "name":"Electronics/Cell Phone Policy",
      "website":"http://www.samohi.smmusd.org/About/policies/index.html#Cell",
      "inlineView":true,
      "type":["Electronics/Cell Phone Policy","Santa Monica High School allows the use of electronic devices for non-academic means on campus ONLY BEFORE SCHOOL, BETWEEN PERIODS, DURING LUNCH, and AFTER SCHOOL.\n\nElectronic devices include, but are not limited to: cell phones, cameras, iPods/MP3 players, laptops/tablets, portable speakers, handheld electronic games, headphones/earbuds, etc.Students and their parents/guardians take full responsibility for any and all electronic signaling devices (including cell phones) which the student may bring to school.In no event or circumstance will the district or its staff be held responsible or liable for the loss, theft or damage to any such device. This includes the loss, theft, or damage of confiscated cell phones and similar devices (SMMUSD AR 5131.8).\nShould you be in violation of this policy, the following progressive steps will be taken:\n\nConsequences:\n1st offense: Phone taken away. Phone will be released to student at end of the day. Student conference with advisor. House personnel will make parent contact.\n\n2nd offense: Phone taken away. Confiscation of item until parent/guardian come to retrieve it. Parent/Student conference with advisor. Lunch detention assigned.\n\n3rd or more offenses: Phone taken away until parent/guardian come to retrieve it. Two hours of Saturday School will be assigned. Student will turn in cell phone for 3 days to house office from beginning to end of school day. Parent conference with House Principal.\n\nSanta Monica High School reserves the right to take away phones at any time for inappropriate use. Santa Monica High School is not responsible for lost or stolen phones."]
    }
    ];

  List currentPolicies = [];
  List usedPolicies = [];
  String currentLanguage = SupportedLanguages.English;
  Widget title;
  bool searching =false;
  double textSize;
  List<Widget> actions = [];
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

    super.initState();
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
