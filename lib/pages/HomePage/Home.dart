import 'package:flutter/material.dart';
import 'package:kide/config/Viewport.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(HomePage());

// ---------------------------------------//
//                                        //
// THIS IS KHELO INDIA SPECIFIC HOME PAGE //
//                                        //
// ---------------------------------------//

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ViewPort().init(context);
    return Padding(
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
            Container( height: 30),
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
                ],
              ),
            )
          ]
        )
      )
    );
  }
}
