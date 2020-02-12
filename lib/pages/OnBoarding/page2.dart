import 'package:flutter/material.dart';
import 'package:kide/config/Viewport.dart';

class Page2 extends StatelessWidget {
  final String _assets = 'lib/assets/contact.png';
  @override
  Widget build(BuildContext context) {
    ViewPort().init(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Container(
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            new Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('The Entire Campus Is Just A Tap Away',
                      style: Theme.of(context).textTheme.display1.copyWith(color: Colors.blueAccent),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Image.asset(
                    _assets,
                    height: ViewPort.screenHeight*0.4,
                    // width: ViewPort.screenWidth*0.6,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 80),
                    child: Text('The Contacts Page allows you to connect to all the campuses at the push of a Button',
                      style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white70),
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              ),
            )
          ],
          alignment: FractionalOffset.center,
        ),
      ),
    );
  }
}