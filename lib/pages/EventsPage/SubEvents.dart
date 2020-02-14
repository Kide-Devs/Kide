import 'package:flutter/material.dart';
import 'package:kide/models/EventCategory.dart';
import 'package:kide/models/SubEvent.dart';
import 'package:kide/pages/EventsPage/widgets/EntryItem.dart';
import 'package:kide/providers/getEvents.dart';
import 'package:kide/util/constants.dart';
import 'package:provider/provider.dart';
import 'package:kide/config/Viewport.dart';
import 'package:kide/widgets/HeaderWidget.dart';

class SubEvents extends StatefulWidget {
  static const routeName = '/subEvents';

  @override
  _SubEventsState createState() => _SubEventsState();
}

class _SubEventsState extends State<SubEvents> {
  // void showQuickReviewDialog(BuildContext context, String university) async{
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       ViewPort().init(context);
  //       return AlertDialog(
  //         backgroundColor: Color(0xff222222),
  //         titlePadding: EdgeInsets.fromLTRB(10.0, 10, 10, 2),
  //         contentPadding: EdgeInsets.fromLTRB(5.0, 2, 5, 8),
  //         title: Center(child: Text(university.toUpperCase())),
  //         titleTextStyle: TextStyle(
  //           color: Colors.white,
  //           fontSize: 18
  //         ),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             Divider(
  //               indent: 0,
  //               endIndent: 0,
  //               color: Colors.blueAccent,
  //               thickness: 3,
  //             ),
  //             Flexible(
  //               child: SingleChildScrollView(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: <Widget>[
  //                     HeaderWidget("", 8, Colors.accents),
  //                     Divider(
  //                       color: Colors.white,
  //                       endIndent: ViewPort.screenWidth * 0.55,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
  //                       child: HeaderWidget(subEvent.date, 12, Colors.white),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
  //                       child: HeaderWidget("Venue", 15.0, Colors.white),
  //                     ),
  //                     Divider(
  //                       color: Colors.white,
  //                       endIndent: ViewPort.screenWidth * 0.55,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
  //                       child: HeaderWidget(subEvent.location, 12, Colors.white),
  //                     ),
  //                     HeaderWidget("Time", 15, Colors.white),
  //                     Divider(
  //                       color: Colors.white,
  //                       endIndent: ViewPort.screenWidth * 0.55,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
  //                       child: HeaderWidget(subEvent.time, 12, Colors.white),
  //                     ),
  //                     Row(
  //                       children: <Widget>[
  //                         HeaderWidget("Description", 15, Colors.white),
  //                         Spacer(),
  //                         Container(
  //                           height: 30,
  //                           child: Padding(
  //                             padding: const EdgeInsets.only(top: 10.0),
  //                             child: RaisedButton(
  //                               child: Text(
  //                                 GO_TO_EVENT,
  //                                 style: TextStyle(
  //                                   //fontWeight: FontWeight.,
  //                                   fontSize: 10
  //                                 ),
  //                               ),
  //                               onPressed: () {
  //                                 print("Detail press");
  //                                 Navigator.push(
  //                                     context,
  //                                     MaterialPageRoute(
  //                                         builder: (context) =>
  //                                             MapsPage(eventMarker: subEvent.location)));
  //                               },
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     Divider(
  //                       color: Colors.white,
  //                       endIndent: ViewPort.screenWidth * 0.55,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(left: 8.0),
  //                       child: Text(
  //                         subEvent.description,
  //                         style: TextStyle(
  //                           fontSize: 12.0,
  //                           color: Colors.white,
  //                         ),
  //                       ),
  //                     ),
  //                     Center(
  //                       child: Padding(
  //                         padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
  //                         child: HeaderWidget("DETAILS", 15.0, Colors.white),
  //                       ),
  //                     ),
  //                     Divider(
  //                       indent: ViewPort.screenWidth * 0.25,
  //                       color: Colors.white,
  //                       endIndent: ViewPort.screenWidth * 0.25,
  //                     ),
  //                     for (int i = 0; i < subEvent.details.length; i++)
  //                       Container(
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: <Widget>[
  //                             Padding(
  //                               padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
  //                               child: HeaderWidget(
  //                                   subEvent.details[i].header, 15, Colors.white),
  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.fromLTRB(35, 0, 0, 20),
  //                               child: Text(
  //                                 subEvent.details[i].desc,
  //                                 style: TextStyle(fontSize: 12, fontFamily: 'Roboto'),
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                       )
  //                   ],
  //                 )
  //               )
  //             )
  //           ]
  //         )
  //       );
  //     }
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    final _getEvents = Provider.of<GetEvents>(context);
    final EventCategory eventCategory =
        ModalRoute.of(context).settings.arguments;

    final Iterable<SubEvent> _subEventList = eventCategory.subEvents.where(
        (e) => _getEvents.university == SELECT_YOUR_UNIVERSITY
            ? true
            : e.universities.contains(_getEvents.university));

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28.0, 8, 28, 8),
            child: DropdownButton(
              isExpanded: true,
              isDense: true,
              value: _getEvents.university,
              icon: Icon(Icons.keyboard_arrow_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(
                color: Colors.white70,
              ),
              underline: Container(
                height: 2,
                color: Color.fromRGBO(0, 112, 240, 87),
              ),
              items: [SELECT_YOUR_UNIVERSITY, ..._getEvents.universities]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String newVal) {
                _getEvents.setUniversity(newVal);
                print(_subEventList);
              },
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            EntryItem(_subEventList.elementAt(index)),
        itemCount: _subEventList.length,
        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
      ),
      backgroundColor: Color.fromRGBO(18, 18, 18, 1.0),
    );
  }
}

class HeaderWidget {}
