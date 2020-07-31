import 'package:Kide/pages/Auth/Login.dart';
import 'package:Kide/pages/Preferences/PreferencesPage.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:Kide/pages/OnBoarding/OnBoarding.dart';
import 'package:Kide/MyApp.dart';
import 'package:Kide/SplashScreen.dart';
import 'package:flutter/services.dart';

void main() {
   SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(new DynamicTheme(
    defaultBrightness: Brightness.light,
    data: (Brightness brightness) {
      if (brightness == Brightness.dark) {
        return ThemeData(
          brightness: brightness,
          backgroundColor: Colors.black,
          tabBarTheme: TabBarTheme(labelStyle: TextStyle(color: Colors.white)),
          scaffoldBackgroundColor: Color.fromARGB(255, 31, 31, 31),
          iconTheme: IconThemeData(color: Colors.grey),
          textTheme: TextTheme(
            title: TextStyle(color: Colors.white70),
            subtitle: TextStyle(color: Color.fromARGB(255, 187, 187, 187)),
          ),
          cardColor: Color.fromARGB(255, 93, 93, 93),
        );
      } else {
        return ThemeData(
          brightness: brightness,
          backgroundColor: Color(0xFFF9F9F9),
          scaffoldBackgroundColor: Colors.white,
          tabBarTheme: TabBarTheme(labelStyle: TextStyle(color: Colors.black)),
          iconTheme: IconThemeData(color: Colors.black),
          textTheme: TextTheme(
            title: TextStyle(color: Colors.white),
            subtitle: TextStyle(color: Colors.black),
          ),
          cardColor: Color.fromARGB(255, 200, 200, 220),
        );
      }
    },
    themedWidgetBuilder: (context, theme) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: new SplashScreen(),
      onUnknownRoute: (settings) {
        print(settings);
        return MaterialPageRoute(
          builder: (BuildContext context) => LoginPage(),
          settings: settings,
        );
      },
      routes: <String, WidgetBuilder>{
        OnboardingMainPage.routeName: (BuildContext context) =>
            new OnboardingMainPage(),
        MyApp.routeName: (BuildContext context) => new MyApp(),
        LoginPage.routeName: (BuildContext context) => new LoginPage(),
      },
    ),
  ));
}
