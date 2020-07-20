import 'dart:async';

import 'package:Kide/MyApp.dart';
import 'package:Kide/pages/Auth/SignUp.dart';
import 'package:Kide/util/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeirdTextFieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final path = Path();

    paint.strokeWidth = 2;
    paint.strokeCap = StrokeCap.round;
    paint.color = Colors.cyanAccent.shade200;

    path.lineTo(20, 0);
    path.lineTo(size.width - 20, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - 20, size.height);
    path.lineTo(20, size.height);
    path.lineTo(0, size.height / 2);
    path.lineTo(20, 0);

    canvas.drawPath(path, Paint()..color = Colors.black54);

    canvas.drawLine(Offset(20, 0), Offset(size.width - 20, 0), paint);
    canvas.drawLine(
        Offset(size.width - 20, 0), Offset(size.width, size.height / 2), paint);
    canvas.drawLine(Offset(size.width, size.height / 2),
        Offset(size.width - 20, size.height), paint);
    canvas.drawLine(
        Offset(size.width - 20, size.height), Offset(20, size.height), paint);
    canvas.drawLine(Offset(20, size.height), Offset(0, size.height / 2), paint);
    canvas.drawLine(Offset(0, size.height / 2), Offset(20, 0), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class WeirdTextField extends StatelessWidget {
  WeirdTextField(
      {this.hintText, this.obscureText, this.controller, this.onTap});

  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: WeirdTextFieldPainter(),
        child: TextField(
          obscureText: this.obscureText == true,
          controller: this.controller,
          onTap: this.onTap,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: "EncodeSans",
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: this.hintText,
            hintStyle: TextStyle(
              color: Colors.cyan.shade100,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: "EncodeSans",
            ),
            contentPadding: EdgeInsets.only(left: 24, right: 24),
          ),
        ),
      ),
    );
  }
}

class WeirdButtonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.strokeWidth = 2;
    paint.strokeCap = StrokeCap.round;
    paint.color = Colors.cyan.shade500;

    final path = Path();
    path
      ..lineTo(0, 0)
      ..lineTo(20, 36)
      ..lineTo(80, 36)
      ..lineTo(100, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class WeirdAuthButton extends StatelessWidget {
  const WeirdAuthButton({Key key, this.onTap, this.child}) : super(key: key);

  final onTap, child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WeirdButtonPainter(),
      child: GestureDetector(
        child: Container(
          height: 36,
          width: 100,
          child: Center(
            child: child,
          ),
        ),
        onTap: this.onTap,
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  static const routeName = "/Login";

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String rocketAnimation = 'idle', msgToUser = '';
  bool isLoading = false;

  void showLoadingSpinner() {
    setState(() {
      isLoading = true;
    });
  }

  void hideLoadingSpinner() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FlareActor(
            'lib/assets/flares/LoginPage.flr',
            animation: rocketAnimation,
            fit: BoxFit.cover,
          ),
          ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.64,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    WeirdTextField(
                      hintText: "Email",
                      controller: _emailController,
                    ),
                    WeirdTextField(
                      hintText: "Password",
                      obscureText: true,
                      controller: _passwordController,
                    ),
                    WeirdAuthButton(
                      child: isLoading
                          ? SizedBox(
                              child: CircularProgressIndicator(),
                              height: 20,
                              width: 20,
                            )
                          : Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: "EncodeSans",
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                      onTap: () async {
                        FirebaseAuth _auth = FirebaseAuth.instance;

                        String email = _emailController.text,
                            password = _passwordController.text;

                        if (email.trim() == '' || password.trim() == '') {
                          setState(() {
                            rocketAnimation = 'fail';
                            msgToUser = "Fill all the details";
                          });
                          return null;
                        }

                        showLoadingSpinner();

                        try {
                          await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                        } on PlatformException {
                          setState(() {
                            msgToUser = "Invalid Credentials!";
                            rocketAnimation = 'fail';
                            isLoading = false;
                          });
                          return null;
                        }

                        if (this.mounted) {
                          setState(() {
                            rocketAnimation = 'success';
                          });
                        }
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('loggedOut', false);
                        Timer(
                          Duration(seconds: 4),
                          () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => MyApp(),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.18,
                child: Center(
                  child: msgToUser != ''
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red.shade300,
                          ),
                          padding: EdgeInsets.all(6),
                          child: Text(
                            msgToUser,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : Container(),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.10,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Not a registered user, ",
                        style: TextStyle(
                          color: Colors.cyan.shade900,
                          fontFamily: 'Quicksand',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontFamily: 'Quicksand',
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
