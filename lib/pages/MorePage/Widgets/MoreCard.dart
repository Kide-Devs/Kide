import 'package:Kide/models/More.dart';
import 'package:Kide/pages/MorePage/MoreDetails.dart';
import 'package:flutter/material.dart';

class MoreCard extends StatelessWidget {
  MoreCard(this._more, this._color);

  final More _more;
  final Color _color;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(5, 15, 5, 15),
      color: _color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: new InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            MoreDetails.routeName,
            arguments: _more,
          );
          print('More Card tapped');
        },
        child: Center(
          child: Text(_more.moreName,
              style: TextStyle(color: Colors.white, fontSize: 15.0)),
        ),
      ),
    );
  }
}
