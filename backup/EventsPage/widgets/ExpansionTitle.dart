import 'package:Kide/config/Viewport.dart';
import 'package:Kide/models/SubEvent.dart';
import 'package:flutter/material.dart';

class ExpansionTitle extends StatelessWidget {
  const ExpansionTitle({
    Key key,
    @required this.context,
    @required this.exp,
    @required this.root,
  }) : super(key: key);

  final BuildContext context;
  final bool exp;
  final SubEvent root;

  @override
  Widget build(BuildContext context) {
    ViewPort().init(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          height: 65,
          width: ViewPort.screenWidth ,
          padding: const EdgeInsets.fromLTRB(10.0, 35.0, 0.0, 0.0),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 1350),
            curve: Curves.easeInOut,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    root.name.toUpperCase()
                  ),
              ],
            ),
          )
        ),
        Container(
          height: 65,
          width: ViewPort.screenWidth ,
          padding: EdgeInsets.fromLTRB(ViewPort.screenWidth * 0.025, 35.0, 0.0, 0.0),
          child: Icon(
            exp ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.amberAccent,
            size: 24.0,
          ),
        ),
      ],
    );
  }
}
