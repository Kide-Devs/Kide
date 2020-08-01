import 'package:Kide/pages/Auth/Login.dart';
import 'package:Kide/pages/Profile/EditProfile.dart';
import 'package:Kide/pages/Profile/profile.dart';
import 'package:Kide/util/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:Kide/pages/AboutUsPage.dart/AboutUs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int ct = 0;
  bool isDarkModeEnabled = false;
  @override
  void initState() {
    super.initState();
  }

  _changeBrightness(context) {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    if (ct == 0) {
      isDarkModeEnabled =
          Theme.of(context).brightness == Brightness.dark ? true : false;
      ct++;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: DynamicTheme.of(context).data.cardColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "Settings",
          style: TextStyle(fontSize: 22, fontFamily: "Quicksand"),
        ),
        backgroundColor: DynamicTheme.of(context).data.backgroundColor,
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.only(left: 12, right: 12, top: 15),
          children: <Widget>[
            Text(
              "General",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()));
                    },
                    leading: Icon(Icons.person),
                    title: Text(
                      "Profile Settings",
                      style: TextStyle(fontFamily: "Quicksand", fontSize: 20),
                    ),
                  ),
                  ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile()));
                      },
                      title: Text(
                        "Edit Profile  ",
                        style: TextStyle(fontFamily: "Quicksand", fontSize: 20),
                      ),
                      leading: Icon(Icons.camera)),
                  ListTile(
                      title: Text(
                        "Push Notifications ",
                        style: TextStyle(fontFamily: "Quicksand", fontSize: 20),
                      ),
                      trailing: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: SwitchListTile(
                            activeColor: Colors.red,
                            value: true,
                            onChanged: (v) {
                              print(v);
                            }),
                      )),
                  // ListTile(
                  //   title: Text(
                  //     "Dark Mode ",
                  //     style: TextStyle(fontFamily: "Quicksand", fontSize: 20),
                  //   ),
                  //   trailing: Transform.scale(
                  //     scale: 0.6,
                  //     child: DayNightSwitcher(
                  //       isDarkModeEnabled: isDarkModeEnabled,
                  //       onStateChanged: (isDarkModeEnabled) {
                  //         setState(() {
                  //           this.isDarkModeEnabled = isDarkModeEnabled;
                  //           _changeBrightness(context);
                  //         });
                  //       },
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Support",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () async {
                      // final Email email = Email(
                      //   body: 'Email body',
                      //   subject: 'Email subject',
                      //   recipients: ['example@example.com'],
                      //   cc: ['cc@example.com'],
                      //   bcc: ['bcc@example.com'],
                      //   attachmentPaths: ['/path/to/attachment.zip'],
                      //   isHTML: false,
                      // );

                      // await FlutterEmailSender.send(email);
                    },
                    leading: Icon(Icons.help),
                    title: Text(
                      "Help & Feedback",
                      style: TextStyle(fontFamily: "Quicksand", fontSize: 20),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.lock),
                    title: Text(
                      "Privacy Policy",
                      style: TextStyle(fontFamily: "Quicksand", fontSize: 20),
                    ),
                  ),
                  ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AboutUs()));
                      },
                      title: Text(
                        "About Us",
                        style: TextStyle(fontFamily: "Quicksand", fontSize: 20),
                      ),
                      leading: Icon(Icons.info)),
                  ListTile(
                    onTap: () async {
                      FirebaseAuth _auth = FirebaseAuth.instance;
                      await _auth.signOut();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('loggedOut', true);
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    leading: Icon(Icons.exit_to_app),
                    title: Text(
                      'Sign Out',
                      style: TextStyle(fontFamily: "Quicksand", fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
