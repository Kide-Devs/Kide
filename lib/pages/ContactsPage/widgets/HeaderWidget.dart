import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget{
  final String text;
  HeaderWidget(this.text);
  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: Text(text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.0
        ),
      )
    );
  }
}