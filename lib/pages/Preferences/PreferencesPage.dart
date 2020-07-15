import 'package:Kide/pages/Auth/Login.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesPage extends StatelessWidget {
  _changeBrightness(context) {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Preferences",
        ),
        backgroundColor: DynamicTheme.of(context).data.appBarTheme.color,
      ),
      backgroundColor: DynamicTheme.of(context).data.scaffoldBackgroundColor,
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: GestureDetector(
              child: Row(
                children: <Widget>[
                  Icon(Icons.brightness_6),
                  SizedBox(width: 5),
                  Text(
                    "Brightness",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              onTap: () => _changeBrightness(context),
            ),
          ),
          GestureDetector(
            child: Container(
              width: 20,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Sign Out",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            onTap: () async {
              FirebaseAuth _auth = FirebaseAuth.instance;
              await _auth.signOut();
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('loggedOut', true);
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
