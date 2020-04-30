import 'package:flutter/material.dart';

import 'department.dart';

class Departments {
  //ACADEMIC SUBJECTS
  static Department freshmanSeminar = Department(
    name: "Freshman Seminar",
    color: Colors.blueAccent,
  );
  static Department socialStudies = Department(
    name: "Social Studies",
    color: Colors.blue,
  );
  static Department english = Department(
    name: "English",
    color: Colors.cyanAccent[700],
  );
  static Department math = Department(
    name: "Math",
    color: Colors.deepOrange,
  );
  static Department science = Department(
    name: "Science",
    color: Colors.deepPurple,
  );

  static Department spanishImmersion =
      Department(name: "Spanish Immersion", color: Colors.green);

  //WORLD LANGUAGES
  static Department worldLanguages = Department(
    name: "World Languages",
    color: Colors.greenAccent,
  );
  static Department spanish =
      Department(name: "Spanish", color: Colors.lightGreen);
  static Department latin = Department(
    name: "Latin",
    color: Colors.lightGreenAccent,
  );

  //ATHLETICS
  static Department athletics = Department(
    name: "Athletics",
    color: Colors.redAccent,
  );
  static Department soccer = Department(
    name: "Soccer",
    color: Colors.redAccent
  );
  static Department basketball = Department(
    name: "Basketball",
    color: Colors.orange,
  );
  static Department golf = Department(
    name: "Golf",
    color: Colors.orangeAccent,
  );
  static Department football = Department(
    name: "Football",
    color: Colors.deepPurpleAccent,
  );
  static Department wrestling = Department(
    name: "Wrestling",
    color: Colors.tealAccent,
  );
  static Department waterPolo = Department(
    name: "Water polo",
    color: Colors.purple,
  );
  static Department swimming = Department(
    name: "Swimming",
    color: Colors.deepPurple,
  );
  static Department lifeguard = Department(
    name: "Lifeguard",
    color: Colors.deepPurpleAccent,
  );

  static Department physicalEducation = Department(
    name: "PE",
    color: Colors.pink,
  );

  //ELECTIVES

  //ARTS & MUSIC
  static Department art = Department(
    name: "Art",
    color: Colors.red,
  );
  static Department performingArts = Department(
    name: "Performing Arts",
    color: Colors.redAccent,
  );
  static Department dance = Department(
    name: "Dance",
    color: Colors.blue,
  );
  static Department music = Department(
    name: "Music",
    color: Colors.pinkAccent,
  );
  static Department acting = Department(
    name: "Acting",
    color: Colors.deepOrangeAccent,
  );
  static Department ceramics = Department(
    name: "Ceramics",
    color: Colors.lightBlueAccent,
  );
  static Department choir = Department(
    name: "Choir",
    color: Colors.indigo,
  );
  static Department photography = Department(
    name: "Photography",
    color: Colors.indigoAccent,
  );

  static Department autoShop = Department(
    name: "AutoShop",
    color: Colors.amber,
  );

  static Department librarian = Department(
    name: "Librarian",
    color: Colors.amberAccent,
  );

  //FACILITY
  static Department gardener = Department(
    name: "Gardener",
    color: Colors.lightGreen,
  );
  static Department facilityUse = Department(
    name: "Facility Use",
    color: Colors.blue,
  );
  static Department extOperator = Department(
    name: "Operator",
    color: Colors.blueAccent,
  );
  static Department healthSupport = Department(
    name: "Health Support",
    color: Colors.lightBlueAccent,
  );

  //IT
  static Department labTechnician = Department(
    name: "Lab Technician",
    color: Colors.teal,
  );
  static Department it = Department(
    name: "IT Support",
    color: Colors.tealAccent,
  );

  //SPECIAL EDUCATION
  static Department specialEducation = Department(
    name: "Special Education",
    color: Colors.purple,
  );
  static Department visualImpairment = Department(
    name: "Visual Impairment",
    color: Colors.deepPurple,
  );
  static Department eld = Department(
    name: "ELD",
    color: Colors.deepPurpleAccent,
  ); /*IDK WHAT THIS IS */
  static Department advisor = Department(
    name: "Advisor",
    color: Colors.red,
  );
  static Department speechLanguagePathologist = Department(
    name: "Speech/Language Pathologist",
    color: Colors.redAccent,
  );

  //ADMIN & ADVISORS
  static Department collegeCounselor = Department(
    name: "College Counselor",
    color: Colors.pink,
  );
  static Department principal = Department(
    name: "Principal",
    color: Colors.lightGreenAccent,
  );
  static Department studentRecords = Department(
    name: "Student Records",
    color: Colors.green,
  );
  static Department outreachSpecialist = Department(
    name: "Outreach Specialist",
    color: Colors.greenAccent,
  );
  static Department studentSupport = Department(
    name: "Student Support",
    color: Colors.red,
  );
  static Department workability = Department(
    name: "Workability1",
    color: Colors.redAccent,
  ); //WHAT IS THIS?
  static Department writingCenter = Department(
    name: "Writing Center",
    color: Colors.purple,
  );
  static Department administration = Department(
    name: "Administration",
    color: Colors.purpleAccent,
  );
  static Department enrollment = Department(
    name: "Enrollment",
    color: Colors.deepPurpleAccent,
  );

  //MENTAL HEALTH
  static Department mentalHealth = Department(
    name: "Mental Health",
    color: Colors.deepPurple,
  );
  static Department psychologist = Department(
    name: "Psychologist",
    color: Colors.blueAccent,
  );
  static Department mentalHealthCoordinator = Department(
    name: "Mental Health Coordinator",
    color: Colors.blue,
  );

  static Department housePrincipal(String house) {
    return Department(
      name: "$house House Principal",
      color: Colors.cyanAccent,
    );
  }

  static Department houseAssistant(String house) {
    return Department(
      name: "$house House Assistant",
      color: Colors.cyan,
    );
  }

  //OTHER
  static Department avidCoordinator = Department(
    name: "AVID Coordinator",
    color: Colors.blue
  );
  static Department restorativeJusticeCoordinator = Department(
    name: "Restorative Justice Coordinator",
    color: Colors.blue
  );
}
