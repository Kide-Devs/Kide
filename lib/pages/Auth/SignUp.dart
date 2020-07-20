import 'dart:async';

import 'package:Kide/pages/OnBoarding/OnBoarding.dart';
import 'package:Kide/util/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
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
            callback: (name) {
              if (name == 'success') {
                setState(() {
                  rocketAnimation = "after_success";
                });
              }
            },
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
                      hintText: "Full Name",
                      controller: _nameController,
                    ),
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
                              "Sign Up",
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
                            password = _passwordController.text,
                            fullName = _nameController.text;
                        if (email.trim() == '' ||
                            password.trim() == '' ||
                            fullName.trim() == '') {
                          setState(() {
                            rocketAnimation = 'fail';
                            msgToUser = "Fill all the details";
                          });
                          return null;
                        }

                        showLoadingSpinner();
                        var _result;
                        try {
                          _result = await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                        } on PlatformException catch (e) {
                          print("Registration Error Code:");
                          print(e.code);
                          if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
                            setState(() {
                              msgToUser = "Email already registered!";
                              rocketAnimation = 'fail';
                              isLoading = false;
                            });
                          } else if (e.code == 'ERROR_WEAK_PASSWORD') {
                            setState(() {
                              msgToUser = "Password at least 6 chars!";
                              rocketAnimation = 'fail';
                              isLoading = false;
                            });
                          }
                          return null;
                        }

                        setState(() {
                          rocketAnimation = 'success';
                        });
                        await Firestore.instance
                            .collection('userInfo')
                            .document(_result.user.uid)
                            .setData({
                          "fullName": fullName,
                          "email": email,
                        });
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('loggedOut', false);
                        Timer(
                          Duration(seconds: 4),
                          () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => OnboardingMainPage(),
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
                        "Already a user, ",
                        style: TextStyle(
                          color: Colors.cyan.shade900,
                          fontFamily: 'Quicksand',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          "Sign In",
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
//      body: Stack(
//        children: <Widget>[
//          Container(
//            width: MediaQuery.of(context).size.width,
//            height: MediaQuery.of(context).size.height,
//            decoration: BoxDecoration(
//              gradient: LinearGradient(
//                colors: [Colors.black, Colors.indigo],
//                begin: Alignment.bottomCenter,
//                end: Alignment.topCenter,
//              ),
//            ),
//          ),
//          ListView(
//            physics: BouncingScrollPhysics(),
//            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
//            children: <Widget>[
//              Container(
//                padding: EdgeInsets.only(bottom: 20),
//                height: MediaQuery.of(context).size.height * 0.20,
//                child: Center(
//                  child: Image.asset(
//                    MAIN_KIDE_LOGO,
//                    gaplessPlayback: true,
//                    fit: BoxFit.contain,
//                  ),
//                ),
//              ),
//              Text(
//                KIDE_CAPS,
//                textAlign: TextAlign.center,
//                style: TextStyle(
//                  fontSize: 20.0,
//                  fontFamily: "Michroma",
//                  color: Colors.white,
//                  letterSpacing: 20.0,
//                ),
//              ),
//              Container(
//                height: MediaQuery.of(context).size.height * 0.6,
//                child: Stack(
//                  children: <Widget>[
//                    Padding(
//                      padding: EdgeInsets.only(top: 20, bottom: 20),
//                      child: FlareActor(
//                        'lib/assets/flares/Guss.flr',
//                        animation: gussAnimation,
//                        callback: (name) {
//                          setState(() {
//                            if (gussAnimation == 'cover_eyes_in' &&
//                                inputSelection != 2) {
//                              gussAnimation = 'cover_eyes_out';
//                            } else if (gussAnimation == 'cover_eyes_in' &&
//                                inputSelection == 2) {
//                            } else {
//                              gussAnimation = 'idle';
//                            }
//                          });
//                        },
//                      ),
//                    ),
//                    Center(
//                      child: Column(
//                        mainAxisSize: MainAxisSize.min,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: <Widget>[
//                          WeirdTextField(
//                            hintText: "Full Name",
//                            controller: _nameController,
//                            onTap: () => setState(() {
//                              inputSelection = 1;
//                              if (gussAnimation == 'cover_eyes_in' &&
//                                  inputSelection != 2) {
//                                gussAnimation = 'cover_eyes_out';
//                              }
//                            }),
//                          ),
//                          WeirdTextField(
//                            hintText: "Email",
//                            controller: _emailController,
//                            onTap: () => setState(() {
//                              inputSelection = 1;
//                              if (gussAnimation == 'cover_eyes_in' &&
//                                  inputSelection != 2) {
//                                gussAnimation = 'cover_eyes_out';
//                              }
//                            }),
//                          ),
//                          WeirdTextField(
//                            hintText: "Password",
//                            obscureText: true,
//                            controller: _passwordController,
//                            onTap: () => setState(() {
//                              inputSelection = 2;
//                              gussAnimation = 'cover_eyes_in';
//                            }),
//                          ),
//                          WeirdAuthButton(
//                            child: isLoading
//                                ? SizedBox(
//                                    child: CircularProgressIndicator(),
//                                    height: 20,
//                                    width: 20,
//                                  )
//                                : Text(
//                                    "Sign Up",
//                                    style: TextStyle(
//                                      fontSize: 17,
//                                      fontFamily: "EncodeSans",
//                                      fontWeight: FontWeight.w600,
//                                      color: Colors.white,
//                                    ),
//                                  ),
//                            onTap: () async {
//                              FirebaseAuth _auth = FirebaseAuth.instance;
//
//                              String email = _emailController.text,
//                                  password = _passwordController.text,
//                                  fullName = _nameController.text;
//                              if (email.trim() == '' ||
//                                  password.trim() == '' ||
//                                  fullName.trim() == '') {
//                                setState(() {
//                                  gussAnimation = 'fail';
//                                  msgToUser = "Fill all the details";
//                                });
//                                return null;
//                              }
//
//                              showLoadingSpinner();
//                              var _result;
//                              try {
//                                _result =
//                                    await _auth.createUserWithEmailAndPassword(
//                                        email: email, password: password);
//                              } on PlatformException catch (e) {
//                                print("Registration Error Code:");
//                                print(e.code);
//                                if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
//                                  setState(() {
//                                    msgToUser = "Email already registered!";
//                                    gussAnimation = 'fail';
//                                    isLoading = false;
//                                  });
//                                } else if (e.code == 'ERROR_WEAK_PASSWORD') {
//                                  setState(() {
//                                    msgToUser = "Password at least 6 chars!";
//                                    gussAnimation = 'fail';
//                                    isLoading = false;
//                                  });
//                                }
//                                return null;
//                              }
//
//                              setState(() {
//                                gussAnimation = 'success';
//                              });
//                              await Firestore.instance
//                                  .collection('userInfo')
//                                  .document(_result.user.uid)
//                                  .setData({
//                                "fullName": fullName,
//                                "email": email,
//                              });
//                              SharedPreferences prefs =
//                                  await SharedPreferences.getInstance();
//                              prefs.setBool('loggedOut', false);
//                              Navigator.of(context)
//                                  .pushReplacement(MaterialPageRoute(
//                                builder: (context) => OnboardingMainPage(),
//                              ));
//                            },
//                          ),
//                          Padding(
//                            padding: EdgeInsets.only(top: 14, bottom: 14),
//                            child: msgToUser != ''
//                                ? Container(
//                                    decoration: BoxDecoration(
//                                      borderRadius: BorderRadius.circular(20),
//                                      color: Colors.redAccent,
//                                    ),
//                                    padding: EdgeInsets.all(6),
//                                    child: Text(
//                                      msgToUser,
//                                      textAlign: TextAlign.center,
//                                      style: TextStyle(
//                                        color: Colors.white,
//                                        fontSize: 16,
//                                        fontWeight: FontWeight.w600,
//                                      ),
//                                    ),
//                                  )
//                                : Container(),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              Center(
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    Text(
//                      "Already a user, ",
//                      style: TextStyle(
//                        color: Colors.white,
//                        fontFamily: 'Quicksand',
//                        fontSize: 16,
//                        fontWeight: FontWeight.w600,
//                      ),
//                    ),
//                    GestureDetector(
//                      child: Text(
//                        "Sign In",
//                        style: TextStyle(
//                          color: Colors.lightBlueAccent.shade100,
//                          fontFamily: 'Quicksand',
//                          fontSize: 17,
//                          fontWeight: FontWeight.w800,
//                        ),
//                      ),
//                      onTap: () {
//                        Navigator.of(context).pushReplacement(
//                          MaterialPageRoute(builder: (context) => LoginPage()),
//                        );
//                      },
//                    ),
//                  ],
//                ),
//              ),
//            ],
//          ),
//        ],
//      ),
    );
  }
}
