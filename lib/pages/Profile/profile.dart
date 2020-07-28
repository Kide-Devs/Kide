import 'package:Kide/pages/Profile/EditProfile.dart';
import 'package:Kide/util/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auro_avatar/auro_avatar.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String uid;
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((value) {
      setState(() {
        email = value.email;
        uid = value.uid;
      });
    }).whenComplete(() => getData());
  }

  getData() {
    Firestore.instance.collection('userInfo').document(uid).get().then((value) {
      setState(() {
        roll = value.data['roll'];
        name = value.data['fullName'];
        cgpa = value.data['cgpa'];
        batch = value.data['batch'];
        branch = value.data['branch'];
      });
    });
  }

  String name = '';
  String email = '';
  String roll = '';
  String cgpa = '';
  String batch = '';
  String branch = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: DynamicTheme.of(context).data.textTheme.subtitle1.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        title: new Text(
          KIDE_CAPS,
          style: TextStyle(
            color: DynamicTheme.of(context).data.textTheme.subtitle1.color,
            fontFamily: "Michroma",
            fontWeight: FontWeight.w300,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            color: DynamicTheme.of(context).data.iconTheme.color,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditProfile(),
                ),
              ); //_changeBrigh
            },
          ),
        ],
        backgroundColor: DynamicTheme.of(context).data.backgroundColor,
      ),
      backgroundColor: DynamicTheme.of(context).data.backgroundColor,
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Center(
              child: InitialNameAvatar(
            name,
            circleAvatar: true,
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            textSize: 32,
            borderColor: Colors.grey,
          )),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              roll,
              style: TextStyle(fontSize: 26, fontFamily: "EncodeSans"),
            ),
          ),
          Center(
            child: Text(
              name,
              style: TextStyle(fontSize: 24, fontFamily: "EncodeSans"),
            ),
          ),
          Center(
            child: Text(
              email,
              style: TextStyle(fontSize: 20, fontFamily: "EncodeSans"),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ListTile(
            leading: Icon(Icons.plus_one),
            title: Text(
              'CGPA:',
              style: TextStyle(fontSize: 22, fontFamily: "EncodeSans"),
            ),
            trailing: Text(
              cgpa,
              style: TextStyle(fontSize: 18, fontFamily: "EncodeSans"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text(
              'Batch:',
              style: TextStyle(fontSize: 22, fontFamily: "EncodeSans"),
            ),
            trailing: Text(
              batch,
              style: TextStyle(fontSize: 18, fontFamily: "EncodeSans"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text(
              'Branch:',
              style: TextStyle(fontSize: 22, fontFamily: "EncodeSans"),
            ),
            trailing: Text(
              branch,
              style: TextStyle(fontSize: 18, fontFamily: "EncodeSans"),
            ),
          ),
        ],
      ),
    );
  }
}
