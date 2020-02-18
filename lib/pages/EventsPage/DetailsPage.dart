import 'package:flutter/material.dart';
import 'package:Kide/config/Viewport.dart';
import 'package:Kide/pages/MapsPage/Maps.dart';
import 'package:Kide/util/constants.dart';
import '../../models/SubEvent.dart';
import 'package:Kide/widgets/HeaderWidget.dart';

class DetailsPage extends StatelessWidget {
  static const routeName = '/DetailsPage';
  @override
  Widget build(BuildContext context) {
    final SubEvent _subEvent = ModalRoute.of(context).settings.arguments;

    ViewPort().init(context);
    return Scaffold(
        appBar: AppBar(
            title: Text(
          _subEvent.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
          ),
        )
      ),
      backgroundColor: Color.fromRGBO(18, 18, 18, 1.0),
      body : Padding(
        padding: const EdgeInsets.fromLTRB(12, 0 , 12 , 0 ),
        child: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    HeaderWidget("Date",15.0,Colors.white),
                    Divider(
                      color: Colors.white,
                      endIndent: ViewPort.screenWidth*0.55,
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0 , 0 , 12 ),
                      child: HeaderWidget(_subEvent.date, 12,Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20 , 0 ,0 ),
                      child: HeaderWidget("Venue", 15.0,Colors.white),
                    ),
                    Divider(
                      color: Colors.white,
                      endIndent: ViewPort.screenWidth*0.55,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0 , 0 ,35 ),
                        child: HeaderWidget(_subEvent.location, 12,Colors.white),
                      ),
                      HeaderWidget("Time", 15,Colors.white),
                      Divider(
                      color: Colors.white,
                      endIndent: ViewPort.screenWidth*0.55,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0 , 0 ,35 ),
                        child: HeaderWidget(_subEvent.time, 12,Colors.white),
                      ),
                      Row(
                        children: <Widget>[
                        HeaderWidget("Description", 15,Colors.white),
                        Spacer(),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top:10.0),
                            child: RaisedButton(
                              color: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(GO_TO_EVENT,
                                style: TextStyle(
                                  //fontWeight: FontWeight.,
                                  fontSize: 10
                                ),
                              ),
                              onPressed: () {
                                print("Detail press");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MapsPage(eventMarker: _subEvent.location)));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                      endIndent: ViewPort.screenWidth * 0.55,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        _subEvent.description,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: HeaderWidget("DETAILS", 15.0,Colors.white),
                      ),
                    ),
                    Divider(
                      indent: ViewPort.screenWidth * 0.25,
                      color: Colors.white,
                      endIndent: ViewPort.screenWidth * 0.25,
                    ),
                    for (int i = 0; i < _subEvent.details.length; i++)
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                              child: HeaderWidget("${_subEvent.details[i].header}:", 15,Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(35, 0, 0, 20),
                              child: Text(
                                _subEvent.details[i].desc,
                                style:
                                    TextStyle(fontSize: 12, fontFamily: 'Roboto', color: Colors.white70),
                              ),
                            )
                          ],
                        ),
                      )
                  ]
                ),
              ),
            ]
          )
        ),
      )
    );
  }
}
