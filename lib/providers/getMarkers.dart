import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import "package:google_maps_flutter/google_maps_flutter.dart";

class GetMarkers with ChangeNotifier {
  bool _isConnected = true;
  //Create Firebase Instance
  Firestore db = Firestore.instance;

  //Initialize the marker set
  Set<Marker> _all = {};
  Set<Marker> _campuses = {};
  Set<Marker> _food = {};
  Set<Marker> _gates = {};
  Set<Marker> _hostels = {};
  Set<Marker> _sports = {};
  Set<Marker> _toilets = {};
  Set<Marker> _events = {};

  List<Marker> _suggestedMarkers = [];

  Map<String, Set<Marker>> _markers = {};

  Map<String, Set<Marker>> get markers {
    return _markers;
  }

  List<Marker> get suggestedMarkers {
    return _suggestedMarkers.toSet().toList();
  }

  void setMarkers() {
    if (_isConnected) {
      getMarkerData('campuses', _campuses);
      getMarkerData('food', _food);
      getMarkerData('gates', _gates);
      getMarkerData('hostels', _hostels);
      getMarkerData('sports', _sports);
      getMarkerData('toilets', _toilets);
      getMarkerData('events', _events);
      getMarkerData('gardens', _events);

      setMarkerMap();
    }
  }

  void setSuggestedMarkers() {
    if (_isConnected) {
      getSuggestedMarkerData(_suggestedMarkers);
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

  void getSuggestedMarkerData(List<Marker> markerset) {
    db.collection('suggestedMarkers').snapshots().listen(
      (snapshot) {
        snapshot.documents.forEach((doc) {
          markerset.add(populateMarker(doc));
          notifyListeners();
        });
      },
    );
  }

  void setMarkerMap() {
    _all = Set.from(_campuses)
      ..addAll(_food)
      ..addAll(_gates)
      ..addAll(_hostels)
      ..addAll(_sports)
      ..addAll(_toilets)
      ..addAll(_events);
    _markers = {
      'all': _all,
      'campuses': _campuses,
      'food': _food,
      'gates': _gates,
      'hostels': _hostels,
      'sports': _sports,
      'toilets': _toilets,
      'events': _events,
    };
    // notifyListeners();
  }

  void getMarkerData(String category, Set<Marker> markerset) {
    db.collection(category).snapshots().listen(
      (snapshot) {
        snapshot.documents.forEach((doc) {
          markerset.add(populateMarker(doc));
          if(category == "food")
            print("$markerset \n\n\n\n\n");
          notifyListeners();
        });
      },
    );
  }

  Marker populateMarker(DocumentSnapshot doc) {
    return Marker(
      markerId: MarkerId(doc.documentID),
      position: LatLng(doc.data['lat'], doc.data['long']),
      infoWindow: InfoWindow(
        title: doc.data['title'],
        snippet: doc.data['snippet'],
      ),
    );
  }
}
