import 'package:flutter/material.dart';
import 'package:kide/models/Event.dart';
import 'package:kide/data.dart';
import 'package:kide/pages/EventsPage/BookmarksPage.dart';
import 'package:kide/pages/EventsPage/SubEvents.dart';
import 'package:kide/providers/bookmarks.dart';
import 'package:provider/provider.dart';
void main() => runApp(EventsPage());

class EventsPage extends StatelessWidget {
  final _eventList =  Event(
    id: "01",
    name: "KIITFEST 6.0",
    startDate: "1st March 2020",
    endDate: "4th March 2020",
    eventCategories: eventCategories
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.collections_bookmark),
        heroTag: hashCode,
        onPressed: ()  {
          Navigator.of(context).pushNamed(
            BookmarksPage.routeName,
          );
          print('Card tapped.');
        },
      ),
      backgroundColor: Color.fromRGBO(18, 18, 18, 1.0),
      body: ListView.builder(
        itemBuilder: (context, position) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
            ),
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: ()  {
                Navigator.of(context).pushNamed(
                  SubEvents.routeName,
                  arguments: _eventList.eventCategories[position]
                );
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
                      _eventList.eventCategories[position].name.toUpperCase(),
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
        itemCount: _eventList.eventCategories.length,
        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
      ),
    );
  }
}
