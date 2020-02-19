import 'package:Kide/pages/HomePage/models/CardDetails.dart';
import 'package:Kide/providers/getGameDetails.dart';
import 'package:flutter/material.dart';
import 'package:Kide/config/Viewport.dart';
import 'package:Kide/providers/getMarkers.dart';
import 'package:Kide/providers/getEvents.dart';
import 'package:Kide/util/data.dart';
import 'package:provider/provider.dart';

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _getEvents = Provider.of<GetEvents>(context);
    if (_getEvents.eventList.length == 0) _getEvents.setEvents();

    // Get Game details
    final _getGameDetails = Provider.of<GetGameDetails>(context);
    if (_getGameDetails.gameDetails.length == 0)
      _getGameDetails.setGameDetails();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Markers Listner
    final _getMarkers = Provider.of<GetMarkers>(context);
    //for markers
    _getMarkers.markers.length == 0
        ? _getMarkers.setMarkers()
        : _getMarkers.setMarkerMap();
    //for suggested markers
    if (_getMarkers.suggestedMarkers.length == 0)
      _getMarkers.setSuggestedMarkers();

    // Events Listener
    final _getEvents = Provider.of<GetEvents>(context);

    // Game Details
    final _getGameDetails = Provider.of<GetGameDetails>(context);

    ViewPort().init(context);

    return _getMarkers.markers.length > 0
        ? ListView.builder(
            itemBuilder: (BuildContext context, index) =>
                cardDetails[index].cardType == 1
                    ? _buildLargeCard(cardDetails[index])
                    : _buildSmallCard(cardDetails[index]),
            itemCount: cardDetails.length,
          )
        : CircularProgressIndicator();
  }

  Column _buildSmallCard(CardDetails card) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  card.heading,
                  softWrap: true,
                  style: TextStyle(
                    letterSpacing: 0,
                    fontSize: 16,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
              ),
            ),
            Container(
              width: 150,
              // height: 150,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                clipBehavior: Clip.hardEdge,
                child: card.image,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Divider(
            color: Colors.white38,
            thickness: 2,
          ),
        )
      ],
    );
  }

  Column _buildLargeCard(CardDetails card) {
    return Column(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          clipBehavior: Clip.hardEdge,
          child: card.image,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            card.heading,
            style: TextStyle(
              letterSpacing: 2,
              fontSize: 20,
              color: Colors.white,
              height: 1.3,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            card.description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white60,
              // height: 0.3,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Divider(
            color: Colors.white38,
            thickness: 2,
          ),
        )
      ],
    );
  }
}
