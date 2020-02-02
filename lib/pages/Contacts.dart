import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


void main() => runApp(ContactsPage());

class Contact{
  const Contact({this.title});
  final String title;
}

const List<Contact> contacts = const <Contact>[
  const Contact(title: 'Hostels'),
  const Contact(title: 'Helpline'),
  const Contact(title: 'Administration'),
  const Contact(title: 'Hostels'),
  const Contact(title: 'Hostels'),
  const Contact(title: 'Hostels'),
  const Contact(title: 'Hostels'),
  const Contact(title: 'Hostels'),
  const Contact(title: 'Hostels'),
  const Contact(title: 'Hostels'),
  //const Contact(title: "That's all folks"),
];


class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title : Text('Contacts',
      //   textAlign: TextAlign.center,
      //   )
      // ),
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
              children: <Widget>[
                const EmergencyCard(Colors.red, Icons.local_hospital , 'Hospital'),
                const EmergencyCard(Colors.red, Icons.local_hospital , 'Police'),
                const EmergencyCard(Colors.red, Icons.local_hospital , 'Fire Brigade')
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
                  const ContactCard('Hostels'),
                  const ContactCard('Helpline'),
                  const ContactCard('Administration'),
                  const ContactCard('Hostels'),
                  const ContactCard('Hostels'),
                  const ContactCard('Hostels'),
                  const ContactCard('Hostels'),
                  // const ContactCard('Hostels'),
                  // const ContactCard('Hostels'),
                  // const ContactCard('Hostels'),
                  // const ContactCard('Hasdasstels'),
                  // const ContactCard('Hostels'),
                  // const ContactCard('Hostasdasdls'),
                  // const ContactCard('Hostedfgdfgdfgls'),
                ],
                addRepaintBoundaries: false,
                addAutomaticKeepAlives: false,
              ),
            )
          ]
        )
      )
    ); 
  }
}

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

class ContactCard extends StatelessWidget{
  // const ContactCard({Key key, this.contact}) : super(key: key);
  // final Contact contact;
  const ContactCard(this.name);
  final String name;

  @override
  Widget build(BuildContext context){
    //final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      margin: EdgeInsets.fromLTRB(5, 15, 5, 15),
      color: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: new InkWell(
        onTap:(){

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

class EmergencyCard extends StatelessWidget{
  const EmergencyCard(this.backgroundColor, this.iconData, this.name);
  final Color backgroundColor;
  final IconData iconData;
  final String name;

  @override
  Widget build(BuildContext context){
    return new Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0)
      ),
      margin: EdgeInsets.all(16),
      color: backgroundColor,
      child: new InkWell(
        onTap:(){

        },
      child: new Center(
        child: new Padding(
          padding:  const EdgeInsets.fromLTRB(0, 6.5, 0, 0),
          child: Column(
            children: <Widget>[
              new Icon(
                iconData,
                color: Colors.white,
              ),
              Center(
                child: Text(name,
                  style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0
                  )
                ),
                )
              ],
            )
          ),
        )
      )
    ); 
  }
}

// Center(
//                   child: Text('Emergency Contacts',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 15.0
//                 ),
//               ),
//             )