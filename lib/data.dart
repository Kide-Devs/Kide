import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kide/models/Contact.dart';
import 'package:kide/models/EmergencyContact.dart';
import 'package:kide/models/EventCategory.dart';
import 'package:kide/models/ContactCategory.dart';
import 'package:kide/models/MoreDetailsModel.dart';
import 'package:kide/models/SubEvent.dart';
import 'package:flutter/material.dart';
import 'package:kide/models/EventDetail.dart';

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

List<MoreDetailsModel> moreDetails = [
  MoreDetailsModel(
    id: "01",
    header: "KISS",
    aim: "Our aim is to break the vicious cycle of poverty and social isolation and to restore hope for a better future. We believe that every person has the right to access resources and opportunities in order to live and develop with dignity and to become an active and contributing member of our society.",
    mission: "To build up KISS as a preferred centre of learning for the poorest of the poor indigenous (tribal) sections of the society with a focus on formal education aimed at providing sustainable livelihood and scope for all-round development.",
    asset_route: "lib/assets/KISS.png",
    link: "https://kiss.ac.in/"
  ),
  MoreDetailsModel(
    id: "02",
    header: "KIIT",
    aim: "To create an advanced centre of professional learning of international standing where pursuit of knowledge and excellence shall reign supreme, unfettered by the barriers of nationality, language, cultural plurality and religion.",
    mission: "1) Imparting value based quality education of international standard and imbibing skill for solving real life problems.\n\n2) Inculcating global perspective in attitude.\n\n3) Creating leadership qualities with futuristic vision.\n\n4) Fostering spirit of entrepreneurship and realisation of societal responsibilities.\n\n5) Cultivating adaptation of ethics, morality and healthy practices in professional life.\n\n6) Instilling habit of continual learning.\n\n7) Encouraging and supporting creative abilities and research temperament.\n\n8) Establishing and promoting close interaction with industries and other utility sectors and keep abreast with state-of-the-art technology.",
    asset_route: "lib/assets/KIIT.jpg",
    link: "https://kiit.ac.in/"
  ),
  // MoreDetailsModel(
  //   id: "03",
  //   header: "Our Founder",
  //   aim: "Achyuta Samanta, after obtaining Master’s Degree in Chemistry in 1987 from Utkal University, started his career at 22 years of age. He has 30 years of teaching experience to his credit so far. Prof. Samanta went on to serve KIIT  as its first Chancellor and has had the distinction of being the youngest Chancellor of any Indian University. He served University Grants Commission (UGC) as Member for two consecutive terms (2008-11 & 2011-2014) and was a Member of the Executive Committee of All Indian Council for Technical Education (AICTE). He was also member of several other Government of India bodies like, NCTE, ISTE, ISCA, COIR BOARD, CAPART and many more. He has been a Member on the Academic Council of Central University, Silchar, Assam and the Central University, Odisha. He was the first Indian to be Member of both UGC and AICTE simultaneously and the first Odia to become Member of UGC and many other statutory bodies. Presently, he is the General President of Indian Science Congress Association (ISCA). He has delivered nearly 100 motivational speeches, including convocation addresses and foundation day lectures, in different institutions and organizations across the country and the globe.",
  //   mission: "",
  //   asset_route: "lib/assets/Founder_sir.jpeg",
  //   link: "https://achyutasamanta.com/"
  // ),
];

List<SubEvent> subEvents = [
  SubEvent(
    id: Key("0001"),
    name: "Alankar",
    date: "1st March 2020",
    time: "09:00 PM",
    description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet.",
    location: "Campus 6, Seminar Hall 1",
    isBookmarked: false,
    linkDetails: "www.google.com",
    linkRegister: "www.facebook.com",
    details: eventDetails,
  ),
  SubEvent(
    id: Key("0002"),
    name: "Alankar1",
    date: "2nd March 2020",
    time: "09:00 PM",
    description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet.",
    location: "Campus 6, Seminar Hall 1",
    isBookmarked: false,
    linkDetails: "www.google.com",
    linkRegister: "www.facebook.com",
    details: eventDetails,
  ),
  SubEvent(
    id: Key("0003"),
    name: "Alankar2",
    date: "3rd March 2020",
    time: "09:00 PM",
    description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet.",
    location: "Campus 6, Seminar Hall 1",
    isBookmarked: false,
    linkDetails: "www.google.com",
    linkRegister: "www.facebook.com",
    details: eventDetails,
  ),
  SubEvent(
    id: Key("0004"),
    name: "Alankar3",
    date: "4th March 2020",
    time: "09:00 PM",
    description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet.",
    location: "Campus 6, Seminar Hall 1",
    isBookmarked: false,
    linkDetails: "www.google.com",
    linkRegister: "www.facebook.com",
    details: eventDetails,
  )
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
    icon: Icons.local_hospital, 
    emergency: 'Hospital', 
    number: '108'
  ),
  EmergencyContact(
    color: Colors.red, 
    icon: Icons.local_hospital, 
    emergency: 'Police', 
    number: '100'
  ),
  EmergencyContact(
    color: Colors.red, 
    icon: Icons.local_hospital, 
    emergency: 'Fire Brigade', 
    number: '101'
  ),
];

List<Contact> kpHostels = [
  Contact(
    id:"01",
    name : "KP-1",
    designation: null,
    number: "8114377691",
  ),
  Contact(
    id:"02",
    name : "KP-2",
    designation: null,
    number: "8114377692",
  ),
  Contact(
    id:"03",
    name : "KP-3",
    designation: null,
    number: "8114377693",
  ),
  Contact(
    id:"04",
    name : "KP-4",
    designation: null,
    number: "8114379354",
  ),
  Contact(
    id:"05",
    name : "KP-5",
    designation: null,
    number: "8114377689",
  ),
  Contact(
    id:"06",
    name : "KP-5A",
    designation: null,
    number: "8114377690",
  ),
  Contact(
    id:"07",
    name : "KP-6",
    designation: null,
    number: "8114377694",
  ),
  Contact(
    id:"08",
    name : "KP-6 C",
    designation: null,
    number: "8114377678",
  ),
  Contact(
    id:"09",
    name : "KP-7 A,B",
    designation: null,
    number: "8114377680",
  ),
  Contact(
    id:"10",
    name : "KP-7 C",
    designation: null,
    number: "8114379355",
  ),
  Contact(
    id:"11",
    name : "KP-7 E",
    designation: null,
    number: "8114377676",
  ),
  Contact(
    id:"12",
    name : "KP-7 F",
    designation: null,
    number: "8114377674",
  ),
  Contact(
    id:"13",
    name : "KP-7 D",
    designation: null,
    number: "8114377677",
  ),
  Contact(
    id:"14",
    name : "KP-8",
    designation: null,
    number: "8114377681",
  ),
  Contact(
    id:"15",
    name : "KP-9 A",
    designation: null,
    number: "8114377682",
  ),
  Contact(
    id:"16",
    name : "KP-9 B",
    designation: null,
    number: "8114377683",
  ),
  Contact(
    id:"17",
    name : "KP-9 C",
    designation: null,
    number: "8114377675",
  ),
  Contact(
    id:"18",
    name : "KP-10 A",
    designation: null,
    number: "8114377684",
  ),
  Contact(
    id:"19",
    name : "KP-10 B",
    designation: null,
    number: "8114377685",
  ),
  Contact(
    id:"20",
    name : "KP-11 (Law)",
    designation: null,
    number: "8114377686",
  ),
  Contact(
    id:"21",
    name : "KP-12",
    designation: null,
    number: "8114377687",
  ),
  Contact(
    id:"22",
    name : "KSRM",
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
    name : "KP-18 (International)",
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
