import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kide/data.dart';
import 'package:kide/models/Contact.dart';
import 'package:kide/models/EmergencyContact.dart';
import 'package:kide/pages/ContactsPage/widgets/HeaderWidget.dart';
import 'package:kide/pages/ContactsPage/widgets/EmergencyCard.dart';
import 'package:kide/pages/ContactsPage/widgets/ContactCard.dart';

void main() => runApp(ContactsPage());

class ContactsPage extends StatelessWidget {
  final _contactCategories = contactCategoryList;
  final _emergencyContacts = emergency;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 18, 18, 1.0),
      body : Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  HeaderWidget("Emergency Contacts"),
                  Divider(
                    color: Colors.white,
                    endIndent: 194.0,
                  ),
                  RotationTransition(
                    turns: AlwaysStoppedAnimation(750/360),
                    child: Divider(
                      height: 0.0,
                      color: Colors.white,
                      indent: 163.5,
                      endIndent: 175.0,
                    ),
                  ),
                ],
              ),
            ),
            SliverStaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              staggeredTiles: const <StaggeredTile>[
                const StaggeredTile.count(2, 1),
                const StaggeredTile.count(2, 1),
                const StaggeredTile.count(4, 1),
              ],
              // children: <Widget>[
              //   const EmergencyCard(Colors.red, Icons.local_hospital , 'Hospital','108'),
              //   const EmergencyCard(Colors.red, Icons.local_hospital , 'Police','100'),
              //   const EmergencyCard(Colors.red, Icons.local_hospital , 'Fire Brigade','101')
              // ],
              children: <Widget>[
                for(int i=0;i<_emergencyContacts.length;i++)
                  new EmergencyCard(_emergencyContacts[i].icon, _emergencyContacts[i].emergency, _emergencyContacts[i].number),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  HeaderWidget("Other Contacts"),
                  Divider(
                    color: Colors.white,
                    endIndent: 194.0,
                  ),
                  RotationTransition(
                    turns: AlwaysStoppedAnimation(750/360),
                    child: Divider(
                      height: 0.0,
                      color: Colors.white,
                      indent: 163.5,
                      endIndent: 175.0,
                    ),
                  ),
                ],
              ),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              delegate: SliverChildListDelegate(
                [
                  for(int i=0;i<contactCategoryList.length;i++)
                    ContactCard(_contactCategories[i]),
                ],
              ),
            )
          ]
        )
      )
    ); 
  }
}