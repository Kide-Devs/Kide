import 'package:google_maps_flutter/google_maps_flutter.dart';

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
Set<Marker> foodcourts = {
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
Set<Marker> all = Set.from(campuses)..addAll(foodcourts)..addAll(gates);

Map<String, Set<Marker>> markers = {
  'all': all,
  'campuses': campuses,
  'foodcourts': foodcourts,
  'gates': gates,
};
