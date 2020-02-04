import 'package:flutter/material.dart';

class ContactCardButton extends StatelessWidget{
  final String name;
  final String phone;
  final String desc;
  
  ContactCardButton(
    this.name, 
    this.phone, 
    this.desc
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
