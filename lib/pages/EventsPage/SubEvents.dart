import 'package:flutter/material.dart';
import 'package:Kide/models/EventCategory.dart';
import 'package:Kide/models/SubEvent.dart';
import 'package:Kide/pages/EventsPage/widgets/EntryItem.dart';
import 'package:Kide/providers/getEvents.dart';
import 'package:Kide/util/constants.dart';
import 'package:provider/provider.dart';
import 'package:Kide/config/Viewport.dart';
import 'package:Kide/widgets/HeaderWidget.dart';

class SubEvents extends StatefulWidget {
  static const routeName = '/subEvents';

  @override
  _SubEventsState createState() => _SubEventsState();
}

class _SubEventsState extends State<SubEvents> {
  
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
