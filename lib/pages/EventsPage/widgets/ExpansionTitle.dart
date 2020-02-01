import 'package:flutter/material.dart';
import 'package:kide/models/SubEvent.dart';

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
    return Column(
      children: <Widget>[
        Container(
          height: 65,
          width: MediaQuery.of(context).size.width ,
          padding: const EdgeInsets.fromLTRB(10.0, 35.0, 0.0, 0.0),
          child: exp ? Text(
              root.name.toUpperCase()
            ) : 
            Center(
              child: Text(
                root.name.toUpperCase(),
              ),
            ),
          ),
          Icon(
            exp ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.amberAccent,
            size: 24.0,
            semanticLabel: 'Text to announce in accessibility modes',
          )
      ],
    );
  }
}
