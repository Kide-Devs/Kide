import 'package:flutter/material.dart';
import 'dart:async';
import 'package:kide/pages/OnBoarding/OnBoarding.dart';
import './MyApp.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(new MaterialApp(
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/OnBoarding': (BuildContext context) => new OnboardingMainPage(),
      '/MyApp': (BuildContext context) => new MyApp()
    },
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time');

    var _duration = new Duration(seconds: 2);

    if (firstTime != null && !firstTime) {// Not first time
      return new Timer(_duration, navigationMyApp);
    } else {// First time
      prefs.setBool('first_time', false);
      return new Timer(_duration, navigationOnBoarding);
    }
  }

  void navigationMyApp() {
    Navigator.of(context).pushReplacementNamed('/MyApp');
  }

  void navigationOnBoarding() {
    Navigator.of(context).pushReplacementNamed('/OnBoarding');
  }
  @override
  void initState() {
    super.initState();
    startTime();
  }

@override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Center(
            child: new Image.asset(
              'lib/assets/Icon/kide_logoxxxhdpi.png',
              width: size.width/2,
              height: size.height/2,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}