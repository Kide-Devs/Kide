import 'package:Kide/pages/Profile/EditProfile.dart';
import 'package:Kide/util/constants.dart';
import 'package:Kide/widgets/CircularAvatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
        backgroundColor: DynamicTheme.of(context).data.backgroundColor,
      ),
      backgroundColor: DynamicTheme.of(context).data.backgroundColor,
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blueGrey.withOpacity(0.3),
                  Colors.blueGrey.withOpacity(0.2)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            margin: EdgeInsets.only(left: 12, right: 12),
            child: Container(
              transform: Matrix4.translationValues(0, -44, 0),
              child: Column(
                children: [
                  InitialNameAvatar(
                    name,
                    backgroundColor: Colors.tealAccent.shade700,
                    foregroundColor: Colors.white,
                    textSize: 32,
                    borderSize: 10,
                    borderColor: Colors.blueGrey.withOpacity(0.3),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    roll,
                    style: TextStyle(fontSize: 26, fontFamily: "Quicksand"),
                  ),
                  name != ''
                      ? Text(
                          name,
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: "Quicksand",
                              fontWeight: FontWeight.w600),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 24,
                          child: LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                              Colors.grey.withOpacity(0.5),
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                  Text(
                    email,
                    style: TextStyle(fontSize: 20, fontFamily: "Quicksand"),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blueGrey.withOpacity(0.3),
                  Colors.blueGrey.withOpacity(0.2)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            margin: EdgeInsets.only(left: 12, right: 12),
            child: Column(
              children: <Widget>[
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
          ),
          SizedBox(height: 40),
          Center(
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 28),
                decoration: BoxDecoration(
                  color: Colors.redAccent.shade400,
                  borderRadius: BorderRadius.circular(50),
                  // Large enough value
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.shade200.withOpacity(0.8),
                      blurRadius: 20,
                      offset: Offset(0, 5),
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Text(
                  "Edit",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditProfile(),
                  ),
                ); //_changeBright
              },
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
