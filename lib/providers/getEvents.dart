import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kide/models/EventCategory.dart';
import 'package:kide/models/SubEvent.dart';
import 'package:kide/models/EventDetail.dart';

class GetEvents with ChangeNotifier {
  //Create Firebase Instance
  Firestore db = Firestore.instance;

  //Initialize the marker set
  List<String> _eventList = [];
  // List <EventDetail> eventDetails = [];
  // Iterable<SubEvent> subEvents = [];
  List<EventCategory> _eventCategories = [];

  String _university = "Select Your University";
  List<String> _universities = [];

  String get university {
    return _university;
  }

  void setUniversity( String univ ) {
    _university = univ;
    notifyListeners();
  }

  void unsetUniversity() {
    _university = "Select Your University";
    notifyListeners();
  }

  
  List<String> get universities {
    return _universities;
  }


  List<EventCategory> get eventCategories {
    return _eventCategories;
  }

  List<String> get eventList {
    return _eventList;
  }

  void setEvents() {
    print("SetEventgs");
    getEventList();
    getUniversities();
    
  }

  void getEventList() {
    db.collection('event_list').snapshots().listen(
      (snapshot) {
        snapshot.documents.forEach((doc) {
          // populate _eventList
          _eventList = doc.data['names'].cast<String>();
          print(_eventList.length);
        });
        if(_eventList.length != 0)
          _eventList.forEach((e) => getEventCategory(e));
        notifyListeners();
      },
    );
  }

  void getUniversities() {
    db.collection('university_list').snapshots().listen(
      (snapshot) {
        snapshot.documents.forEach((doc) {
          // populate universityList
          _universities = doc.data['name'].cast<String>();
          print(_universities);
          notifyListeners();
        });
      },
    );
  }

  void getEventCategory(String collectionName) {
    print("get cet");
    db.collection(collectionName).snapshots().listen(
      (snapshot) {
        List<SubEvent> subEvents = [];
        snapshot.documents.forEach((doc) {
          //populate all other Lists
          List<String> headers = doc.data['d_headers'].cast<String>();
          List<String> descriptions = doc.data['d_descs'].cast<String>();
          List<EventDetail> eventDetails = [];
          for( int i=0; i<headers.length; i++)
            eventDetails.add(new EventDetail(id: i.toString(), header: headers[i], desc: descriptions[i]));
          
          subEvents.add(SubEvent(
            id: Key(doc.documentID),
            name: doc.data['name'],
            date: doc.data['date'],
            time: doc.data['time'],
            description: doc.data['description'],
            location: doc.data['location'],
            details: eventDetails,
            universities: [_universities[doc.data['universities'][0]], _universities[doc.data['universities'][1]]],
          ));
          
          print("events ${subEvents.length}");
          print(collectionName);
        });

        _eventCategories.add(EventCategory(
          id: collectionName,
          name: collectionName,
          subEvents: [...subEvents]
        ));
        notifyListeners();
      },
    );
  }
}
