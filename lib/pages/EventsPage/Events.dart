import 'package:flutter/material.dart';
import 'package:Kide/config/Viewport.dart';
import 'package:Kide/providers/getEvents.dart';
import 'package:Kide/pages/EventsPage/BookmarksPage.dart';
import 'package:Kide/pages/EventsPage/SubEvents.dart';
import 'package:Kide/util/constants.dart';
import 'package:provider/provider.dart';
import 'package:Kide/widgets/HeaderWidget.dart';

void main() => runApp(EventsPage());

class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Events Listener
    final _getEvents = Provider.of<GetEvents>(context);
    // for Events
    if (_getEvents.eventList.length == 0) _getEvents.setEvents();

    ViewPort().init(context);
    print("sub events ${_getEvents.eventCategories}");
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.collections_bookmark),
      //   heroTag: hashCode,
      //   onPressed: () {
      //     Navigator.of(context).pushNamed(
      //       BookmarksPage.routeName,
      //     );
      //     print('Card tapped.');
      //   },
      // ),
      backgroundColor: Color.fromRGBO(18, 18, 18, 1.0),
      body: ListView(
        children: <Widget>[
          Image.asset(HOME_PAGE_ASSET_KHELO_INDIA_JPG),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Center(
                  child: Column(children: <Widget>[
                    Center(
                        child: Text(
                      KHELO_INDIA,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: ViewPort.screenWidth * 0.03),
                    )),
                    Center(
                        child: Text(
                      UNIVERSITY_GAMES_2020,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          letterSpacing: ViewPort.screenWidth * 0.02),
                    )),
                  ]),
                ),
                for (int i = 0; i < _getEvents.eventCategories.length; i++)
                  _buildEventCard(context, _getEvents, i),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Card _buildEventCard(
      BuildContext context, GetEvents _getEvents, int position) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          // Navigator.of(context).pushNamed(SubEvents.routeName,
          //     arguments: _getEvents.eventCategories[position]);
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
                  EVENTS_PAGE_EVENT_JPG,
                ),
              ),
            ),
            height: 120.0,
          ),
          Container(
              height: 120.0,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.64),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Center(
                child: Text(
                  _getEvents.eventCategories[position].name.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: ViewPort.screenWidth * 0.05,
                      fontWeight: FontWeight.w600),
                ),
              )),
        ]),
      ),
      margin: const EdgeInsets.fromLTRB(0.0, 14.0, 0.0, 14.0),
    );
  }
}
