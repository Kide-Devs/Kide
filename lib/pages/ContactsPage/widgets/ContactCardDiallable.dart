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
      margin: EdgeInsets.fromLTRB(8, 20, 8, 20),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Name : $name',
              //textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0
              )
            ),
            Text('Designation : $desc',
            //textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0
              ),
            ),
            Text('Number : $number',
            //textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromRGBO(0, 112, 240, 100),
                fontSize: 11.5
              ),
            )
          ],
        ),
        )
      )
    );
}
}



