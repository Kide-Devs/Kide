import 'package:flutter/material.dart';
 
void main() => runApp(HomePage());
 
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
          child: Container(
            child: Text('Home Page'),
          ),
        ),
      ),
    );
  }
}