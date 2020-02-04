import 'package:flutter/material.dart';
import 'package:kide/models/ContactCategory.dart';
import 'package:kide/pages/ContactsPage/MaleHostels.dart';


class ContactCard extends StatelessWidget{
  const ContactCard(this.contactCategory);
  final ContactCategory contactCategory;

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
          Navigator.of(context).pushNamed(
            MaleHostels.routeName,
            arguments: contactCategory
          );
          print('Contact Card tapped');
        },
      child: Center(
        child: Text(contactCategory.name,
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

