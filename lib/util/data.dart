import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kide/models/Contact.dart';
import 'package:kide/models/EmergencyContact.dart';
import 'package:kide/models/EventCategory.dart';
import 'package:kide/models/ContactCategory.dart';
import 'package:kide/models/More.dart';
import 'package:kide/models/MoreInfo.dart';
import 'package:kide/models/Official.dart';
import 'package:kide/models/DashBoard.dart';
import 'package:kide/models/SubEvent.dart';
import 'package:flutter/material.dart';
import 'package:kide/models/EventDetail.dart';

List <Official> dummyUni = [
  Official(
    name: "ANUJEET CHATERJEE",
    designation: "Male Coach",
  ),
  Official(
    name: "SAPNA CHOUDHARY",
    designation: "Female Coach",
  ),
  Official(
    name: "AJAY HOODA",
    designation: "Temp Coach",
  ),
  Official(
    name: "ARKAJYOTI MUKHERJEE",
    designation: "University Sports Manager (USM)",
  ),
  Official(
    name: "VANSH BHATIA",
    designation: "University contingent Manager (UCM)",
  ),
];

List <DashBoard> overView = [
  DashBoard(
    totalParticipants: "80",
    officials: dummyUni,
  )
];

List <EventDetail> eventDetails = [
  EventDetail(
    id: "01",
    header: "Rules: ",
    desc: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet.",
  ),
  EventDetail(
    id: "02",
    header: "Tickets: ",
    desc: "Foo Bar",
  ),
  EventDetail(
    id: "03",
    header: "Slot Booking: ",
    desc: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet.",
  ),
  EventDetail(
    id: "04",
    header: "Chief Guest: ",
    desc: "ACO (Not a 3 Star Coder)",
  ),
];

List <MoreInfo> kiss = [
MoreInfo(
  id: "01",
  header: "AIM",
  desc: "Our aim is to break the vicious cycle of poverty and social isolation and to restore hope for a better future. We believe that every person has the right to access resources and opportunities in order to live and develop with dignity and to become an active and contributing member of our society."
  ),
  MoreInfo(
  id: "02",
  header: "OUR VISION",
  desc: "To build up KISS as a preferred centre of learning for the poorest of the poor indigenous (tribal) sections of the society with a focus on formal education aimed at providing sustainable livelihood and scope for all-round development."
  ),
  MoreInfo(
  id: "03",
  header: "OUR MISSION",
  desc: "1) To eradicate poverty and empower the disadvantaged sections of the society through holistic education and providing them with sustainable livelihood\n\n2) To be a complete solution to pervasive poverty in the lowest strata of the society\n\n3) To prepare underprivileged children and youth as ‘change agents’ for their community\n\n4) To preserve tribal heritage, culture and values\n\n5) To assist in the process of social integration and personal realization of underprivileged children and young people.\n\n6) To encourage and popularize voluntary work."
  ),
];

List <MoreInfo> kiit = [
MoreInfo(
  id: "01",
  header: "OUR VISION",
  desc: "To create an advanced centre of professional learning of international standing where pursuit of knowledge and excellence shall reign supreme, unfettered by the barriers of nationality, language, cultural plurality and religion."
  ),
  MoreInfo(
  id: "02",
  header: "MISSION",
  desc: "1) Imparting value based quality education of international standard and imbibing skill for solving real life problems.\n\n2) Inculcating global perspective in attitude.\n\n3) Creating leadership qualities with futuristic vision.\n\n4) Fostering spirit of entrepreneurship and realisation of societal responsibilities.\n\n5) Cultivating adaptation of ethics, morality and healthy practices in professional life.\n\n6) Instilling habit of continual learning.\n\n7) Encouraging and supporting creative abilities and research temperament.\n\n8) Establishing and promoting close interaction with industries and other utility sectors and keep abreast with state-of-the-art technology."
  ),
];

List <MoreInfo> founderSir = [
MoreInfo(
  id: "01",
  header: "A BRIEF PROFILE",
  desc: "Achyuta Samanta, after obtaining Master’s Degree in Chemistry in 1987 from Utkal University, started his career at 22 years of age. He has 30 years of teaching experience to his credit so far. \n\nProf. Samanta went on to serve KIIT  as its first Chancellor and has had the distinction of being the youngest Chancellor of any Indian University. He served University Grants Commission (UGC) as Member for two consecutive terms (2008-11 & 2011-2014) and was a Member of the Executive Committee of All Indian Council for Technical Education (AICTE). He was also member of several other Government of India bodies like, NCTE, ISTE, ISCA, COIR BOARD, CAPART and many more. He has been a Member on the Academic Council of Central University, Silchar, Assam and the Central University, Odisha. He was the first Indian to be Member of both UGC and AICTE simultaneously and the first Odia to become Member of UGC and many other statutory bodies. Currently he is the President of World Congress of Poets 2019. He has delivered nearly 100 motivational speeches, including convocation addresses and foundation day lectures, in different institutions and organizations across the country and the globe.\n\nProf. Samanta has been conferred with 33 Honoris Causa Doctorate awards from different University across the globe. He has also been decorated with prestigious Civilian Awards from many countries including, Gusi Peace Prize International, the highest Civilian Award from Bahrain besides over 50 national and international and over 200 State honors and accolades.\n\nHe is the Founder of Kalinga Institute of Industrial Technology (KIIT ) and Kalinga Institute of Social Sciences (KISS), Bhubaneswar – the fully free and fully residential tribal institute. Starting modestly with an initial seed capital of Rs 5000/-, KIIT has grown into one of the most promising Universities imparting professional education in the Country with global acclaim having 27,000 students from across the country and abroad. KIIT also runs a 2000 bedded multispecialty hospital and an attached Medical College. KISS has become the largest Residential Tribal Institute in the World and is home for 50,000 tribal children (30,000 pursing education and 20,000 passed out). Both KIIT and KISS found place in the Limca Book of Records as well as Guinness World Records in many counts.\n\nProf. Achyuta Samanta, who had lost his father at the age of four, before he could know the significance of the world, was pushed into the mire of abject poverty.  Today, he is a legend, an iconic educationist, an emblem of service to humanity, a beacon of light for social transformation, and a redeemer of the fallen, the oppressed and the marginalized. With huge contributions in the field of education, health, art, culture, literature, rural development, social service and spiritualism his journey in life is not only awe-inspiring but soul-awakening for millions of poverty-stricken youths all over the globe. He has converted the remote village ‘Kalarabank’, Cuttack into a Smart Village and the entire Manpur Panchayat into a model Panchayat (cluster of villages).\n\nHe has already started working to establish 12 branches of KISS in different districts, besides establishing KISS-Delhi for the underprivileged sections of the society. Besides providing around 10,000 direct employment in KIIT and KISS, he has created over 1,00,000 indirect employment and more than 100 successful entrepreneurs across the country. His hobby is to give happiness and smiling face to the millions of poor.\n\nProf. Samanta has been working relentlessly for Zero Poverty, Zero Hunger and Zero Illiteracy."
  ),

];

List<More> more = [
  More(
    id: "01",
    moreName: "KISS",
    pageFormat: kiss,
    assetRoute: "lib/assets/KISS.png",
    link: "https://kiss.ac.in/"
  ),
  More(
    id: "02",
    moreName: "KIIT",
    pageFormat: kiit,
    assetRoute: "lib/assets/KIIT.jpg",
    link: "https://kiit.ac.in/"
  ),
  More(
    id: "03",
    moreName: "Our Founder",
    pageFormat: founderSir,
    assetRoute: "lib/assets/Founder_sir.jpeg",
    link: "https://achyutasamanta.com/"
  ),
];

Iterable<SubEvent> subEvents = [
  SubEvent(
    id: Key("0001"),
    name: "KIIT vs SRM",
    date: "1st March 2020",
    time: "09:00 PM",
    description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet.",
    location: "Campus 6, Seminar Hall 1",
    details: eventDetails,
    universities: ["KIIT", "SRM"]
  ),
  SubEvent(
    id: Key("0002"),
    name: "BITS vs VIT",
    date: "2nd March 2020",
    time: "09:00 PM",
    description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet.",
    location: "Campus 6, Seminar Hall 1",
    details: eventDetails,
    universities: ["BITS", "VIT"]
  ),
  SubEvent(
    id: Key("0003"),
    name: "NIT RKL vs IIT KGP",
    date: "3rd March 2020",
    time: "09:00 PM",
    description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet.",
    location: "Campus 6, Seminar Hall 1",
    details: eventDetails,
    universities: ["NIT RKL", "IIT KGP"]
  ),
  SubEvent(
    id: Key("0004"),
    name: "Utkal vs Jadavpur",
    date: "4th March 2020",
    time: "09:00 PM",
    description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet.",
    location: "Campus 6, Seminar Hall 1",
    details: eventDetails,
    universities: ["Utkal University", "Jadavpur University"]
  ),
  SubEvent(
    id: Key("0005"),
    name: "KIIT vs Jadavpur",
    date: "4th March 2020",
    time: "09:00 PM",
    description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet.",
    location: "Campus 6, Seminar Hall 1",
    details: eventDetails,
    universities: ["KIIT", "Jadavpur University"]
  ),
  SubEvent(
    id: Key("0006"),
    name: "KIIT vs IIT KGP",
    date: "4th March 2020",
    time: "09:00 PM",
    description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet.",
    location: "Campus 6, Seminar Hall 1",
    details: eventDetails,
    universities: ["KIIT", "IIT KGP"]
  )
];

List<String> universities = [
  "KIIT", "Utkal University", "Jadavpur University", "BITS",
  "NIT RKL", "IIT KGP", "VIT", "SRM"
];

List<EventCategory> eventCategories = [
  EventCategory(
    id: "001", 
    name: "Cricket", 
    subEvents: subEvents,
  ),
  EventCategory(
    id: "001", 
    name: "Hockey", 
    subEvents: subEvents,
  ),
  EventCategory(
    id: "001", 
    name: "Tennis", 
    subEvents: subEvents,
  ),
  EventCategory(
    id: "001", 
    name: "Wrestling", 
    subEvents: subEvents,
  ),
  EventCategory(
    id: "001", 
    name: "Archery", 
    subEvents: subEvents,
  ),
  EventCategory(
    id: "001", 
    name: "Football", 
    subEvents: subEvents,
  ),
  EventCategory(
    id: "001", 
    name: "BasketBall", 
    subEvents: subEvents,
  ),
  EventCategory(
    id: "001", 
    name: "Badminton", 
    subEvents: subEvents,
  )
];

List<EmergencyContact> emergency = [
  EmergencyContact(
    color: Colors.red, 
    iconAsset: "./lib/assets/pharmacy.svg", 
    emergency: 'Hospital', 
    number: '108'
  ),
  EmergencyContact(
    color: Colors.red, 
    iconAsset: "./lib/assets/police.svg", 
    emergency: 'Police', 
    number: '100'
  ),
  EmergencyContact(
    color: Colors.red, 
    iconAsset: "./lib/assets/fire.svg", 
    emergency: 'Fire Brigade', 
    number: '101'
  ),
];

List<Contact> kpHostels = [
  Contact(
    id:"01",
    name : "King's Palace - 1",
    designation: null,
    number: "8114377691",
  ),
  Contact(
    id:"02",
    name : "King's Palace - 2",
    designation: null,
    number: "8114377692",
  ),
  Contact(
    id:"03",
    name : "King's Palace - 3",
    designation: null,
    number: "8114377693",
  ),
  Contact(
    id:"04",
    name : "King's Palace - 4",
    designation: null,
    number: "8114379354",
  ),
  Contact(
    id:"05",
    name : "King's Palace - 5",
    designation: null,
    number: "8114377689",
  ),
  Contact(
    id:"06",
    name : "King's Palace - 5A",
    designation: null,
    number: "8114377690",
  ),
  Contact(
    id:"07",
    name : "King's Palace - 6",
    designation: null,
    number: "8114377694",
  ),
  Contact(
    id:"08",
    name : "King's Palace - 6 C",
    designation: null,
    number: "8114377678",
  ),
  Contact(
    id:"09",
    name : "King's Palace - 7 A,B",
    designation: null,
    number: "8114377680",
  ),
  Contact(
    id:"10",
    name : "King's Palace - 7 C",
    designation: null,
    number: "8114379355",
  ),
  Contact(
    id:"11",
    name : "King's Palace - 7 E",
    designation: null,
    number: "8114377676",
  ),
  Contact(
    id:"12",
    name : "King's Palace - 7 F",
    designation: null,
    number: "8114377674",
  ),
  Contact(
    id:"13",
    name : "King's Palace - 7 D",
    designation: null,
    number: "8114377677",
  ),
  Contact(
    id:"14",
    name : "King's Palace - 8",
    designation: null,
    number: "8114377681",
  ),
  Contact(
    id:"15",
    name : "King's Palace - 9 A",
    designation: null,
    number: "8114377682",
  ),
  Contact(
    id:"16",
    name : "King's Palace - 9 B",
    designation: null,
    number: "8114377683",
  ),
  Contact(
    id:"17",
    name : "King's Palace - 9 C",
    designation: null,
    number: "8114377675",
  ),
  Contact(
    id:"18",
    name : "King's Palace - 10 A",
    designation: null,
    number: "8114377684",
  ),
  Contact(
    id:"19",
    name : "King's Palace - 10 B",
    designation: null,
    number: "8114377685",
  ),
  Contact(
    id:"20",
    name : "King's Palace - 11 (Law)",
    designation: null,
    number: "8114377686",
  ),
  Contact(
    id:"21",
    name : "King's Palace - 12",
    designation: null,
    number: "8114377687",
  ),
  Contact(
    id:"22",
    name : "KIIT School of Rural Management",
    designation: null,
    number: "8114377673",
  ),
  Contact(
    id:"23",
    name : "KSQ-B",
    designation: null,
    number: "8114379353",
  ),
  Contact(
    id:"16",
    name : "King's Palace - 18 (International)",
    designation: null,
    number: "8114377688",
  ),
];

List<Contact> qcHostels = [
  Contact(
    id:"01",
    name : "QC-1 (Campus - 3)",
    designation: null,
    number: "8114377695",
  ),
  Contact(
    id:"02",
    name : "QC-2 (Campus - 3)",
    designation: null,
    number: "8114377696",
  ),
  Contact(
    id:"03",
    name : "QC-3 (Campus - 3)",
    designation: null,
    number: "8114377697",
  ),
  Contact(
    id:"04",
    name : "QC-4 (Campus - 3)",
    designation: null,
    number: "8114377698",
  ),
  Contact(
    id:"05",
    name : "QC-5 (Campus - 7)",
    designation: null,
    number: "8114377699",
  ),
  Contact(
    id:"06",
    name : "QC-6 (Campus - 11)",
    designation: null,
    number: "8114379356",
  ),
  Contact(
    id:"07",
    name : "QC-7 (Campus - 16)",
    designation: null,
    number: "8114379357",
  ),
  Contact(
    id:"08",
    name : "D Block GH Campus 7",
    designation: null,
    number: "8114379358",
  ),
  Contact(
    id:"09",
    name : "KIMS GH Block A",
    designation: null,
    number: "8114379359",
  ),
  Contact(
    id:"10",
    name : "KIMS GH Block B",
    designation: null,
    number: "8114379360",
  ),
  Contact(
    id:"11",
    name : "KIMS GH Block C",
    designation: null,
    number: "8114379351",
  ),
];

List<Contact> hostelAuthorities = [
  Contact(
    id: "01",
    name: "Dr. Biswajit Sahoo",
    designation: "Chief Warden of Hostel",
    number: "9437229507",
  ),
  Contact(
    id: "02",
    name: "Mr. S.K. Rath",
    designation: "Dy. Registrar (Hostel)",
    number: "9437020234",
  ),
  Contact(
    id: "03",
    name: "Dr. A.A. Acharya",
    designation: "Sr. Superintendent",
    number: "9861058079",
  ),
  Contact(
    id: "04",
    name: "Dr. Manoj Kumar Mishra",
    designation: "Superintendent",
    number: "9937335233",
  ),
  Contact(
    id: "05",
    name: "Prof. Anil Kumar Swain",
    designation: "Dy. Superintendent",
    number: "9938853866",
  ),
];

List<Contact> contactsHelpLine = [
  Contact(
    id: "01",
    name: "KIIT Contact Us - 1",
    designation: "HelpDesk 1",
    number: "6742725113",
  ),
  Contact(
    id: "02",
    name: "KIIT Contact Us - 2",
    designation: "HelpDesk 2",
    number: "6742741389",
  ),
];

List<ContactCategory> contactCategoryList = [
  ContactCategory(
    id: "01",
    name: "Boy's Hostels",
    contacts: kpHostels
  ),
  ContactCategory(
    id: "02",
    name: "Girl's Hostels",
    contacts: qcHostels
  ),
  ContactCategory(
    id: "03",
    name: "Administration",
    contacts: hostelAuthorities
  ),
  ContactCategory(
    id: "04",
    name: "Helplines",
    contacts: contactsHelpLine
  ),
];



//Campus
Set<Marker> campuses = {
  Marker(
    markerId: MarkerId('Campus_15'),
    position: LatLng(20.348698, 85.816095),
    infoWindow: InfoWindow(
      title: 'Campus 15',
      snippet: 'Computer Department',
    ),
  ),
  Marker(
    markerId: MarkerId('Campus_3'),
    position: LatLng(20.353835, 85.816489),
    infoWindow: InfoWindow(
      title: 'Campus 3',
      snippet: 'Civil Department',
    ),
  ),
};

//Food Courts
Set<Marker> food = {
  Marker(
    markerId: MarkerId('KP6_FC'),
    position: LatLng(20.349253, 85.815905),
    infoWindow: InfoWindow(
      title: 'Campus 15 Food Court',
      snippet: 'Near KP 6',
    ),
  ),
  Marker(
    markerId: MarkerId('KP7_FC'),
    position: LatLng(20.350910, 85.815964),
    infoWindow: InfoWindow(
      title: 'KP 7 Food Court',
      snippet: 'Amazon Delivery Stop',
    ),
  ),
};

//Gates
Set<Marker> gates = {
  Marker(
    markerId: MarkerId('gate_152'),
    position: LatLng(20.348714, 85.815610),
    infoWindow: InfoWindow(
      title: 'Gate 152',
      snippet: 'Gas Godown Gate',
    ),
  ),
};

Set<Marker> all = Set.from(campuses)..addAll(food)..addAll(gates);

Map<String, Set<Marker>> markers = {
  'all': all,
  'campuses': campuses,
  'food': food,
  'gates': gates,
};
