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
            )),
            SizedBox(
              height: 20,
            ),
            Text(
              "LoreNisi nulla aliquip amet cillum enim sunt. Sint enim in officia quis voluptate reprehenderit nisi amet. Duis eiusmod ipsum consectetur ex ex ea magna ad eu in. Elit voluptate deserunt excepteur est ipsum sunt sunt commodo. Proident elit ea commodo culpa ipsum ea adipisicing incididunt cupidatat nisi enim duis enim Lorem. Laborum labore est nulla sunt qui voluptate fugiat nostrud tempor voluptate.",
              style: TextStyle(fontSize: 20, fontFamily: 'EncodeSans'),
            )
          ],
        ),
      ),
    );
  }
}
