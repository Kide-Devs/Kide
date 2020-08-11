import 'dart:async';

import 'package:Kide/pages/Auth/Login.dart';
import 'package:Kide/util/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordResetPage extends StatefulWidget {
  PasswordResetPage({this.emailController});

  final emailController;

  @override
  State<StatefulWidget> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController _emailController = TextEditingController();

  String rocketAnimation = 'idle', msgToUser = '';
  bool isLoading = false, hasSentOobCode = false;

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
                      hintText: "Recovery Email",
                      controller: widget.emailController != null
                          ? widget.emailController
                          : _emailController,
                    ),
                    WeirdAuthButton(
                      child: isLoading
                          ? SizedBox(
                              child: CircularProgressIndicator(),
                              height: 20,
                              width: 20,
                            )
                          : Text(
                              "Reset",
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: "EncodeSans",
                                fontWeight: FontWeight.w600,
                                color: AUTH_SUBMIT_COLOR,
                              ),
                            ),
                      onTap: () async {
                        FirebaseAuth _auth = FirebaseAuth.instance;
                        String email = widget.emailController != null
                            ? widget.emailController.text
                            : _emailController.text;

                        if (email.trim() == '') {
                          setState(() {
                            rocketAnimation = 'fail';
                            msgToUser = "Specify recovery email!";
                          });
                          return null;
                        }

                        showLoadingSpinner();
                        try {
                          await _auth.sendPasswordResetEmail(email: email);
                        } on PlatformException catch (e) {
                          print("Error Code:");
                          print(e.code);
//                          if (e.code == 'ERROR_WEAK_PASSWORD') {
//                            setState(() {
//                              msgToUser = "Password at least 6 chars!";
//                              rocketAnimation = 'fail';
//                              isLoading = false;
//                            });
//                          }
//                          return null;
                        }
                        Navigator.of(context).pop();
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
                            color: AUTH_ERROR_BUBBLE_BG,
                          ),
                          padding: EdgeInsets.all(6),
                          child: Text(
                            msgToUser,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AUTH_ERROR_BUBBLE_COLOR,
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
                  child: GestureDetector(
                    child: Text(
                      "Go Back",
                      style: TextStyle(
                        color: AUTH_MODE_SWITCH_COLOR,
                        fontFamily: 'Quicksand',
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
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
