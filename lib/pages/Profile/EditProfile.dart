import 'package:Kide/util/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
        padding: EdgeInsets.only(left: 12, right: 12),
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'Email: $email',
              style: TextStyle(fontSize: 20, fontFamily: "EncodeSans"),
            ),
          ),
          SizedBox(
            height: 30,
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
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.confirmation_number),
                  title: Text(
                    'Roll:',
                    style: TextStyle(fontSize: 22, fontFamily: "EncodeSans"),
                  ),
                  subtitle: Text(
                    roll,
                    style: TextStyle(fontSize: 18, fontFamily: "EncodeSans"),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    color: DynamicTheme.of(context).data.iconTheme.color,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          title: Text('Edit Roll'),
                          content: TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue: roll,
                            onChanged: (value) {
                              setState(() {
                                roll = value;
                              });
                            },
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            FlatButton(
                              onPressed: () {
                                Firestore.instance
                                    .collection('userInfo')
                                    .document(uid)
                                    .updateData({
                                  "roll": roll,
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text('Update'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.text_fields),
                  title: Text(
                    'Name:',
                    style: TextStyle(fontSize: 22, fontFamily: "EncodeSans"),
                  ),
                  subtitle: Text(
                    name,
                    style: TextStyle(fontSize: 18, fontFamily: "EncodeSans"),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    color: DynamicTheme.of(context).data.iconTheme.color,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          title: Text('Edit Name'),
                          content: TextFormField(
                            initialValue: name,
                            onChanged: (value) {
                              setState(() {
                                name = value;
                              });
                            },
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            FlatButton(
                              onPressed: () async {
                                Firestore.instance
                                    .collection('userInfo')
                                    .document(uid)
                                    .updateData({
                                  "fullName": name,
                                });
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString('Name', name);
                                Navigator.of(context).pop();
                              },
                              child: Text('Update'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.plus_one),
                  title: Text(
                    'CGPA:',
                    style: TextStyle(fontSize: 22, fontFamily: "EncodeSans"),
                  ),
                  subtitle: Text(
                    cgpa,
                    style: TextStyle(fontSize: 18, fontFamily: "EncodeSans"),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    color: DynamicTheme.of(context).data.iconTheme.color,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          title: Text('Edit CGPA'),
                          content: TextFormField(
                            initialValue: cgpa,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                cgpa = value;
                              });
                            },
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            FlatButton(
                              onPressed: () {
                                Firestore.instance
                                    .collection('userInfo')
                                    .document(uid)
                                    .updateData({
                                  "cgpa": cgpa,
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text('Update'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text(
                    'Batch:',
                    style: TextStyle(fontSize: 22, fontFamily: "EncodeSans"),
                  ),
                  subtitle: Text(
                    batch,
                    style: TextStyle(fontSize: 18, fontFamily: "EncodeSans"),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    color: DynamicTheme.of(context).data.iconTheme.color,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          title: Text('Edit Batch'),
                          content: TextFormField(
                            initialValue: batch,
                            onChanged: (value) {
                              setState(() {
                                batch = value;
                              });
                            },
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            FlatButton(
                              onPressed: () {
                                Firestore.instance
                                    .collection('userInfo')
                                    .document(uid)
                                    .updateData({"batch": batch});
                                Navigator.of(context).pop();
                              },
                              child: Text('Update'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.category),
                  title: Text(
                    'Branch:',
                    style: TextStyle(fontSize: 22, fontFamily: "EncodeSans"),
                  ),
                  subtitle: Text(
                    branch,
                    style: TextStyle(fontSize: 18, fontFamily: "EncodeSans"),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    color: DynamicTheme.of(context).data.iconTheme.color,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          title: Text('Edit Branch'),
                          content: TextFormField(
                            initialValue: branch,
                            onChanged: (value) {
                              setState(() {
                                branch = value;
                              });
                            },
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            FlatButton(
                              onPressed: () {
                                Firestore.instance
                                    .collection('userInfo')
                                    .document(uid)
                                    .updateData({
                                  "branch": branch,
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text('Update'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
