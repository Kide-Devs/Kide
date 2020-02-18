import 'package:Kide/models/ULO.dart';
import 'package:Kide/util/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:Kide/models/EventCategory.dart';
import 'package:Kide/models/SubEvent.dart';
// import 'package:Kide/models/EventDetail.dart';

class GetEvents with ChangeNotifier {
  bool _isConnected = false;
  bool _fetchFlagCategories = false;
  bool _fetchFlagUniversities = false;
  bool _fetchFlagULOs = false;
  //Create Firebase Instance
  Firestore db = Firestore.instance;

  //Initialize the marker set
  List<String> _eventList = [];
  // List <EventDetail> eventDetails = [];
  // Iterable<SubEvent> subEvents = [];
  List<EventCategory> _eventCategories = [];
  
  // ----------------- USER Data Structures ---------------
  List<ULO> _ulo_list = [];
  List<String> _uloNameList = [];
  String _currentULO = "Select Your ID";
  List<String> _currentULOUnivs = [];
  String _uloUniversity = SELECT_YOUR_UNIVERSITY;
  String _userType = "Participant or ULO?";
  String _locUserType = "Participant or ULO?";

  String get userType {
    return _userType;
  }

  String get currentULO {
    return _currentULO;
  }

  String get locUserType {
    return _locUserType;
  }
  
  List<String> get uloNameList {
    return _uloNameList;
  }
  
  List<String> get currentULOUnivs {
    return _currentULOUnivs;
  }

  List<ULO> get ulo_list {
    return _ulo_list;
  }
  
  String get uloUniversity {
    return _uloUniversity;
  }

  void setUloUniversity(String univ) {
    _uloUniversity = univ;
    notifyListeners();
  }

  void setUserType(String type) {
    _userType = type;
    notifyListeners();
  }

  void setCurrentULO(String cur) {
    _currentULO = cur;
    notifyListeners();
  }

  void setLocUserType(String type) {
    _locUserType = type;
    notifyListeners();
  }

  // -----------------------------------------------
  String _university = "Select Your University";
  List<String> _universities = [];

  String get university {
    return _university;
  }

  void setUniversity(String univ) {
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
    //Check internet connectivity
    checkConnectivity();
    if (_isConnected ) {
      print("Set Events");

      if (_eventList.length == 0 && _fetchFlagCategories == false){
        getEventList();
        _fetchFlagCategories = true;
      }

      if (_universities.length == 0 && _fetchFlagUniversities == false){
        getUniversities();
        _fetchFlagUniversities = true;
      }

      if (_ulo_list.length == 0 && _fetchFlagULOs == false){
        getULOs();
        _fetchFlagULOs = true;
      }
    }
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // Connected to the internet
      _isConnected = true;
    }
  }

  void resetEventList() {
    _eventList = [];
  }

  
  void resetEventCategories() {
    _eventCategories = [];
  }

  void resetEventData() {
    resetEventData();
    resetEventCategories();
  }

  void getEventList() {
    db.collection('event_list').snapshots().listen(
      (snapshot) {
        // resetEventList();
        snapshot.documents.forEach((doc) {
          // populate _eventList
          _eventList = doc.data['names'].cast<String>();
          _eventList = _eventList.toSet().toList();
          print(_eventList);
        });
        if (_eventList.length != 0)
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
          _universities = doc.data['names'].cast<String>();
          _universities = _universities.toSet().toList();
          print(_universities);
          notifyListeners();
        });
      },
    );
  }

  void getULOs() {
    db.collection('ulo_list').snapshots().listen(
      (snapshot) {
        snapshot.documents.forEach((doc) {
          // populate ULOs
          
          List<int> tempList =  doc.data['univs'].cast<int>();
          List<String> unList = [];
          List<ULO> tempULOList = [];
          
          // populating _currentULOUnivs
          for(int i = 0; i< tempList.length; i++)
            unList.add(_universities[tempList[i]]);
          unList.toSet().toList();
          _currentULOUnivs = unList;
          
          //populating _uloNameList
          _uloNameList.add(doc.data['name']);
          _uloNameList = _uloNameList.toSet().toList();
          
          // populating _ulo_list
          tempULOList.add(new ULO(
            name: doc.data['name'],
            phoneNumber: doc.data['phone_number'],
            universities: unList,
          ));
          _ulo_list.addAll(tempULOList);
          
          notifyListeners();
        });
      },
    );
  }


  void getEventCategory(String collectionName) {
    db.collection(collectionName).snapshots().listen(
      (snapshot) {
        // resetEventData();
        List<SubEvent> subEvents = [];
        snapshot.documents.forEach((doc) {
          //populate all other Lists
          // List<String> headers = doc.data['d_headers'].cast<String>();
          // List<String> descriptions = doc.data['d_descs'].cast<String>();
          // List<EventDetail> eventDetails = [];
          // for (int i = 0; i < headers.length; i++)
          //   eventDetails.add(new EventDetail(
          //       id: i.toString(), header: headers[i], desc: descriptions[i]));

          subEvents.add(SubEvent(
            id: Key(doc.documentID),
            name: doc.data['name'],
            date: doc.data['date'],
            time: doc.data['time'],
            // description: doc.data['description'],
            location: doc.data['location'],
            // details: eventDetails,
            universities: [
              _universities[doc.data['universities'][0]],
              _universities[doc.data['universities'][1]]
            ],
          ));

          print("events ${subEvents.length}");
          print(collectionName);
        });

        _eventCategories.add(EventCategory(
            id: collectionName,
            name: collectionName,
            subEvents: [...subEvents]));
        _eventCategories = _eventCategories.toSet().toList();
        notifyListeners();
      },
    );
  }
}
