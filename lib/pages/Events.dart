import 'package:flutter/material.dart';
 
void main() => runApp(EventsPage());
 
class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Events'),
        ),
        body: Center(
          child: Container(
            child: Text('Events Page'),
          ),
        ),
      ),
    );
  }
}