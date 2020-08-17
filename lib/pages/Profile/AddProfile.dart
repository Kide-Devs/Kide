import 'dart:async';

import 'package:Kide/pages/Auth/Login.dart';
import 'package:Kide/pages/OnBoarding/OnBoarding.dart';
import 'package:Kide/util/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class AddProfile extends StatefulWidget {
  @override
  _AddProfileState createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  String uid;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((value) {
      setState(() {
        uid = value.uid;
      });
    });
  }

  final TextEditingController _rollController = TextEditingController();
  final TextEditingController _cgpaController = TextEditingController();
  final TextEditingController _batchController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();

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
                      hintText: "Roll",
                      controller: _rollController,
                    ),
                    WeirdTextField(
                      hintText: "CGPA",
                      controller: _cgpaController,
                    ),
                    WeirdTextField(
                      hintText: "Batch",
                      controller: _batchController,
                    ),
                    WeirdTextField(
                      hintText: "Branch",
                      controller: _branchController,
                    ),
                    WeirdAuthButton(
                      child: isLoading
                          ? SizedBox(
                              child: CircularProgressIndicator(),
                              height: 20,
                              width: 20,
                            )
                          : Text(
                              "Continue",
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: "EncodeSans",
                                fontWeight: FontWeight.w600,
                                color: AUTH_SUBMIT_COLOR,
                              ),
                            ),
                      onTap: () async {
                        if (_rollController.text.trim() == '' ||
                            _cgpaController.text.trim() == '' ||
                            _branchController.text.trim() == '' ||
                            _batchController.text.trim() == '') {
                          setState(() {
                            rocketAnimation = 'fail';
                            msgToUser = "Fill all the details";
                          });
                          return null;
                        }
                        showLoadingSpinner();

                        setState(() {
                          rocketAnimation = 'success';
                        });
                        await Firestore.instance
                            .collection('userInfo')
                            .document(uid)
                            .updateData({
                              "batch": _batchController.text,
                              "branch": _branchController.text,
                              "cgpa": _cgpaController.text,
                              "roll": _rollController.text,
                        });
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Already a user, ",
                        style: TextStyle(
                          color: AUTH_MODE_SWITCH_INFO_COLOR,
                          fontFamily: 'Quicksand',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: AUTH_MODE_SWITCH_COLOR,
                            fontFamily: 'Quicksand',
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
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
