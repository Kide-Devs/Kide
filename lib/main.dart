import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:Kide/pages/OnBoarding/OnBoarding.dart';
import 'package:Kide/MyApp.dart';
import 'package:Kide/SplashScreen.dart';

void main() {
  runApp(new DynamicTheme(
    defaultBrightness: Brightness.light,
    data: (Brightness brightness) {
      if (brightness == Brightness.dark) {
        return ThemeData(
            brightness: brightness,
            backgroundColor: Colors.white,
            scaffoldBackgroundColor: Color.fromARGB(255, 55, 55, 55),
            iconTheme: IconThemeData(color: Colors.grey),
            textTheme: TextTheme(
              title: TextStyle(color: Colors.white70),
              subtitle: TextStyle(color: Color.fromARGB(255, 187, 187, 187)),
            ));
      } else {
        return ThemeData(
          brightness: brightness,
          backgroundColor: Color(0xFFF9F9F9),
          scaffoldBackgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          textTheme: TextTheme(
            title: TextStyle(
              color: Colors.white
            ),
            subtitle: TextStyle(
              color: Colors.black
            )
          )
        );
      }
    },
    themedWidgetBuilder: (context, theme) => MaterialApp(
      theme: theme,
      home: new SplashScreen(),
      routes: <String, WidgetBuilder>{
        OnboardingMainPage.routeName: (BuildContext context) =>
            new OnboardingMainPage(),
        MyApp.routeName: (BuildContext context) => new MyApp()
      },
    ),
  ));
}
