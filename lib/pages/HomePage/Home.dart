import 'package:flutter/material.dart';
import 'package:kide/config/Viewport.dart';
import 'package:kide/providers/getMarkers.dart';
import 'package:kide/providers/getEvents.dart';
import 'package:kide/util/constants.dart';
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
    //for Events
    if (_getEvents.eventList.length == 0) _getEvents.setEvents();

    bool _isButtonDisabled = true;
    // void initState(){
    //   _isButtonDisabled = true;
    // }

    ViewPort().init(context);

    return _getMarkers.markers.length > 0 && _getEvents.eventList.length > 0
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                color: Colors.black12,
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: ListView(children: <Widget>[
                  Image.asset(HOME_PAGE_ASSET_KHELO_INDIA_JPG),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
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
                  InkWell(
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
                                : DASHBOARD),
                        onPressed: () =>
                            _getEvents.university == SELECT_YOUR_UNIVERSITY
                                ? {}
                                : {
                                    Navigator.pushNamed(
                                      context,
                                      '/MoreHome',
                                      // arguments: {_getMarkers, _getEvents},
                                      arguments: _getEvents,
                                    )
                                  }),
                  ),
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
                ])))
        : Center(child: CircularProgressIndicator());
  }
}
