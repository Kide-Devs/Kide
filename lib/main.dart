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

     if (firstTime != null && !firstTime) {
      // Not first time
      return new Timer(_duration, navigationMyApp);
    } else {
      // First time
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
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Center(
                child: new Image.asset('lib/assets/Icon/kide_logoldpi.png',
                    width: size.width / 4,
                    height: size.height / 4,
                    fit: BoxFit.contain),
              ),
            ],
          ),
          AnimatedOpacity(
            opacity: 0.8,
            duration: Duration(milliseconds: 4500),
            curve: Curves.easeInOut,
            child: Text(
              'KIDE',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                letterSpacing: 25.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
