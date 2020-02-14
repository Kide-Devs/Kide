import 'package:flutter/material.dart';
import 'package:kide/config/Viewport.dart';
import 'package:kide/providers/getEvents.dart';
import 'package:kide/util/constants.dart';
import 'package:kide/util/data.dart';
import 'package:kide/widgets/HeaderWidget.dart';

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
                    for(int i=0;i<overView.length;i++)
                    Container(
                      child:Column(children: <Widget>[
                        Row(
                          children: <Widget>[
                            HeaderWidget(TOTAL_PARTICIPANTS, 15, Colors.white),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 12, 8, 0),
                              child: Text(overView[i].totalParticipants.toString()),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Divider( 
                            color: Colors.white,
                            endIndent: ViewPort.screenWidth*0.35,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:20.0),
                          child: Row(
                            children: <Widget>[
                              HeaderWidget(TOTAL_OFFICIALS, 15, Colors.white),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 12, 8, 0),
                                child: Text(overView[i].officials.length.toString()),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Divider( 
                            color: Colors.white,
                            endIndent: ViewPort.screenWidth*0.35,
                          ),
                        ),
                        // ADDITIONS :
                        for(int j=0;j<overView[i].officials.length;j++)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.bubble_chart,
                                      color: Color.fromRGBO(0, 112, 240, 100),
                                      size: 24.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: Text(
                                        overView[i].officials[j].name,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ),
                                  ]
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(32.0, 2, 0, 12),
                                  child: Text(
                                    overView[i].officials[j].designation,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ),
                              ]
                            ),
                          )
                        ],
                      )
                    )
                ],)
              )
            ],
          ),
        ),
    )
  );
}
}