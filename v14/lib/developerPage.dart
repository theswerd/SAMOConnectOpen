import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';
import 'package:v14/constants.dart' as prefix0;
import 'constants.dart';

class DeveloperPage extends StatefulWidget {
 static String tag = "developerPage";
  @override
  _DeveloperPageState createState() => _DeveloperPageState();
}

class _DeveloperPageState extends State<DeveloperPage> {
  double fontSize = 15;
  Widget bodyBelow;
  double textScale;
  @override
  void initState() {
    super.initState();
    textScale = 1;
    bodyBelow = Column(
      
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(height: 40,),
        RichText(
          textScaleFactor: textScale,
          textAlign: TextAlign.center,
          text:TextSpan(
            style: TextStyle(color: Colors.black),
            children: 
              [
                TextSpan(text: "These are the main developers\n\n",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                TextSpan(text: "To find out more about them, click ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                TextSpan(text: "their photos",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                TextSpan(text: ". \n\nWe also want to",style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                TextSpan(text: " thank ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                TextSpan(text: "all of amazing people who helped ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                TextSpan(text: "inspire this app. \n\n",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                TextSpan(text: "Thanks to ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                TextSpan(text: "Claudia Sherman",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                TextSpan(text: " for helping ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                TextSpan(text: "write translations.\n\n",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                TextSpan(text: "Thanks to ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                TextSpan(text: "Matteo Marquez",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                TextSpan(text: " for inspiring the ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                TextSpan(text: "ASB Event View and Polls\n\n",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                TextSpan(text: "Thanks to ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                TextSpan(text: "Antonio Shelton",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                TextSpan(text: " for ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                TextSpan(text: "approving our app",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                TextSpan(text: "\n\nThanks to ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                TextSpan(text: "Lucky Harbor",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                TextSpan(text: " and ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                TextSpan(text: "Christian Adera",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                TextSpan(text: " for your great support\n\n",style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                //TextSpan(text: "ASB Event View and Polls",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                TextSpan(text: "Thanks to ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                TextSpan(text: "Ethan Hobkins",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                TextSpan(text: " for his earlier drafts of ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                TextSpan(text: "our logo\n\n",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                TextSpan(text: "Thanks to ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                TextSpan(text: "Lucas Soeth",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                TextSpan(text: " for his ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                TextSpan(text: "code cleaning",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ]
          )
          
        )
      ],
    );

  }
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Developed By"),
        backgroundColor: Colors.indigoAccent[700],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            color: Colors.white,
            splashColor: Colors.yellowAccent,
            onPressed: (){
              Share.share("Wanna know about SAMO Connect? Check out the developer page! -- https://samoconnect.page.link/SamoConnect");
            },
          ),
          IconButton(
            icon: Icon(Icons.info_outline),
            splashColor: Colors.yellow,
            onPressed: (){
              showCupertinoModalPopup(
                context: context,
                builder: (c)=>CupertinoActionSheet(
                  cancelButton: prefix0.Constants.cancelAction(context),
                  title: Text("Extra Info"),
                  actions: <Widget>[
                    Constants.ratingAction(context),
                    CupertinoActionSheetAction(
                      child: Text("Join the team?"),
                      onPressed: (){
                        Navigator.of(context).pop();
                        launch("https://forms.gle/vyJF2XWDgycXifQg7");
                      },
                    )
                  ],
                )
              );   
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: <Widget>[
          Text(
            "Developers",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),
            textScaleFactor: textScale,
          ),
          Container(
            height: 210,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  width: 170,
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        splashColor: Colors.redAccent[400],
                        onTap: (){
                          setState(() {
                            bodyBelow = Column(
                              children: <Widget>[
                                Container(height: 20,),
                                Text(
                                  "Benjamin Swerdlow",
                                  textAlign: TextAlign.center,
                                  textScaleFactor: textScale,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22
                                  ),
                                ),
                                Text(
                                  "Programmer",
                                  textAlign: TextAlign.center,
                                  textScaleFactor: textScale,
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 19
                                  ),
                                ),
                                Container(
                                  height: 30,
                                ),
                                RichText(
                                  textAlign: TextAlign.center,
                                  textScaleFactor: textScale,
                                  text: TextSpan(
                                    style: TextStyle(color: Colors.black, fontSize: 20),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "Benjamin Swerdlow is a "
                                      ),
                                      TextSpan(
                                        text: "programmer, surfer, competitive chess player, and martial artist",
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                      ),
                                      TextSpan(
                                        text: ". He volunteers for "
                                      ),
                                      TextSpan(
                                        text: "four hours a week",
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                      ),
                                      TextSpan(
                                        text: ", three programming for"
                                      ),
                                      TextSpan(
                                        text: " Hack For LA",
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                      ),
                                      TextSpan(
                                        text: ", and one "
                                      ),
                                      TextSpan(
                                        text: "helping special needs children",
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                      ),
                                      TextSpan(
                                        text: ". Some of his code is going up on the Santa Monica City Website in late 2019. He is the "
                                      ),
                                      TextSpan(
                                        text: "head coder",
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                      ),
                                      TextSpan(
                                        text: " of the Santa Monica High School Robotics Team. \n\n"
                                      ),
                                      TextSpan(
                                        text: "Benjamin Swerdlow is the SAMO Connect "
                                      ),
                                      TextSpan(
                                        text: "programmer",
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                      ),
                                      TextSpan(
                                        text: ". He is responsible for the "
                                      ),
                                      TextSpan(
                                        text: "code",
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                      ),
                                      TextSpan(
                                        text: " and is the original developer of "
                                      ),
                                      TextSpan(
                                        text: "SAMO Connect",
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                      ),
                                      TextSpan(
                                        text: "."
                                      ),
                                    ]
                                  ),
                                ),
                                Container(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                    Text("Instagram:",style: TextStyle(fontSize: 20),textScaleFactor: textScale,),
                                    CupertinoButton(
                                      padding: EdgeInsets.zero,
                                  child: Text("@swerdlowben",textScaleFactor: textScale,),
                                  onPressed: (){
                                    showCupertinoModalPopup(
                                      context: context,
                                      builder: (c){
                                        return CupertinoActionSheet(
                                          message: Text("@swerdlowben",textScaleFactor: textScale,),
                                          title: Text("Benjamin Swerdlow's Instagram",textScaleFactor: textScale,),
                                          cancelButton: Constants.cancelAction(context),
                                          actions: <Widget>[
                                            CupertinoActionSheetAction(
                                              isDefaultAction: true,
                                              child: Text("Copy",textScaleFactor: textScale,),
                                              onPressed: (){
                                                Clipboard.setData(ClipboardData(text: "@swerdlowben"));
                                              },
                                              
                                            ),
                                            CupertinoActionSheetAction(
                                              isDefaultAction: false,
                                              child: Text("Share",textScaleFactor: textScale,),
                                              onPressed: (){
                                                Constants.shareString("Benjamin Swerdlow's Instagram is @swerdlowben -- To find out more about Ben, check out her bio on SAMO Connect -- https://samoconnect.page.link/SamoConnect");
                                              },
                                              
                                            )
                                          ],
                                        );
                                      }
                                    );
                                  },
                                )

                                  ],),
                                  CupertinoButton(
                                    child: Text("Email"),
                                    onPressed: (){
                                      showCupertinoModalPopup(
                                        context: context,
                                        builder: (c){
                                          return CupertinoActionSheet(
                                            title: Text("Benjamin's Email"),
                                            cancelButton: Constants.cancelAction(context),
                                            actions: <Widget>[
                                              CupertinoActionSheetAction(
                                                isDefaultAction: true,
                                                child: Text("Copy"),
                                                onPressed: (){
                                                  Clipboard.setData(ClipboardData(text: "Swerdlowbenjamin@gmail.com"));
                                                  Constants.pop(context);
                                                },
                                              ),
                                              CupertinoActionSheetAction(
                                                
                                                child: Text("Share"),
                                                onPressed: (){
                                                  prefix0.Constants.shareString("Email Ben at swerdlowbenjamin@gmail.com -- to find out more about Ben, check out his bio on https://samoconnect.page.link/SamoConnect");
                                                  //Clipboard.setData(ClipboardData(text: "Swerdlowbenjamin@gmail.com"));
                                                  Constants.pop(context);
                                                },
                                              )
                                            ],
                                          );
                                        }
                                      );
                                    },
                                  ),
                                  Column(
                                    children: <Widget>[
                                    Text("Linkedin:",style: TextStyle(fontSize: 20),textScaleFactor: textScale,),
                                    CupertinoButton(
                                      padding: EdgeInsets.zero,
                                  child: Text("Benjamin Swerdlow",textScaleFactor: textScale,),
                                  onPressed: (){
                                    showCupertinoModalPopup(
                                      context: context,
                                      builder: (c){
                                        return CupertinoActionSheet(
                                          title: Text("Benjamin's Linkedin",textScaleFactor: textScale,),
                                          //content: Text("https://www.linkedin.com/in/benjamin-swerdlow-076089171"),
                                          cancelButton: prefix0.Constants.cancelAction(context),
                                          actions: <Widget>[
                                            CupertinoActionSheetAction(
                                              isDefaultAction: true,
                                              child: Text("Copy",textScaleFactor: textScale,),
                                              onPressed: (){
                                                Constants.pop(context);
                                                Clipboard.setData(ClipboardData(text: "https://www.linkedin.com/in/benjamin-swerdlow-076089171"));
                                              },
                                              
                                            ),
                                            CupertinoActionSheetAction(
                                              isDefaultAction: false,
                                              child: Text("Share",textScaleFactor: textScale,),
                                              onPressed: (){
                                                Constants.pop(context);
                                                Constants.shareString("Benjamin Swerdlow's Linkedin is https://www.linkedin.com/in/benjamin-swerdlow-076089171 -- To find out more about Jessica, check out her bio on SAMO Connect -- https://samoconnect.page.link/SamoConnect");
                                              },
                                              
                                            )
                                          ],
                                        );
                                      }
                                    );
                                  },
                                )

                                  ],)
                                ],),
                              ],
                            );
                          });
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.asset("assets/ben.png",),
                        ),
                      ),
                      Text("Benjamin Swerdlow", style: TextStyle(fontSize: 18),textAlign: TextAlign.center),
                      Text("Head Developer", style: TextStyle(fontSize: 16, color: Colors.grey[700]),textAlign: TextAlign.center)


                    ],
                  ),
                  
                ),
                Container(width: 20,),
                Container(
                  width: 170,
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        splashColor: Colors.indigoAccent[700],
                        onTap: (){
                          setState(() {
                            bodyBelow = Column(
                              children: <Widget>[
                                Container(height: 20,),
                                Text(
                                  "Jessica Golden",
                                  textAlign: TextAlign.center,
                                  textScaleFactor: textScale,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22
                                  ),
                                ),
                                Text(
                                  "Graphic Designer",
                                  textAlign: TextAlign.center,
                                  textScaleFactor: textScale,
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 19
                                  ),
                                ),
                                Container(
                                  height: 30,
                                ),
                                RichText(
                                  textAlign: TextAlign.center,
                                  textScaleFactor: textScale,
                                  text: TextSpan(
                                    style: TextStyle(color: Colors.black, fontSize: 20),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "Jessica Golden is a "
                                      ),
                                      TextSpan(
                                        text: "pationate musician and graphic designer",
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                      ),
                                      TextSpan(
                                        text: ". She is in marching band, concert band, orchestra, and pit. She also is a "
                                      ),
                                      TextSpan(
                                        text: "captain",
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                      ),
                                      TextSpan(
                                        text: " of The SAMOHI Science Olympiad, "
                                      ),
                                      TextSpan(
                                        text: "president",
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                      ),
                                      TextSpan(
                                        text: " of puzzle club, and a "
                                      ),
                                      TextSpan(
                                        text: "captain",
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                      ),
                                      TextSpan(
                                        text: " of mathletes. Aside from school, she "
                                      ),
                                      TextSpan(
                                        text: "volunteers every week",
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                      ),
                                      TextSpan(
                                        text: " at her hebrew school.\n\n"
                                      ),
                                      TextSpan(
                                        text: "Jessica Golden is the SAMO Connect "
                                      ),
                                      TextSpan(
                                        text: "Graphic Designer",
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                      ),
                                      TextSpan(
                                        text: ". She is responsible for our "
                                      ),
                                      TextSpan(
                                        text: "logo",
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                      ),
                                      TextSpan(
                                        text: " and a lot of creativity behind "
                                      ),
                                      TextSpan(
                                        text: "SAMO Connect",
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                      ),
                                      TextSpan(
                                        text: ". She is also the soul source of our android app feedback."
                                      ),
                                    ]
                                  ),
                                ),
                                Container(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                    Text("Instagram:",style: TextStyle(fontSize: 20),textScaleFactor: textScale,),
                                    CupertinoButton(
                                      padding: EdgeInsets.zero,
                                  child: Text("@jessica_pixel2",textScaleFactor: textScale,),
                                  onPressed: (){
                                    showCupertinoModalPopup(
                                      context: context,
                                      builder: (c){
                                        return CupertinoActionSheet(
                                          cancelButton: prefix0.Constants.cancelAction(context),
                                          //message: Text("@jessica_pixel2",textScaleFactor: textScale,),
                                          title: Text("Jessica Golden's Instagram",textScaleFactor: textScale,),
                                          actions: <Widget>[
                                            CupertinoDialogAction(
                                              isDefaultAction: true,
                                              child: Text("Copy",textScaleFactor: textScale,),
                                              onPressed: (){
                                                Clipboard.setData(ClipboardData(text: "@jessica_pixel2"));
                                                Constants.pop(context);
                                              },
                                              
                                            ),
                                            CupertinoDialogAction(
                                              isDefaultAction: false,
                                              child: Text("Share",textScaleFactor: textScale,),
                                              onPressed: (){
                                                Constants.shareString("Jessica Golden's Instagram is @jessica_pixel2 -- To find out more about Jessica, check out her bio on SAMO Connect -- https://samoconnect.page.link/SamoConnect");
                                                Constants.pop(context);
                                              },
                                              
                                            )
                                          ],
                                        );
                                      }
                                    );
                                  },
                                )

                                  ],),
                                  CupertinoButton(
                                    child: Text("Email"),
                                    onPressed: (){
                                      showCupertinoModalPopup(
                                        context: context,
                                        builder: (c)=>CupertinoActionSheet(
                                          cancelButton: prefix0.Constants.cancelAction(context),
                                          title: Text("Jessica Golden's Email"),
                                          actions: <Widget>[
                                            CupertinoActionSheetAction(
                                              isDefaultAction: true,
                                              child: Text("Copy"),
                                              onPressed: (){
                                                Constants.pop(context);
                                                Clipboard.setData(
                                                  ClipboardData(text: "jessicagolden412@gmail.com")
                                                );
                                              },
                                            ),
                                            CupertinoActionSheetAction(
                                              isDefaultAction: false,
                                              child: Text("Share"),
                                              onPressed: (){
                                                Constants.pop(context);
                                                prefix0.Constants.shareString(
                                                  "Jessica Golden's email is jessicagolden412@gmail.com, to find out more about Jessica, check out her bio on SAMO Connect -- https://samoconnect.page.link/SamoConnect"
                                                );
                                              },
                                            )
                                          ],
                                        )
                                      );
                                    },
                                  ),
                                  Column(
                                    children: <Widget>[
                                    Text("Linkedin:",style: TextStyle(fontSize: 20),textScaleFactor: textScale,),
                                    CupertinoButton(
                                      padding: EdgeInsets.zero,
                                  child: Text("Jessica Golden",textScaleFactor: textScale,),
                                  onPressed: (){
                                    showCupertinoModalPopup(
                                      context: context,
                                      builder: (c){
                                        return CupertinoActionSheet(
                                          cancelButton: prefix0.Constants.cancelAction(context),
                                          title: Text("Linkedin",textScaleFactor: textScale,),
                                          //content: Text("https://www.linkedin.com/in/jessica-golden-441153187"),
                                          actions: <Widget>[
                                            CupertinoActionSheetAction(
                                              isDefaultAction: true,
                                              child: Text("Copy",textScaleFactor: textScale,),
                                              onPressed: (){
                                                Constants.pop(context);
                                                Clipboard.setData(ClipboardData(text: "https://www.linkedin.com/in/jessica-golden-441153187"));
                                              },
                                              
                                            ),
                                            CupertinoActionSheetAction(
                                              isDefaultAction: false,
                                              child: Text("Share",textScaleFactor: textScale,),
                                              onPressed: (){
                                                Constants.pop(context);

                                                Constants.shareString("Jessica Golden's Linkedin is https://www.linkedin.com/in/jessica-golden-441153187 -- To find out more about Jessica, check out her bio on SAMO Connect -- https://samoconnect.page.link/SamoConnect");
                                              },
                                              
                                            )
                                          ],
                                        );
                                      }
                                    );
                                  },
                                )

                                  ],)
                                ],),
                              ],
                            );
                          });
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.asset("assets/Jessica.JPG",),
                        ),
                      ),
                      Text("Jessica Golden", style: TextStyle(fontSize: 18),textAlign: TextAlign.center,),
                      Text("Graphic Designer", style: TextStyle(fontSize: 16, color: Colors.grey[700]),textAlign: TextAlign.center,)


                    ],
                  )
                ),
              ],
            ),
          ),
          bodyBelow
        ],
      )
      
    );
  }
}
