import 'package:kide/models/EventCategory.dart';
import 'package:kide/models/SubEvent.dart';

List<SubEvent> subEvents = [
  SubEvent(
    id: "0001",
    name: "Alankar",
    date: "1st March 2020",
    time: "09:00 PM",
    description: "Showcase your Voice on the most watched stage",
    location: "Campus 6, Seminar Hall 1",
    isBookmarked: false,
    linkDetails: "www.google.com",
    linkRegister: "www.facebook.com"
  ),
  SubEvent(
    id: "0001",
    name: "Alankar1",
    date: "1st March 2020",
    time: "09:00 PM",
    description: "Showcase your Voice on the most watched stage",
    location: "Campus 6, Seminar Hall 1",
    isBookmarked: false,
    linkDetails: "www.google.com",
    linkRegister: "www.facebook.com"
  ),
  SubEvent(
    id: "0001",
    name: "Alankar2",
    date: "1st March 2020",
    time: "09:00 PM",
    description: "Showcase your Voice on the most watched stage",
    location: "Campus 6, Seminar Hall 1",
    isBookmarked: false,
    linkDetails: "www.google.com",
    linkRegister: "www.facebook.com"
  ),
  SubEvent(
    id: "0001",
    name: "Alankar3",
    date: "1st March 2020",
    time: "09:00 PM",
    description: "Showcase your Voice on the most watched stage",
    location: "Campus 6, Seminar Hall 1",
    isBookmarked: false,
    linkDetails: "www.google.com",
    linkRegister: "www.facebook.com"
  )
];

List<EventCategory> eventCategories = [
  EventCategory(
    id: "001", 
    name: "Cultural", 
    subEvents: subEvents,
  ),
  EventCategory(
    id: "001", 
    name: "Luminare", 
    subEvents: subEvents,
  ),
  EventCategory(
    id: "001", 
    name: "ElectroNerds", 
    subEvents: subEvents,
  ),
  EventCategory(
    id: "001", 
    name: "Chastermef", 
    subEvents: subEvents,
  ),
  EventCategory(
    id: "001", 
    name: "Builder.io", 
    subEvents: subEvents,
  ),
  EventCategory(
    id: "001", 
    name: "Mekanix", 
    subEvents: subEvents,
  ),
  EventCategory(
    id: "001", 
    name: "Bionymph", 
    subEvents: subEvents,
  ),
  EventCategory(
    id: "001", 
    name: "Cultural", 
    subEvents: subEvents,
  )
];