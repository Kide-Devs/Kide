import 'package:flutter/material.dart';
import 'package:kide/config/Viewport.dart';
import 'package:kide/providers/getMarkers.dart';
import 'package:provider/provider.dart';
import 'package:kide/providers/university.dart';
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
    _getMarkers.markers.length == 0 ? _getMarkers.setMarkers() : _getMarkers.setMarkerMap();
    // University Listener
    final _university = Provider.of<University>(context);
    ViewPort().init(context);

    return _getMarkers.markers.length > 0 ? Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.black12,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0)
        ),
        child: ListView(
          children: <Widget>[
            Image.asset("./lib/pages/HomePage/assets/KIUG_KIIT.jpg"),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      "KHELO INDIA",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: ViewPort.screenWidth * 0.03
                      ),
                    )
                  ),
                  Center(
                    child: Text(
                      "UNIVERSITY GAMES 2020",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: ViewPort.screenWidth * 0.02
                      ),
                    )
                  ),
                ]
              )
            ),
            Container( height: 20),
            InkWell(
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
                  items: <String>["Select University", "hello", "KIIT", "VIT", "SRM", "BITS"]
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  })
                  .toList(),
                  onChanged: (String newVal) => _university.setUniversity(newVal),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Steps for participants: ",
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
                          "  Contact ULO: ",
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
                          )
                        )
                      ],
                    ),
                  ),

  // ---- Sub Section -----------
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                    child: Text(
                      "Accomodation: ",
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
                              "Book your room by reaching the alloted accomodation/hostel as instructed by your ULO by showing the above mentioned documents.",
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
                      children: <Widget>[
                        Icon(
                          Icons.bubble_chart,
                          color: Color.fromRGBO(0, 112, 240, 100),
                          size: 24.0,
                        ),
                        Text(
                          "  Keep you Particiaption Letter & College ID",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
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
                      "Verification: ",
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
                              "The Verification process is required for each of the participants to actually take part in the event. No student will be allowed to play the games without verification documents. \n\nVenue: \tGandhi Chowk, Campus 6, KIIT.\nTime:    09:00 to 18:00",
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
                      children: <Widget>[
                        Icon(
                          Icons.bubble_chart,
                          color: Color.fromRGBO(0, 112, 240, 100),
                          size: 24.0,
                        ),
                        Text(
                          "  Keep you Particiaption Letter & College ID",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
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
                      "ID Card Distribution: ",
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
                              "The Verification process is required for each of the participants to actually take part in the event. No student will be allowed to play the games without verification documents. \n\nThe verification process will take place at Gandhi Chowk, Campus 6, KIIT.",
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
                      children: <Widget>[
                        Icon(
                          Icons.bubble_chart,
                          color: Color.fromRGBO(0, 112, 240, 100),
                          size: 24.0,
                        ),
                        Text(
                          "  Keep you Particiaption Letter & College ID",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ]
        )
      )
    )
    : CircularProgressIndicator();
  }
}
