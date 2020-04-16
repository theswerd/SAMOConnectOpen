import 'package:v17/api/schoolInformation/departments/departments.dart';
import 'package:v17/api/schoolInformation/houses.dart';

import './teacher.dart';

List<Teacher> teachers = [
  Teacher(
    name: "Nathaniel Munoz Acker",
    ext: "x71284",
    room: "H204",
    department: [
      Departments.socialStudies,
    ],
    email: "nacker@smmusd.org",
  ),
  Teacher(
    name: "Jason Aiello",
    ext: "x71401",
    room: "M101",
    department: [
      Departments.performingArts,
    ],
    website: "https://www.samohiorchestras.com/",
    email: "jaiello@smmusd.org",
  ),
  Teacher(
    name: "Marisol Alba",
    ext: "x71322",
    department: [
      Departments.specialEducation,
    ],
    website: "https://classroom.google.com/c/NDE1NzYxOTE3ODBa",
    email: "malba@smmusd.org",
  ),
  Teacher(
    name: "Robert Alvarado",
    ext: "x71131",
    room: "E101",
    department: [
      Departments.socialStudies,
    ],
    website: "https://alvaradohistory.weebly.com/",
    email: "ralvarado@smmusd.org",
  ),
  Teacher(
    name: "Winston Arnold",
    ext: "x71105",
    room: "I105",
    department: [
      Departments.autoShop,
    ],
    email: "awinston@smmusd.org",
  ),
  Teacher(
    name: "Kate Barraza",
    ext: "x71239",
    room: "HC/E210",
    department: [
      Departments.acting,
      Departments.freshmanSeminar,
    ],
    email: "kbarraza@smmusd.org",
    website: "http://samohitheatre.org/",
  ),
  Teacher(
    name: "Pete Barraza",
    ext: "x71278",
    room: "B208",
    department: [
      Departments.english,
    ],
    email: "pbarraza@smmusd.org",
  ),
  Teacher(
    name: "Jesse Barron",
    ext: "x71176",
    room: "B106",
    department: [
      Departments.worldLanguages,
      Departments.spanish,
    ],
    email: "jbarron@smmusd.org",
  ),
  Teacher(
    name: "Dana Bart-Bell",
    ext: "x71462",
    room: "L210",
    department: [
      Departments.librarian,
    ],
    email: "dbartbell@smmusd.org",
    website: "https://www.smmusd.org/site/Default.aspx?PageID=4281",
  ),
  Teacher(
    name: "Jason Battung",
    ext: "x71435",
    room: "SG15",
    department: [
      Departments.physicalEducation,
    ],
    email: "jbattung@smmusd.org",
  ),
  Teacher(
    name: "Claudia Bautista-Nicholas",
    ext: "x71305",
    room: "I305",
    department: [
      Departments.spanishImmersion,
    ],
    email: "cbautista@smmusd.org",
    website: "http://srabautistanicholas.weebly.com/",
  ),
  Teacher(
    name: "Amy Bisson",
    ext: "x71150",
    room: "L100",
    department: [
      Departments.socialStudies,
    ],
    email: "abisson@smmusd.org",
  ),
  Teacher(
      name: "Ryan Blanck",
      ext: "x71623",
      room: "T-3",
      department: [
        Departments.english,
      ],
      email: "rblanck@smmusd.org",
      website: "https://mrblanck.wordpress.com/"),
  Teacher(
    name: "Amy Bouse",
    ext: "x71443",
    room: "A103",
    department: [
      Departments.art,
    ],
    email: "abouse@smmusd.org",
    website: "https://www.instagram.com/bouse_house/",
  ),
  Teacher(
    name: "Bryn Boyd",
    ext: "x71296",
    room: "H216",
    department: [
      Departments.socialStudies,
    ],
    email: "bboyd@smmusd.org",
  ),
  Teacher(
    name: "Lissette Bravo",
    ext: "x71554",
    room: "H106",
    department: [
      Departments.housePrincipal(Houses.M),
      Departments.principal,
    ],
    administration: true,
    house: Houses.M,
    email: "lbravo@smmusd.org",
  ),
  Teacher(
    name: "Bart Burdick",
    ext: "x71670",
    department: [
      Departments.gardener,
      Departments.athletics,
      Departments.golf,
    ],
    email: "bburdick@smmusd.org",
  ),
  Teacher(
    name: "Deena Burkett",
    ext: "x71589",
    room: "BH20",
    department: [
      Departments.facilityUse,
    ],
    email: "dburkett@smmusd.org",
  ),
  Teacher(
    name: "Catherine Burrell",
    ext: "x71420",
    department: [
      Departments.physicalEducation,
      Departments.lifeguard,
    ],
    email: "cburrell@smmusd.org",
  ),
  Teacher(
    name: "Joana Campos",
    ext: "x0",
    department: [
      Departments.extOperator,
    ],
    email: "jcampos@smmusd.org",
  ),
  Teacher(
    name: "Lucas Capra (sub for Pawlik)",
    department: [
      Departments.socialStudies,
    ],
    email: "lcapra@smmusd.org",
    room: "i211",
    ext: "x71211",
  ),
  Teacher(
    name: "Lyzette Castillo",
    ext: "x71276",
    room: "B206",
    email: "lcastillo@smmusd.org",
    department: [],
  ),
  Teacher(
    name: "Amy Chapman",
    department: [
      Departments.english,
    ],
    email: "achapman@smmusd.org",
    room: "L104",
    ext: "x71153",
  ),
  Teacher(
    name: "Jimmy Chapman",
    department: [
      Departments.worldLanguages,
      Departments.spanish,
      Departments.soccer,
    ],
    room: "H215",
    website: "http://jimmychapman.blogspot.com/",
    email: "jchapman@smmusd.org",
    ext: "x71140",
  ),
  Teacher(
    name: "Robert Cherry",
    department: [
      Departments.specialEducation,
      Departments.socialStudies,
    ],
    ext: "x71140",
    room: "E117",
    email: "rcherry@smmusd.org",
  ),
  Teacher(
    name: "Jenny Chew",
    administration: true,
    house: Houses.H,
    department: [Departments.houseAssistant(Houses.H)],
    ext: "x71186",
    room: "H106",
    email: "rcherry@smmusd.org",
  ),
  Teacher(
    name: "Vivian Choi",
    department: [
      Departments.housePrincipal("I"),
    ],
    administration: true,
    house: Houses.I,
    email: "vchoi@smmusd.org",
    room: "I208A",
    ext: "x71229",
  ),
  Teacher(
    name: "Jeff Cohn",
    ext: "x71569",
    room: "E10",
    department: [
      Departments.specialEducation,
      Departments.visualImpairment,
    ],
    email: "jcohn@smmusd.org",
  ),
  Teacher(
    name: "Margaret Colburn",
    ext: "x71209",
    room: "I209",
    department: [
      Departments.socialStudies,
    ],
    email: "mcolburn@smmusd.org",
  ),
  Teacher(
    name: "Falanda Collins",
    ext: "x71155",
    room: "L105",
    department: [
      Departments.english,
    ],
    email: "fcollins@smmusd.org",
  ),
  Teacher(
    name: "Luis Contreras",
    ext: "x71622",
    email: "lcontreras@smmusd.org",
    room: "T-2",
    department: [
      Departments.eld,
      Departments.math,
    ],
  ),
  Teacher(
    name: "Charles Corrigan",
    ext: "x71224",
    room: "B207",
    department: [
      Departments.specialEducation,
      Departments.science,
    ],
    website: "https://classroom.google.com/c/NDEyODgzNTI1MjRa",
    email: "ccorrigan@smmusd.org",
  ),
  Teacher(
    name: "Shannon Cox",
    ext: "x71257",
    room: "L207",
    email: "scox@smmusd.org",
    department: [
      Departments.socialStudies,
    ],
  ),
  Teacher(
      name: "Marae Cruce",
      ext: "x71304",
      room: "I304",
      department: [Departments.math],
      email: "mcruce@smmusd.org"),
  Teacher(
    name: "Dana Danesi",
    ext: "x71154",
    room: "L104",
    department: [
      Departments.english,
    ],
    email: "ddanesi@smmusd.org",
  ),
  Teacher(
    name: "Gilda de la Cruz",
    ext: "x71201",
    room: "I201",
    department: [
      Departments.english,
    ],
    email: "gdelacruz@smmusd.org",
  ),
  Teacher(
    name: "Lisa DeMirjian",
    ext: "x71267",
    email: "ldemirjian@smmusd.org",
    room: "Advisor",
    administration: true,
    house: Houses.S,
    department: [
      Departments.advisor,
    ],
  ),
  Teacher(
    name: "Randy Denis",
    department: [
      Departments.english,
      Departments.socialStudies,
    ],
    ext: "x71207",
    email: "rdenis@smmusd.org",
    room: "I207",
  ),
  Teacher(
    name: "Stephanie Dew",
    department: [
      Departments.english,
    ],
    ext: "x71259",
    room: "L209",
    email: "sdew@smmusd.org",
  ),
  Teacher(
      name: "Corey Eckhart",
      ext: "x71109",
      room: "I109",
      department: [Departments.science],
      email: "ceckhart@smmusd.org"),
  Teacher(
      name: "Kathleen Faas",
      ext: "x71202",
      room: "I202",
      department: [
        Departments.english,
      ],
      email: "kfaas@smmusd.org"),
  Teacher(
    name: "Emily Ferro",
    ext: "x71521",
    room: "AD511",
    department: [
      Departments.healthSupport,
    ],
    email: "eferro@smmusd.org",
    administration: true,
    house: Houses.administration,
  ),
  Teacher(
    name: "Tania Fischer",
    department: [
      Departments.art,
      Departments.ceramics,
      Departments.athletics,
    ],
    website: "http://samotrack.com/",
    email: "tfischer@smmusd.org",
    ext: "x71441",
  ),
  Teacher(
    name: "Matt Flanders",
    website: "http://samohiaquatics.com/index.html",
    ext: "x71152",
    room: "L102",
    email: "mflanders@smmusd.org",
    department: [
      Departments.socialStudies,
      Departments.athletics,
      Departments.waterPolo,
      Departments.swimming,
    ],
  ),
  Teacher(
      name: "Jennifer Flavin",
      ext: "x71552",
      room: "H106",
      administration: true,
      department: [Departments.advisor],
      email: "jflavin@smmusd.org",
      house: Houses.M),
  Teacher(
    name: "Laurie Fleischer",
    department: [
      Departments.specialEducation,
    ],
    room: "H114",
    email: "lfleischer@smmusd.org",
    ext: "x71322",
  ),
  Teacher(
    name: "Ernesto Flores",
    ext: "x71475",
    room: "B115A",
    email: "e.flores@smmusd.org",
    department: [
      Departments.collegeCounselor,
      "(A-G)", /*THIS WILL ONLY BE ONCE */
    ],
  ),
  Teacher(
    name: "Jenny Forster",
    department: [
      Departments.science,
    ],
    room: "I219",
    email: "jforster@smmusd.org",
    ext: "x71219",
  ),
  Teacher(
      name: "Brooke Forrer",
      department: [
        Departments.worldLanguages,
      ],
      email: "bforrer@smmusd.org",
      room: "I311",
      ext: "x71311"),
  Teacher(
    name: "Kathleen Francisco-Flores",
    department: [
      Departments.math,
    ],
    room: "H215",
    email: "kfrancisco-flores@smmusd.org",
    ext: "x71295",
  ),
  Teacher(
    name: "Evan Fujinaga",
    administration: true,
    department: [
      Departments.athletics,
      "Athletic Director",
    ],
    ext: "x71532",
    room: "AD103B",
    email: "efujinaga@smmusd.org",
  ),
  Teacher(
    name: "Nathan Fulcher",
    ext: "x71203",
    room: "I203",
    department: [
      Departments.english,
    ],
    email: "nfulcher@smmusd.org",
  ),
  Teacher(
    name: "Ingo Gaida",
    ext: "x71107",
    room: "I211A",
    department: [
      Departments.labTechnician,
    ],
    email: "igaida@smmusd.org",
  ),
  Teacher(
    name: "Veronica Garcia-Hecht",
    ext: "x71253",
    room: "L203",
    department: [Departments.worldLanguages, Departments.spanish],
    email: "vgarcia@smmusd.org",
  ),
  Teacher(
    name: "Jessica Garrido",
    administration: true,
    house: Houses.I,
    department: [
      Departments.advisor,
    ],
    email: "jgarrido@smmusd.org",
    ext: "x71227",
  ),
  Teacher(
    name: "Jerry Gibson",
    department: [Departments.facilityUse],
    room: "BH20",
    email: "jgibson@smmusd.org",
    ext: "x71577",
  ),
  Teacher(
    name: "Eileen Gilbert",
    department: [Departments.houseAssistant("O")],
    email: "egilbert@smmusd.org",
    ext: "x71474",
    room: "B122",
  ),
  Teacher(
    name: "Jenny Goldberg",
    department: [Departments.specialEducation],
    email: "jgoldberg@smmusd.org",
    ext: "x71285",
  ),
  Teacher(
    name: "Amy Golden",
    house: Houses.S,
    administration: true,
    department: [Departments.advisor],
    email: "agolden@smmusd.org",
    room: "L200",
    ext: "x71268",
  ),
  Teacher(
    name: "Diane Gonsalves",
    department: [
      Departments.english,
      Departments.specialEducation,
    ],
    room: "E103",
    email: "dgonsalves@smmusd.org",
    ext: "x71133",
  ),
  Teacher(
      name: "Alicia Gonzalez",
      department: [
        Departments.math,
      ],
      email: "a.gonzalez@smmusd.org",
      ext: "x71230",
      room: "E200"),
  Teacher(
    name: "Angelica Gonzalez",
    administration: true,
    house: Houses.administration,
    department: [
      "Principal's Assistant",
    ],
    room: "AD400",
    ext: "x71500",
    email: "amgonzalez@smmusd.org",
  ),
  Teacher(
    name: "H. David Gonzalez",
    department: [
      Departments.specialEducation,
    ],
    room: "H100",
    email: "hdgonzalez@smmusd.org",
    ext: "x71180",
  ),
  Teacher(
    name: "Maricela Gonzalez",
    department: [
      Departments.advisor,
    ],
    house: Houses.O,
    administration: true,
    email: "mgonzalez@smmusd.org",
    room: "B122",
    ext: "x71471",
  ),
  Teacher(
    name: "Noemi Gonzalez",
    department: [
      Departments.english,
    ],
    room: "I204",
    email: "ngonzalez@smmusd.org",
    ext: "x71204",
  ),
  Teacher(
    name: "David Gottlieb",
    department: [
      Departments.worldLanguages,
    ],
    email: "dgottlieb@smmusd.org",
    ext: "x71298",
    room: "H218",
  ),
  Teacher(
    name: "Crystal Griffis",
    department: [],
    room: "B110A",
    email: "cgriffis@smmusd.org",
    ext: "x71320",
  ),
  Teacher(
    name: "Jessica Gutierrez",
    department: [
      Departments.science,
    ],
    email: "jessicagutierrez@smmusd.org",
    room: "I217",
    ext: "x71217",
  ),
  Teacher(
      name: "Jorge Gutiérrez",
      department: [
        Departments.worldLanguages,
        Departments.spanish,
      ],
      website: "https://srjgutierrez.weebly.com/",
      email: "j.gutierrez@smmusd.org",
      ext: "x71256",
      room: "L206"),
  Teacher(
    name: "Laurie Ann Gutierrez",
    department: [
      Departments.art,
      Departments.ceramics,
    ],
    room: "A013",
    email: "lgutierrez@smmusd.org",
    ext: "x71448",
  ),
  Teacher(
      name: "Ianna Hafft",
      department: [
        Departments.science,
      ],
      email: "ihafft@smmusd.org",
      ext: "x71313",
      room: "I313"),
  Teacher(
    name: "James Hecht",
    department: [
      Departments.math,
      Departments.athletics,
      Departments.basketball,
    ],
    email: "jhecht@smmusd.org",
    ext: "x71173",
    room: "B10/Gym",
  ),
  Teacher(
    name: "Carl Hobkirk",
    department: [
      Departments.socialStudies,
    ],
    email: "chobkirk@smmusd.org",
    ext: "x71199",
    room: "H119",
  ),
  Teacher(
    name: "Ryan Hoffman",
    department: [
      Departments.math,
    ],
    email: "rhoffman@smmusd.org",
    room: "i306",
  ),
  Teacher(
    name: "Julie Honda",
    department: [
      Departments.collegeCounselor,
      "H-N",
    ],
    ext: "x71477",
    room: "B115B",
    email: "jhonda@smmusd.org",
  ),
  Teacher(
    name: "Robert Howard",
    department: [
      Departments.restorativeJusticeCoordinator,
    ],
    ext: "x71169",
    room: "L108A",
    email: "rhoward@smmusd.org",
  ),
  Teacher(
    name: "Jeffe Huls",
    ext: "x71404",
    department: [
      Departments.performingArts,
      Departments.choir,
    ],
    email: "jhuls@smmusd.org",
    website: "http://www.samohichoir.org/",
  ),
  Teacher(
    name: "Donald Hyon",
    department: [
      Departments.specialEducation,
    ],
    ext: "x71197",
    email: "dhyon@smmusd.org",
  ),
  Teacher(
    name: "Wilma Iniguez",
    administration: true,
    department: [
      Departments.studentRecords,
    ],
    room: "AD500",
    email: "winiguez@smmusd.org",
  ),
  Teacher(
    name: "Cody Ishii",
    department: [],
    room: "E10",
    ext: "x71567",
    email: "cishii@smmusd.org",
  ),
  Teacher(
    name: "Xavier Jauregui",
    department: [
      Departments.specialEducation,
    ],
    ext: "x71277",
    room: "B207",
    email: "xjauregui@smmusd.org",
  ),
  Teacher(
    name: "Elspeth Jellison",
    department: [
      Departments.speechLanguagePathologist,
    ],
    room: "E215",
    ext: "x71245",
    email: "ejellison@smmusd.org",
  ),
  Teacher(
    name: "Ashley Joseph",
    department: [
      Departments.outreachSpecialist,
    ],
    ext: "x71328",
    room: "L108",
    email: "ajoseph@smmusd.org",
  ),
  Teacher(
    name: "Emily Kariya",
    department: [
      Departments.worldLanguages,
      Departments.socialStudies,
    ], //TODO: IMPLEMENT TEACHER LEADER (SHE IS H HOUSE)
    email: "ekariya@smmusd.org",
    ext: "x71255",
    room: "L205",
  ),
  Teacher(
    name: "Adrienne Karyadi",
    department: [
      Departments.socialStudies,
    ],
    ext: "x71282",
    room: "H202",
    email: "akaryadi@smmusd.org",
    website: "https://sites.google.com/a/smmk12.org/world-history/",
  ),
  Teacher(
    name: "Benjamin Kay",
    website: "https://sites.google.com/site/samohimarinebio/",
    department: [
      Departments.science,
    ],
    ext: "x71215",
    room: "I215",
    email: "bkay@smmusd.org",
  ),
  Teacher(
    name: "Harry Keiley",
    department: [
      Departments.studentSupport,
    ],
    ext: "x71517",
    room: "L210",
    email: "hkeiley@smmusd.org",
  ),
  Teacher(
    name: "Kelly Keith",
    department: [
      Departments.workability,
    ],
    room: "H207",
    ext: "x71450",
    email: "kkeith@smmusd.org",
  ),
  Teacher(
    name: "Jeff Keller",
    department: [
      Departments.outreachSpecialist,
    ],
    ext: "x71325",
    room: "L108",
    email: "jckeller@smmusd.org",
  ),
  Teacher(
    name: "Margaret Kelley",
    website: "https://sites.google.com/a/smmk12.org/ms-kelley-english/",
    department: [
      Departments.english,
    ],
    ext: "x71190",
    room: "H120",
    email: "mkelley@smmusd.org",
  ),
  Teacher(
    name: "Chamnauch Khem",
    department: [
      Departments.worldLanguages,
      Departments.latin,
      Departments.avidCoordinator,
    ],
    email: "ckhem@smmusd.org",
    room: "I303",
    ext: "x71303",
  ),
  Teacher(
    name: "Douglas Kim",
    department: [
      Departments.socialStudies,
      Departments.athletics,
      Departments.basketball,
    ],
    room: "E117",
    ext: "x71147",
    email: "dkim@smmusd.org",
  ),
  Teacher(
    name: "Matt Kirk",
    ext: "x71412",
    room: "NG12A",
    department: [],
    email: "mkirk@smmusd.org",
  ),
  Teacher(
    name: "Kyle Koehler",
    ext: "x71130",
    room: "E100",
    department: [
      Departments.english,
    ],
    email: "kkoehler@smmusd.org",
  ),
  Teacher(
    name: "Tristan Komlos",
    department: [
      Departments.housePrincipal(Houses.H),
    ],
    email: "tkomlos@smmusd.org",
    ext: "x71136",
    room: "E109C",
  ),
  Teacher(
    name: "Kiley Krutzler",
    department: [
      Departments.specialEducation,
    ],
    email: "kkoehler@smmusd.org",
    ext: "x71130",
    room: "E100",
  ),
  Teacher(
    name: "Maureen LaRouche",
    ext: "x71275",
    room: "B205",
    department: [
      Departments.specialEducation,
    ],
    email: "kkrutzler@smmusd.org",
  ),
  Teacher(
    name: "Maureen LaRouche",
    department: [
      Departments.specialEducation,
    ],
    ext: "x71283",
    room: "H203",
    email: "mlarouche@smmusd.org",
  ),
  Teacher(
    name: "Ramsey Lambert",
    website: "https://firmbodygameplan.wixsite.com/weighttraining",
    ext: "x71430",
    room: "South Gym",
    department: [
      Departments.athletics,
      Departments.football,
    ],
    email: "rlambert@smmusd.org",
  ),
  Teacher(
    name: "Martin Ledford",
    department: [
      Departments.art,
      Departments.photography,
    ],
    ext: "x71446",
    room: "A012",
    email: "mledford@smmusd.org",
  ),
  Teacher(
    name: "Chon Lee",
    department: [
      Departments.english,
    ],
    email: "clee@smmusd.org",
    ext: "x71191",
    room: "H121",
  ),
  Teacher(
    name: "Emily Lee",
    department: [
      Departments.math,
    ],
    ext: "x71163",
    room: "L113",
    email: "e.lee@smmusd.org",
  ),
  Teacher(
    name: "Mele LeVeaux",
    ext: "x71327",
    room: "L108",
    department: [
      Departments.outreachSpecialist,
    ],
    email: "mleveaux@smmusd.org",
  ),
  Teacher(
    name: "Sarah Lipetz",
    ext: "x71221",
    room: "I221",
    department: [
      Departments.science,
    ],
    email: "slipetz@smmusd.org",
  ),
  Teacher(
    name: "Ritva Lofstedt",
    department: [
      Departments.science,
    ],
    email: "rlofstedt@smmusd.org",
    ext: "x71113",
    room: "I113",
  ),
  Teacher(
    name: "Shuli Lotan",
    department: [
      Departments.mentalHealth,
      Departments.mentalHealthCoordinator,
    ],
    room: "AD502",
    ext: "x71519",
    email: "slotan@smmusd.org",
  ),
  Teacher(
    name: "Meredith Louria",
    department: [
      Departments.writingCenter,
    ],
    ext: "x71156",
    room: "L106",
    email: "mlouria@smmusd.org",
  ),
  Teacher(
    name: "Theresa Luong",
    ext: "x71280",
    room: "H200",
    department: [
      Departments.math,
    ],
    email: "tluong@smmusd.org",
  ),
  Teacher(
    name: "Vijaya Macwan",
    ext: "x71317",
    room: "I317",
    department: [
      Departments.science,
    ],
    email: "vmacwan@smmusd.org",
    website: "http://mrsmacwan.weebly.com/grades.html",
  ),
  Teacher(
    name: "Juan Manzur",
    department: [
      Departments.it,
    ],
    ext: "x71116",
    room: "I103",
    email: "jmanzur@smmusd.org",
  ),
  Teacher(
    name: "Ari Marken",
    department: [
      Departments.math,
    ],
    ext: "x71621",
    room: "T-1",
    email: "amarken@smmusd.org",
  ),
  Teacher(
    name: "Grace Maxwell",
    room: "South Gym",
    ext: "x71425",
    email: "gmaxwell@smmusd.org",
    department: [
      Departments.art,
      Departments.dance,
    ],
  ),
  Teacher(
    name: "Leigh Anne McKellar",
    ext: "x71307",
    room: "I307",
    email: "lmckellar@smmusd.org",
    department: [
      Departments.worldLanguages,
    ],
  ),
  Teacher(
    name: "Kevin McKeown",
    department: [
      Departments.art,
      Departments.music,
    ],
    ext: "x71406",
    room: "M102",
    email: "komckeown@smmusd.org",
  ),
  Teacher(
    name: "Adrienne Mead",
    department: [
      Departments.mentalHealth,
      Departments.psychologist,
    ],
    ext: "x71542",
    room: "AD202",
    email: "amead@smmusd.org",
  ),
  Teacher(
    name: "Amy Meadors",
    ext: "x71315",
    room: "I315",
    department: [
      Departments.science,
    ],
    email: "ameadors@smmusd.org",
  ),
  Teacher(
    name: "Dr. Hector Medrano",
    administration: true,
    house: "UNKNOWN",
    department: [
      Departments.principal,
      Departments.housePrincipal("UNKNOWN"),
    ],
    email: "hmedrano@smmusd.org",
    ext: "x71269",
    room: "L200",
  ),
  Teacher(
    name: "Rosa Mejia",
    department: [
      Departments.collegeCounselor,
      "(O-Z)",
    ],
    ext: "x71479",
    room: "B115C",
    email: "rmejia@smmusd.org",
  ),
  Teacher(
    name: "Dina Mendoza",
    ext: "x71546",
    room: "AD100",
    administration: true,
    department: [
      Departments.enrollment,
    ],
    email: "dmendoza@smmusd.org",
  ),
  Teacher(
    administration: true,
    name: "Virginia Mendoza",
    email: "vmendoza@smmusd.org",
    ext: "x71132",
    room: "E109A",
    house: Houses.H,
    department: [
      Departments.advisor,
      "(9/11)",
    ],
  ),
  Teacher(
    name: "Katharina Merlob",
    ext: "x71281",
    room: "H201",
    email: "kmerlob@smmusd.org",
    department: [],
    incomplete: true,
  ),
  Teacher(
    name: "George Mickelopoulos",
    department: [
      Departments.specialEducation,
      Departments.math,
    ],
    ext: "x71182",
    room: "H102",
    email: "gmickelopoulos@smmusd.org",
  ),
  Teacher(
    name: "Guadalupe Mireles",
    ext: "x71309",
    room: "I309",
    department: [
      Departments.worldLanguages,
      Departments.spanish,
    ],
    email: "mireles@smmusd.org",
  ),
  Teacher(
    name: "Terry Morris",
    ext: "x71250",
    room: "L200",
    email: "tmorris@smmusd.org",
    department: [
      Departments.houseAssistant(""),
    ],
    house: /*Houses.*/ "",
    incomplete: true,
  ),
  Teacher(
    name: "Jason Mun",
    department: [
      Departments.specialEducation,
      Departments.athletics,
      Departments.wrestling
    ],
    email: "jmun@smmusd.org",
  ),
  Teacher(
    name: null,
    department: null,
    email: null,
  ),
];
