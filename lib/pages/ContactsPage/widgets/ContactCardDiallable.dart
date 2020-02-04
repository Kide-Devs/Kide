import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCardDiallable extends StatelessWidget{
  final String name;
  final String number;
  final String desc;
  
  ContactCardDiallable(
    this.name, 
    this.number, 
    this.desc,
  );

  @override
  Widget build(BuildContext context){
    return Card(
      margin: EdgeInsets.fromLTRB(5, 15, 5, 15),
      color: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: new InkWell(
        onTap:(){
          launch('tel:\\$number');
          print('Contact Card tapped');
        },
      child: Center(
        child: Text(name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0
          )
          ),
        )
      )
    );
  }
}
