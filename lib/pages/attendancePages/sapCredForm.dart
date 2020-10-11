import 'package:Kide/pages/Auth/Login.dart';
import 'package:Kide/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'attendanceMainPage.dart';

class SapCredForm extends StatefulWidget {
  // SapCredForm({this.emailController});

  // final TextEditingController emailController;

  static const routeName = "/Login";

  @override
  State<StatefulWidget> createState() {
    return _SapCredFormState();
  }
}

class _SapCredFormState extends State<SapCredForm> {
  final TextEditingController _rollController = TextEditingController();
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
                      hintText: "Sap Roll",
                      controller: _rollController,
                      //  widget.emailController == null
                      //     ? _rollController
                      //     : widget.emailController,
                    ),
                    WeirdTextField(
                      hintText: "Sap Password",
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
                                "Sap Login",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "EncodeSans",
                                  fontWeight: FontWeight.w600,
                                  color: AUTH_SUBMIT_COLOR,
                                ),
                              ),
                        onTap: () async {
                          SharedPreferences _prefs =
                              await SharedPreferences.getInstance();

                          // String email = widget.emailController != null
                          //         ? widget.emailController.text
                          //         : _rollController.text,
                          String password = _passwordController.text;
                          String rollsave = _rollController.text;

                          if (_rollController.text.trim() == '' ||
                              password.trim() == '') {
                            setState(() {
                              msgToUser = "Fill all the details";
                            });
                            return null;
                          }

                          _prefs.setString("password", password);
                          _prefs.setString("roll", rollsave);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AttendanceMainPage(),
                            ),
                          );
                        }),
                    SizedBox(height: 10),
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
            ],
          ),
        ],
      ),
    );
  }
}
