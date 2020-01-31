import 'package:flutter/material.dart';
 
void main() => runApp(ContactsPage());
 
class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
        ),
        body: Center(
          child: Container(
            child: Text('Contacts Page'),
          ),
        ),
      ),
    );
  }
}