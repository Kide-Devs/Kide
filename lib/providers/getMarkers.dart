import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "package:google_maps_flutter/google_maps_flutter.dart";

class GetMarkers with ChangeNotifier {
  //Create Firebase Instance
  Firestore db = Firestore.instance;

  //i=Initialize the marker set
  Set<Marker> _campuses = {};
  Set<Marker> _food = {};
  Set<Marker> _gates = {};
  Set<Marker> _all = {};
  List<Marker> _suggestedMarkers = [];

  Map<String, Set<Marker>> _markers = {};

  Map<String, Set<Marker>> get markers {
    return _markers;
  }

  List<Marker> get suggestedMarkers {
    return _suggestedMarkers;
  }

  void setMarkers() {
    getMarkerData('campuses', _campuses);
    getMarkerData('food', _food);
    getMarkerData('gates', _gates);

    setMarkerMap();
    // notifyListeners();
  }

  void setSuggestedMarkers() {
    getSuggestedMarkerData(_suggestedMarkers);
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
    _all = Set.from(_campuses)..addAll(_food)..addAll(_gates);
    _markers = {
      'all': _all,
      'campuses': _campuses,
      'food': _food,
      'gates': _gates,
    };
    // notifyListeners();
  }

  void getMarkerData(String category, Set<Marker> markerset) {
    db.collection(category).snapshots().listen(
      (snapshot) {
        snapshot.documents.forEach((doc) {
          markerset.add(populateMarker(doc));
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
