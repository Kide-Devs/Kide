import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  final String _assets = 'lib/assets/events.jpg';
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
                  child: Text("Get to know What's Happening",
                    style: Theme.of(context).textTheme.display1.copyWith(color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 170),
                  child: Text("The Events Page let's you get a quick overlook of all the Ongoing Events across the campus",
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
