import 'package:flutter/material.dart';
import 'package:kide/models/EventCategory.dart';
import 'package:kide/models/SubEvent.dart';

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
          itemBuilder: (context, position) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)
              ),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: ()  {
                  // Navigator.of(context).pushNamed(
                  //   SubEvents.routeName,
                  //   arguments: _eventList.eventCategories[position]
                  // );
                  print('Card tapped.');
                },
                child: Stack(children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          './lib/assets/event.jpg',
                        ),
                      ),
                    ),
                    height: 120.0,
                  ),
                  Container(
                    height: 120.0,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.64),
                        borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Center(
                      child: Text(
                        _subEventList[position].name.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 20,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    )
                  ),
                  
                ]), 
              ),
              margin: const EdgeInsets.fromLTRB(0.0, 14.0, 0.0, 14.0),
            );
          },
          itemCount: _subEventList.length,
          padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
        )
      ),
    );
  }
}