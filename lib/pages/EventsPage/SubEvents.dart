import 'package:flutter/material.dart';
import 'package:kide/models/EventCategory.dart';
import 'package:kide/models/SubEvent.dart';
import 'package:kide/pages/EventsPage/widgets/EntryItem.dart';
import 'package:kide/providers/university.dart';
import 'package:kide/data.dart';
import 'package:provider/provider.dart';

class SubEvents extends StatefulWidget {
  static const routeName = '/subEvents';

  @override
  _SubEventsState createState() => _SubEventsState();
}

class _SubEventsState extends State<SubEvents> {
  @override
  Widget build(BuildContext context) {
    final _university = Provider.of<University>(context);
    final EventCategory eventCategory = ModalRoute.of(context).settings.arguments;
    
    final Iterable<SubEvent> _subEventList = eventCategory.subEvents.where(
      (e) => _university.university == "Select Your University" ? true : e.universities.contains(_university.university)
    );

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(28.0, 8, 28, 8),
                child: DropdownButton(
                  isExpanded: true,
                  isDense: true,
                  value: _university.university,
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
                  items: ["Select Your University", ...universities].map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }
                  ).toList(),
                  onChanged: (String newVal) => _university.setUniversity(newVal),
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