//https://smmusd.follettdestiny.com/cataloging/servlet/handlebasicsearchform.do?doTop10=true
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'color_loader_3.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LibraryPage extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  static String tag = "libraryPage";
  
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Firestore.instance.collection("books").getDocuments(),
        builder: (c,s){
          if(s.connectionState!=ConnectionState.done){
            return Center(child: ColorLoader3(),);
          }else{
            
          }
        },
      ),
    );
  }

}