import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget{
  final double _size;
  final String text;
  final Color color;
  HeaderWidget(this.text, this._size, this.color);
  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: Text(text,
        style: TextStyle(
          color: color,
          fontSize: _size
        ),
      )
    );
  }
}