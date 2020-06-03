import 'dart:async';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:Kide/pages/OnBoarding/OnBoarding.dart';
import 'package:Kide/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MyApp.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 1.0;

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
    Navigator.of(context).pushReplacementNamed(MyApp.routeName);
  }

  void navigationOnBoarding() {
    Navigator.of(context).pushReplacementNamed(OnboardingMainPage.routeName);
  }

  double _opacityAnimator(double op) {
    setState(() => _opacity = op == 0.5 ? 1.0 : 1.0);
    return _opacity;
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
      backgroundColor: DynamicTheme.of(context).data.backgroundColor,
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Center(
                child: AnimatedOpacity(
                  opacity: _opacityAnimator(_opacity),
                  duration: Duration(milliseconds: 1700),
                  curve: Curves.easeInOut,
                  child: Opacity(
                    opacity: 1.0,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 1350),
                      curve: Curves.easeInOut,
                      width: size.width / (4 * _opacityAnimator(_opacity)),
                      height: size.height / (4.0 * _opacityAnimator(_opacity)),
                      child: Image.asset(
                        MAIN_KIDE_LOGO,
                        gaplessPlayback: true,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 20,
          ),
          AnimatedOpacity(
            opacity: 0.8,
            duration: Duration(milliseconds: 4500),
            curve: Curves.easeInOut,
            child: Text(
              KIDE_CAPS,
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: "Michroma",
                color: DynamicTheme.of(context).data.textTheme.subtitle.color,
                letterSpacing: 20.0,
              ),
            ),
          ),
          Container(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: LinearProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
