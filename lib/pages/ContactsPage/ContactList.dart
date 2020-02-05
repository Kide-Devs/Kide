import 'package:flutter/material.dart';
import 'package:kide/models/ContactCategory.dart';
import 'package:kide/pages/ContactsPage/widgets/ContactCardDiallable.dart';
import 'package:kide/pages/ContactsPage/widgets/HeaderWidget.dart';



class ContactList extends StatelessWidget {
  static const routeName = '/ContactList';
  @override
  Widget build(BuildContext context) {
    final ContactCategory contactCategory = ModalRoute.of(context).settings.arguments;
    final _contactList = contactCategory.contacts;
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List',
          style: TextStyle(
            fontFamily: 'Roboto',
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(18, 18, 18, 1.0),
      body : Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  HeaderWidget(contactCategory.name),
                  Divider(
                    color: Colors.white,
                    endIndent: 194.0,
                  ),
                  // RotationTransition(
                  //   turns: AlwaysStoppedAnimation(750/360),
                  //   child: Divider(
                  //     height: 0.0,
                  //     color: Colors.white,
                  //     indent: 163.5,
                  //     endIndent: 175.0,
                  //   ),
                  // ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  for(int i=0;i<_contactList.length;i++)
                    ContactCardDiallable(_contactList[i].name, _contactList[i].number, _contactList[i].designation),
                ],
              ),
            )
          ]
        )
      )
    ); 
  }
}