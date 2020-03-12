import 'package:Kide/pages/HomePage/models/CardDetails.dart';
//import 'package:Kide/providers/getGameDetails.dart';
import 'package:flutter/material.dart';
import 'package:Kide/config/Viewport.dart';
import 'package:Kide/providers/getMarkers.dart';
//import 'package:Kide/providers/getEvents.dart';
import 'package:Kide/pages/HomePage/HomepageProvider.dart';
import 'package:Kide/util/data.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*void getData()
  {

    cardDetails.toSet().toList();

    var firestore = Firestore.instance;
    var qn = firestore.collection("blog_post_homepage").getDocuments();

    qn.then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f)  {
        cardDetails.add(CardDetails(heading: f.data['heading'],
            image:  Image.network(f.data['image'].toString()),
            cardType: f.data['card'],
            description: f.data['subheading']));
      });
    });
    if(cardDetails.length>4)
      {
        cardDetails.removeRange(0, 4);
      }

  }*/
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // final _getEvents = Provider.of<GetEvents>(context);
    // if (_getEvents.eventList.length == 0) _getEvents.setEvents();

    // // Get Game details
    // final _getGameDetails = Provider.of<GetGameDetails>(context);
    // if (_getGameDetails.gameDetails.length == 0)
    //   _getGameDetails.setGameDetails();
  }
  List<CardDetails> cardDetailsnew = [];
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    // Markers Listner
    final _getMarkers = Provider.of<GetMarkers>(context);
    final _getCardDetails = Provider.of<HomePageProvider>(context);
    //for markers
    if (_getMarkers.suggestedMarkers.length == 0)
      _getMarkers.setSuggestedMarkers();
      
    _getMarkers.markers.length == 0
        ? _getMarkers.setMarkers()
        : _getMarkers.setMarkerMap();

    // for CardDetails
    if (_getCardDetails.cardDetails.length == 0)
      _getCardDetails.getData();
    //for suggested markers

    // // Events Listener
    // final _getEvents = Provider.of<GetEvents>(context);

    // // Game Details
    // final _getGameDetails = Provider.of<GetGameDetails>(context);

    ViewPort().init(context);

    return _getMarkers.markers.length > 0 && _getCardDetails.cardDetails.length > 0?
        RefreshIndicator(
            child: ListView.builder(
                itemBuilder: (BuildContext context, index) =>
                _getCardDetails.cardDetails[index].cardType == 1
                    ? _buildLargeCard(_getCardDetails.cardDetails[index])
                    : _buildSmallCard(_getCardDetails.cardDetails[index]),
                itemCount: _getCardDetails.cardDetails.length
            ),
            onRefresh: _getCardDetails.refreshList
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
