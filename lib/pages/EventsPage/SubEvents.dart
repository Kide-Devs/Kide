import 'package:flutter/material.dart';
import 'package:kide/models/EventCategory.dart';
import 'package:kide/models/SubEvent.dart';
import 'package:kide/pages/EventsPage/widgets/EntryItem.dart';

class SubEvents extends StatelessWidget {
  static const routeName = '/subEvents';
  @override
  Widget build(BuildContext context) {
    final EventCategory eventCategory = ModalRoute.of(context).settings.arguments;
    final List<SubEvent> _subEventList = eventCategory.subEvents;
    return Scaffold(
      appBar: AppBar(
        title: Text(eventCategory.name.toUpperCase()),
      ),
      body: (
        ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              EntryItem(_subEventList[index]),
          itemCount: _subEventList.length,
          padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
        )
      ),
      backgroundColor: Color.fromRGBO(18, 18, 18, 1.0),
    );
  }
}