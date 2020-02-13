import 'package:flutter/material.dart';
import 'dart:async';
import 'package:kide/pages/OnBoarding/OnBoarding.dart';
import 'package:kide/util/constants.dart';
import './MyApp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SplashScreen.dart';

void main() {
  runApp(new MaterialApp(
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      OnboardingMainPage.routeName: (BuildContext context) => new OnboardingMainPage(),
      MyApp.routeName: (BuildContext context) => new MyApp()
    },
  ));
}


