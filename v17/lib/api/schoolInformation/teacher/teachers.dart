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
    department: null,
    email: null,
    ext: null,
  )
];
