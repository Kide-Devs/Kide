import 'package:Kide/pages/OnBoarding/OnBoarding.dart';
import 'package:Kide/util/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Login.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String gussAnimation = 'idle', msgToUser = '';
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          WeirdTextField(
                            hintText: "Full Name",
                            controller: _nameController,
                            onTap: () => setState(() {
                              inputSelection = 1;
                              if (gussAnimation == 'cover_eyes_in' &&
                                  inputSelection != 2) {
                                gussAnimation = 'cover_eyes_out';
                              }
                            }),
                          ),
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
                          WeirdAuthButton(
                            text: "Sign Up",
                            onTap: () async {
                              FirebaseAuth _auth = FirebaseAuth.instance;

                              String email = _emailController.text,
                                  password = _passwordController.text,
                                  fullName = _nameController.text;
                              if (email.trim() == '' ||
                                  password.trim() == '' ||
                                  fullName.trim() == '') {
                                setState(() {
                                  gussAnimation = 'fail';
                                  msgToUser = "Fill all the details";
                                });
                                return null;
                              }
                              var _result;
                              try {
                                _result =
                                    await _auth.createUserWithEmailAndPassword(
                                        email: email, password: password);
                              } on PlatformException catch (e) {
                                print("Registration Error Code:");
                                print(e.code);
                                if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
                                  setState(() {
                                    msgToUser = "Email already registered!";
                                    gussAnimation = 'fail';
                                  });
                                  return null;
                                }
                              }

                              setState(() {
                                gussAnimation = 'success';
                              });
                              await Firestore.instance
                                  .collection('userInfo')
                                  .document(_result.user.uid)
                                  .setData({
                                "fullName": fullName,
                                "email": email,
                              });
                              Navigator.of(context).pushReplacementNamed(
                                  OnboardingMainPage.routeName);
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Text(
                              msgToUser,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.redAccent.shade200,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Already a user, ",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Quicksand',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.lightBlueAccent.shade100,
                          fontFamily: 'Quicksand',
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
