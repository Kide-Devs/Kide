import 'dart:ui';

import 'package:Kide/util/constants.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';

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
    paint.color = Colors.cyan.shade600;

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
  const WeirdAuthButton({Key key, this.onTap}) : super(key: key);

  final onTap;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WeirdButtonPainter(),
      child: GestureDetector(
        child: Container(
          height: 36,
          width: MediaQuery.of(context).size.width * 0.25,
          child: Center(
            child: Text(
              "Login",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "EncodeSans",
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
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

  String gussAnimation = 'idle';
  int inputSelection = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.indigo],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 20),
                height: MediaQuery.of(context).size.height * 0.20,
                child: Center(
                  child: Image.asset(
                    MAIN_KIDE_LOGO,
                    gaplessPlayback: true,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                KIDE_CAPS,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "Michroma",
                  color: Colors.white,
                  letterSpacing: 20.0,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: FlareActor(
                        'lib/assets/flares/Guss.flr',
                        animation: gussAnimation,
                        callback: (name) {
                          setState(() {
                            if (gussAnimation == 'cover_eyes_in' &&
                                inputSelection != 2) {
                              gussAnimation = 'cover_eyes_out';
                            } else if (gussAnimation == 'cover_eyes_in' &&
                                inputSelection == 2) {
                            } else {
                              gussAnimation = 'idle';
                            }
                          });
                        },
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          WeirdTextField(
                            hintText: "Email",
                            controller: _emailController,
                            onTap: () => setState(() {
                              inputSelection = 1;
                              if (gussAnimation == 'cover_eyes_in' &&
                                  inputSelection != 2) {
                                gussAnimation = 'cover_eyes_out';
                              }
                            }),
                          ),
                          WeirdTextField(
                            hintText: "Password",
                            obscureText: true,
                            controller: _passwordController,
                            onTap: () => setState(() {
                              inputSelection = 2;
                              gussAnimation = 'cover_eyes_in';
                            }),
                          ),
                          WeirdAuthButton(onTap: () {
                            setState(() {
                              if (_emailController.text.trim() != '' &&
                                  _passwordController.text.trim() != '') {
                                gussAnimation = 'success';
                              } else {
                                gussAnimation = 'fail';
                              }
                            });


                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
