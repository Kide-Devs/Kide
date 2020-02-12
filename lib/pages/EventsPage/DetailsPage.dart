import 'package:flutter/material.dart';
import 'package:kide/config/Viewport.dart';
import 'package:kide/pages/MapsPage/Maps.dart';
import '../../models/SubEvent.dart';
import 'package:kide/widgets/HeaderWidget.dart';

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
        )),
        backgroundColor: Color.fromRGBO(18, 18, 18, 1.0),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Container(
              child: CustomScrollView(slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                HeaderWidget("Date", 15.0),
                Divider(
                  color: Colors.white,
                  endIndent: ViewPort.screenWidth * 0.55,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                  child: HeaderWidget(_subEvent.date, 12),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: HeaderWidget("Venue", 15.0),
                ),
                Divider(
                  color: Colors.white,
                  endIndent: ViewPort.screenWidth * 0.55,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                  child: HeaderWidget(_subEvent.location, 12),
                ),
                HeaderWidget("Time", 15),
                Divider(
                  color: Colors.white,
                  endIndent: ViewPort.screenWidth * 0.55,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                  child: HeaderWidget(_subEvent.time, 12),
                ),
                Row(
                  children: <Widget>[
                    HeaderWidget("Description", 15),
                    Spacer(),
                    Container(
                      height: 30,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: RaisedButton(
                          child: Text(
                            'GO TO EVENT',
                            style: TextStyle(
                                //fontWeight: FontWeight.,
                                fontSize: 10),
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
                    child: HeaderWidget("DETAILS", 15.0),
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
                          child: HeaderWidget(_subEvent.details[i].header, 15),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(35, 0, 0, 20),
                          child: Text(
                            _subEvent.details[i].desc,
                            style:
                                TextStyle(fontSize: 12, fontFamily: 'Roboto'),
                          ),
                        )
                      ],
                    ),
                  )
              ]),
            ),
          ])),
        ));
  }
}
