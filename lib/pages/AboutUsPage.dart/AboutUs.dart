import 'package:Kide/util/constants.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("About Us"),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(30),
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Center(
              child: Image.asset(
                MAIN_KIDE_LOGO,
                height: 150,
                width: 150,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Thank you for using KIDE, the KIIT guide by the students, for the students! We're a small team of Flutter Developers who decided to take the initiative to create an app which could serve as a hub for all the day-to-day student tasks as well as general tasks related to our esteemed university. We hope that our work reflects this ideology and you get to enjoy a seamless user experience with minimal issues. However, we'd love to hear from you. Feel free write your suggestions and queries to us at - kide.kiit@gmail.com",
              style: TextStyle(fontSize: 20, fontFamily: 'EncodeSans'),
            )
          ],
        ),
      ),
    );
  }
}
