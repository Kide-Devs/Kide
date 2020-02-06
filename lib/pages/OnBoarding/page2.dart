import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  final String _assets = 'lib/assets/contact.jpg';
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: double.infinity,
      width: double.infinity,
      decoration: new BoxDecoration(
        image: DecorationImage(
          image: AssetImage(_assets), 
          fit: BoxFit.cover
        )
      ),
      child: Stack(
        children: <Widget>[
          new Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('The Entire Campus Is Just A Tap Away',
                    style: Theme.of(context).textTheme.display1.copyWith(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 170),
                  child: Text('The Contacts Page allows you to connect to all the campuses at the push of a Button',
                    style: Theme.of(context).textTheme.body1.copyWith(color: Colors.black87),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
          )
        ],
        alignment: FractionalOffset.center,
      ),
    );
  }
}
