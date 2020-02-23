// import 'package:Kide/pages/MapsPage/Maps.dart';
// import 'package:Kide/providers/getGameDetails.dart';
// import 'package:flutter/material.dart';
// import 'package:Kide/models/EventCategory.dart';
// import 'package:Kide/models/SubEvent.dart';
// import 'package:Kide/pages/EventsPage/widgets/EntryItem.dart';
// import 'package:Kide/providers/getEvents.dart';
// import 'package:Kide/util/constants.dart';
// import 'package:provider/provider.dart';
// import 'package:Kide/config/Viewport.dart';
// import 'package:Kide/widgets/HeaderWidget.dart';

// class SubEvents extends StatefulWidget {
//   static const routeName = '/subEvents';

//   @override
//   _SubEventsState createState() => _SubEventsState();
// }

// class _SubEventsState extends State<SubEvents> {
//   @override
//   Widget build(BuildContext context) {
//     final _getEvents = Provider.of<GetEvents>(context);
//     final EventCategory eventCategory =
//         ModalRoute.of(context).settings.arguments;

//     final Iterable<SubEvent> _subEventList = eventCategory.subEvents.where(
//         (e) => _getEvents.university == SELECT_YOUR_UNIVERSITY
//             ? true
//             : e.universities.contains(_getEvents.university));

//     final _getGameDetails = Provider.of<GetGameDetails>(context);

//     void _goToMaps(String loc) {
//       Navigator.push(context,
//           MaterialPageRoute(builder: (context) => MapsPage(eventMarker: loc)));
//     }

//     RaisedButton _buildRaisedButton(String text, String location) {
//       return RaisedButton(
//         child: Text(
//           text,
//           style: TextStyle(fontSize: 8),
//         ),
//         color: Colors.blueAccent,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         onPressed: () {
//           _goToMaps(location);
//         },
//       );
//     }

//     _listItemBuilder(Map<dynamic, dynamic> games) {
//       return Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             for (int i = 0; i < games.length; i++)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     width: ViewPort.screenWidth * 0.5,
//                     child: Text(
//                       games.keys.elementAt(i),
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   Spacer(),
//                   _buildRaisedButton(FIND_IN_MAPS, games.values.elementAt(i)),
//                 ],
//               ),
//           ],
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: InkWell(
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(28.0, 8, 28, 8),
//             child: DropdownButton(
//               isExpanded: true,
//               isDense: true,
//               value: _getEvents.university,
//               icon: Icon(Icons.keyboard_arrow_down),
//               iconSize: 24,
//               elevation: 16,
//               style: TextStyle(
//                 color: Colors.white70,
//               ),
//               underline: Container(
//                 height: 2,
//                 color: Color.fromRGBO(0, 112, 240, 87),
//               ),
//               items: [SELECT_YOUR_UNIVERSITY, ..._getEvents.universities]
//                   .map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               onChanged: (String newVal) {
//                 // _getEvents.setUniversity(newVal);
//                 print(_subEventList);
//               },
//             ),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
//         child: ListView(
//           children: <Widget>[
//             Center(
//               child: HeaderWidget(
//                   _getGameDetails.gameDetails.elementAt(eventCategory.id).name.toUpperCase(),
//                   32,
//                   Colors.white),
//             ),
//             Row(
//               children: <Widget>[
//                 Text('Food Venue', style: TextStyle(fontWeight: FontWeight.bold)),
//                 Spacer(),
//                 _buildRaisedButton(QUENCH_YOUR_HUNGER,
//                     _getGameDetails.gameDetails.elementAt(eventCategory.id).food)
//               ],
//             ),
//             Row(
//               children: <Widget>[
//                 Text('Transportation',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//                 Spacer(),
//                 _buildRaisedButton(QUENCH_YOUR_HUNGER,
//                     _getGameDetails.gameDetails.elementAt(eventCategory.id).food)
//               ],
//             ),
//             Text('Accomodations', style: TextStyle(fontWeight: FontWeight.bold)),
//             Padding(
//               padding: const EdgeInsets.only(left: 32.0),
//               child: _listItemBuilder(
//                 _getGameDetails.gameDetails.elementAt(eventCategory.id).gameAccomodations,
//               ),
//             ),
//             Text('Game Venues', style: TextStyle(fontWeight: FontWeight.bold)),
//             Padding(
//               padding: const EdgeInsets.only(left: 32.0),
//               child: _listItemBuilder(
//                 _getGameDetails.gameDetails.elementAt(eventCategory.id).venues,
//               ),
//             ),
//             for (int i = 0; i < _subEventList.length; i++)
//               EntryItem(_subEventList.elementAt(i)),
//           ],
//         ),
//       ),
//       backgroundColor: Color.fromRGBO(18, 18, 18, 1.0),
//     );
//   }
// }
