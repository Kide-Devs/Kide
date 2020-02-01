import 'package:flutter/material.dart';

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
        //constraints: BoxConstraints(maxHeight: double.infinity),
        //height: 1298,
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
            flex: 1,
            child: 
            GridView.count(
              // primary: false,
              shrinkWrap: true,
              //addRepaintBoundaries: true,
              crossAxisCount: 2,
              children: List.generate(contacts.length, (index) {
                return Center(
                  child: ContactCard(contact: contacts[index]),
                );
              }),
            )),
            Flexible(
            flex: 0,
            child: 
            Center(
              child: Text("That's all Folks!")
            ))
          ]
        ),
      )
      // bottomNavigationBar: BottomAppBar(
      //   child: Text('That\u0027s all folks'),
      //   //clipBehavior: Clip.none,
      //   color: Color.fromRGBO(18, 18, 18, 1.0),
      // ),
    ); 
  }
}

class ContactCard extends StatelessWidget{
  const ContactCard({Key key, this.contact}) : super(key: key);
  final Contact contact;

  @override
  Widget build(BuildContext context){
    //final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      //margin: EdgeInsets.,
      color: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: Center(
        child: Text(contact.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0
          )
        ),
      )
    );
  }
}