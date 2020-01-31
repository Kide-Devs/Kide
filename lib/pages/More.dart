import 'package:flutter/material.dart';
 
void main() => runApp(MorePage());
 
class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('More'),
        ),
        body: Center(
          child: Container(
            child: Text('More Page'),
          ),
        ),
      ),
    );
  }
}