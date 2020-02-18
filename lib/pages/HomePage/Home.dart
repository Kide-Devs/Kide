import 'package:Kide/models/Games.dart';
import 'package:Kide/providers/getGameDetails.dart';
import 'package:flutter/material.dart';
import 'package:Kide/config/Viewport.dart';
import 'package:Kide/pages/MapsPage/Maps.dart';
import 'package:Kide/providers/getMarkers.dart';
import 'package:Kide/providers/getEvents.dart';
import 'package:Kide/util/constants.dart';
import 'package:Kide/util/data.dart';
import 'package:Kide/widgets/HeaderWidget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(HomePage());

// ---------------------------------------//
//                                        //
// THIS IS KHELO INDIA SPECIFIC HOME PAGE //
//                                        //
// ---------------------------------------//

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final event = new KheloIndia(
    totUniversities: 80,
    food: "food_tent",
    totGames: 20,
    totParticipants: 1700,
  );

  void showQuickReviewDialog(BuildContext context, String university) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Color(0xff222222),
              titlePadding: EdgeInsets.fromLTRB(10.0, 10, 10, 2),
              contentPadding: EdgeInsets.fromLTRB(5.0, 2, 5, 8),
              title: Center(child: Text(university.toUpperCase())),
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Divider(
                    indent: 0,
                    endIndent: 0,
                    color: Colors.blueAccent,
                    thickness: 3,
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          HeaderWidget(TOTAL_PARTICIPANTS, 16, Colors.white),
                          Divider(
                            indent: ViewPort.screenWidth * 0.02,
                            endIndent: ViewPort.screenWidth * 0.02,
                            color: Colors.white38,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
                            child: HeaderWidget(
                                overView.totalParticipants, 24, Colors.white),
                          ),
                          HeaderWidget(
                              "Total Officials: ${overView.officials.length}",
                              16,
                              Colors.white),
                          Divider(
                            indent: ViewPort.screenWidth * 0.02,
                            endIndent: ViewPort.screenWidth * 0.02,
                            color: Colors.white38,
                          ),
                          for (int i = 0; i < overView.officials.length; i++)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      Icon(
                                        Icons.bubble_chart,
                                        color: Color.fromRGBO(0, 112, 240, 100),
                                        size: 24.0,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          overView.officials[i].name,
                                          softWrap: true,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white70),
                                        ),
                                      ),
                                    ]),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          32.0, 2, 0, 12),
                                      child: Text(
                                        overView.officials[i].designation,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.white70),
                                      ),
                                    ),
                                  ]),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        });
  }

  void showEventDialog(
      BuildContext context, Set<GameDetails> gameDetails) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Color(0xff222222),
              titlePadding: EdgeInsets.fromLTRB(10.0, 10, 10, 2),
              contentPadding: EdgeInsets.fromLTRB(5.0, 2, 5, 8),
              title: Center(child: Text(EVENT_OVERVIEW)),
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Divider(
                    indent: 0,
                    endIndent: 0,
                    color: Colors.blueAccent,
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          HeaderWidget(TOTAL_GAMES, 16, Colors.white),
                          Divider(
                            indent: ViewPort.screenWidth * 0.02,
                            endIndent: ViewPort.screenWidth * 0.02,
                            color: Colors.white38,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
                            child: HeaderWidget(
                                "${event.totGames}", 24, Colors.white),
                          ),
                          HeaderWidget(TOTAL_PARTICIPATING_UNIVERSITIES, 16,
                              Colors.white),
                          Divider(
                            indent: ViewPort.screenWidth * 0.02,
                            endIndent: ViewPort.screenWidth * 0.02,
                            color: Colors.white38,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
                            child: HeaderWidget(
                                "${event.totUniversities}", 24, Colors.white),
                          ),
                          HeaderWidget(
                              "Total Participants: ${event.totParticipants}",
                              16,
                              Colors.white),
                          Divider(
                            indent: ViewPort.screenWidth * 0.02,
                            endIndent: ViewPort.screenWidth * 0.02,
                            color: Colors.white38,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
                            child: HeaderWidget(
                                "${event.totParticipants}", 24, Colors.white),
                          ),
                          HeaderWidget(FOOD_STALL, 16, Colors.white),
                          Divider(
                            indent: ViewPort.screenWidth * 0.02,
                            endIndent: ViewPort.screenWidth * 0.02,
                            color: Colors.white38,
                          ),
                          HeaderWidget("${event.food.split('_').join(' ')}", 16,
                              Colors.white),
                          RaisedButton(
                              color: Colors.blueAccent,
                              child: Text(
                                SEARCH_ON_MAPS,
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                _goToMaps("campus_3");
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          Divider(
                            indent: ViewPort.screenWidth * 0.02,
                            endIndent: ViewPort.screenWidth * 0.02,
                            color: Colors.white38,
                          ),
                          HeaderWidget(ACCOMODATION, 16, Colors.white),
                          Divider(
                            indent: ViewPort.screenWidth * 0.02,
                            endIndent: ViewPort.screenWidth * 0.02,
                            color: Colors.white38,
                            thickness: 3,
                          ),
                          for (int i = 0; i < gameDetails.length; i++)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Center(
                                    child: HeaderWidget(
                                        gameDetails
                                            .elementAt(i)
                                            .name
                                            .toUpperCase(),
                                        16,
                                        Colors.white),
                                  ),
                                  _listItemBuilder(
                                      gameDetails.elementAt(i).gameAccomodations),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        });
  }

  void _goToMaps(String loc) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MapsPage(eventMarker: loc)));
  }

  RaisedButton _buildRaisedButton(String text, String location) {
    return RaisedButton(
      child: Text(
        text,
        style: TextStyle(fontSize: 8),
      ),
      color: Colors.blueAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: () {
        _goToMaps(location);
      },
    );
  }

  _listItemBuilder(Map<dynamic, dynamic> games) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i < games.length; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: ViewPort.screenWidth * 0.4,
                  child: Text(
                    games.keys.elementAt(i),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Spacer(),
                _buildRaisedButton(FIND_IN_MAPS, games.values.elementAt(i)),
              ],
            ),
        ],
      ),
    );
  }

  
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
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                color: Color.fromRGBO(18, 18, 18, 1),
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: ListView(children: <Widget>[
                  Image.asset(HOME_PAGE_ASSET_KHELO_INDIA_JPG),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                      ])),
                  Container(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28.0, 0, 28, 8),
                    child: RaisedButton(
                        color: Colors.orangeAccent,
                        child: Text(EVENT_OVERVIEW),
                        onPressed: () => showEventDialog(
                            context, _getGameDetails.gameDetails),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                  Container(height: 20),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(28.0, 8, 28, 8),
                      child: (_getEvents.userType == "Participant") ?
                        DropdownButton(
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
                          items: [
                            SELECT_YOUR_UNIVERSITY,
                            ..._getEvents.universities
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newVal) =>
                              _getEvents.setUniversity(newVal),
                        ) : DropdownButton(
                          isExpanded: true,
                          isDense: true,
                          value: _getEvents.uloUniversity,
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
                          items: [
                            SELECT_YOUR_UNIVERSITY,
                            ..._getEvents.ulo_list.firstWhere((u) {
                              return u.name == _getEvents.currentULO;
                            }).universities
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newVal) =>
                              _getEvents.setUloUniversity(newVal),
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28.0, 8, 28, 8),
                    child: RaisedButton(
                        color: _getEvents.university == SELECT_YOUR_UNIVERSITY
                            ? Colors.grey
                            : Colors.blueAccent,
                        child: Text(
                            _getEvents.university == SELECT_YOUR_UNIVERSITY
                                ? SELECT_A_UNIVERSITY
                                : QUICK_OVERVIEW),
                        onPressed: () =>
                            _getEvents.university == SELECT_YOUR_UNIVERSITY
                                ? {}
                                : {
                                    showQuickReviewDialog(
                                        context, _getEvents.university)
                                  },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                  (_getEvents.userType == "Participant") ?
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          STEPS_FOR_PARTICIPANTS,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          endIndent: ViewPort.screenWidth * 0.33,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 8, 0.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.bubble_chart,
                                color: Color.fromRGBO(0, 112, 240, 100),
                                size: 24.0,
                              ),
                              Text(
                                CONTACT_ULO,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              Spacer(),
                              RaisedButton(
                                  padding: EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                                  onPressed: () {
                                    launch('tel:\\8456841773');
                                    print("register");
                                  },
                                  textColor: Colors.white70,
                                  child: const Text('+91 8456841773',
                                      style: TextStyle(fontSize: 10)),
                                  color: Color.fromRGBO(0, 112, 240, 100),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ))
                            ],
                          ),
                        ),
                        // ---- Sub Section -----------
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                          child: Text(
                            ACCOMODATION,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                          child: Divider(
                            color: Colors.white,
                            endIndent: ViewPort.screenWidth * 0.33,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 8, 0.0),
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  child: Text(
                                    HOME_PAGE_ACCOMODATION_DESC,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 8, 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.bubble_chart,
                                color: Color.fromRGBO(0, 112, 240, 100),
                                size: 24.0,
                              ),
                              Container(
                                width: 4,
                              ),
                              Flexible(
                                child: Text(
                                  KEEP_YOUR_PARTICIPATION,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    height: 1.5,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(height: 20),
                        // ---- Sub Section -----------
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                          child: Text(
                            VERIFICATION,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                          child: Divider(
                            color: Colors.white,
                            endIndent: ViewPort.screenWidth * 0.33,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 8, 0.0),
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  child: Text(
                                    HOME_PAGE_VERIFICATION_DESC,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 8, 0.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.bubble_chart,
                                color: Color.fromRGBO(0, 112, 240, 100),
                                size: 24.0,
                              ),
                              Container(
                                width: 4,
                              ),
                              Flexible(
                                child: Text(
                                  KEEP_YOUR_PARTICIPATION,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    height: 1.5,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(height: 20),
                        // ---- Sub Section -----------
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                          child: Text(
                            ID_CARD_DISTRIBUTION,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                          child: Divider(
                            color: Colors.white,
                            endIndent: ViewPort.screenWidth * 0.33,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 8, 0.0),
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  child: Text(
                                    HOME_PAGE_VERIFICATION_PROCESS_IS_REQUIRED,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 8, 0.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.bubble_chart,
                                color: Color.fromRGBO(0, 112, 240, 100),
                                size: 24.0,
                              ),
                              Container(
                                width: 4,
                              ),
                              Flexible(
                                child: Text(
                                  KEEP_YOUR_PARTICIPATION,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    height: 1.5,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ) 
                  : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Information for ULOs",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          endIndent: ViewPort.screenWidth * 0.33,
                        ),
                      ]
                    )
                  )
                ]
              )
            )
          )
        : CircularProgressIndicator();
  }
}
