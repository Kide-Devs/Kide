import 'package:flutter/material.dart';
import 'package:Kide/pages/OnBoarding/OnBoarding.dart';
import 'package:Kide/MyApp.dart';
import 'package:Kide/SplashScreen.dart';

void main() {
  runApp(new MaterialApp(
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      OnboardingMainPage.routeName: (BuildContext context) => new OnboardingMainPage(),
      MyApp.routeName: (BuildContext context) => new MyApp()
    },
  ));
}


