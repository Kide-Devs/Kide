import 'package:flutter/material.dart';
import 'package:kide/config/Viewport.dart';
import 'package:kide/providers/getEvents.dart';
import 'package:kide/providers/getMarkers.dart';
import 'package:kide/util/constants.dart';
import 'package:kide/widgets/HeaderWidget.dart';
import 'package:url_launcher/url_launcher.dart';

// class Arguments {
//   final GetEvents _quickEvents;
//   final GetMarkers _quickMarkers;

//   Arguments(this._quickEvents,this._quickMarkers);
// }

class MoreHome extends StatelessWidget{
  static const routeName = '/MoreHome';
  @override
  Widget build(BuildContext context) {
    ViewPort().init(context);
    final GetEvents _quickEvents = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 18, 18, 1.0),
      appBar: AppBar(
        title: Text(
          _quickEvents.university
        ),
      ),
      body : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget> [
                            HeaderWidget("COACH",15,Colors.white),
                          ]
                        ),
                         Spacer(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8,12,8,0),
                          child: Container(
                            height: 20,
                            child: RaisedButton(
                              padding: EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                              onPressed: () {
                                launch('tel:\\123456789');
                                print("register");
                              },
                              textColor: Colors.white70,
                              child: const Text('+91 123456789',
                                  style: TextStyle(fontSize: 10)),
                              color: Color.fromRGBO(0, 112, 240, 100),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )
                            )
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Divider(
                        color: Colors.white,
                        endIndent: ViewPort.screenWidth*0.45,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),

                      //ENTER COACH INFO HERE 

                      // HERE ----------V-------
                      child: Text("COACH ANUJEET",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300
                        ),
                      ),
                    ),
                    
                    // AGILE (PART_1) !

                   Padding(
                     padding: const EdgeInsets.only(top:25.0),
                     child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget> [
                            HeaderWidget("FOOD VENUE",15,Colors.white),
                          ]
                        ),
                         Spacer(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8,12,8,0),
                          child: Container(
                            height: 20,
                            child: RaisedButton(
                              padding: EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                              onPressed: () {
                                //launch('tel:\\123456789');
                                print("VENUE");
                              },
                              textColor: Colors.white70,
                              child: const Text(GO_TO_VENUES,
                                  style: TextStyle(fontSize: 10)),
                              color: Color.fromRGBO(0, 112, 240, 100),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )
                            )
                          ),
                        )
                      ],
                  ),
                   ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Divider(
                      color: Colors.white,
                      endIndent: ViewPort.screenWidth*0.45,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),

                  //ENTER VENUES HERE 

                  //-----------------------V---------------
                    child: Text("KP - 6 MESS\n\nKP - 9 MESS"),
                  ),


                //AGILE PART_2 !



                Padding(
                     padding: const EdgeInsets.only(top:25.0),
                     child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget> [
                            HeaderWidget("ACCOMODATIONS",15,Colors.white),
                          ]
                        ),
                         Spacer(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8,12,8,0),
                          child: Container(
                            height: 20,
                            child: RaisedButton(
                              padding: EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                              onPressed: () {
                                //launch('tel:\\123456789');
                                print("VENUE");
                              },
                              textColor: Colors.white70,
                              child: const Text(GO,
                                  style: TextStyle(fontSize: 10)),
                              color: Color.fromRGBO(0, 112, 240, 100),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )
                            )
                          ),
                        )
                      ],
                  ),
                   ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Divider(
                      color: Colors.white,
                      endIndent: ViewPort.screenWidth*0.45,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),

                  //ENTER ACCOMODATIONS HERE 

                  //-----------------------V---------------
                    child: Text("KP - 7\n\nKP - 10"),
                  ),


                  ],
                ),
              ),
            ]
          )
        ),
      )
  );
  }
}