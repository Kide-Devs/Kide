import 'dart:convert';

import 'package:Kide/pages/attendancePages/models.dart';
import 'package:Kide/pages/attendancePages/sapCredForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceMainPage extends StatefulWidget {
  @override
  _AttendanceMainPageState createState() => _AttendanceMainPageState();
}

class _AttendanceMainPageState extends State<AttendanceMainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAttendance();
  }

  bool _isLoading = true;
  List<attendanceModel> attendanceDetails = [];
  double overall = 0.0;
  double attended = 0.0;
  double total = 0;
  String errormsg = '';
  bool _isError = false;
  void fetchAttendance() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String email = _prefs.getString('email');
      String password = _prefs.getString('password');
      if (email == null) {
        FirebaseAuth.instance.currentUser().then((value) async {
          await Firestore.instance
              .collection('userInfo')
              .document(value.uid)
              .get()
              .then((data) => {
                    email = data.data['Sapemail'],
                    password = data.data['Sappassword']
                  });
        });
      }
      print(email);
      print(password);
      Map map = {"roll_no": email.split('@')[0], "password": password};
      var ans = jsonEncode(map);
      var body = await http.post(
          'https://kide-api.herokuapp.com/api/attendance',
          body: ans,
          headers: {"Content-Type": "application/json"});
      var bd = jsonDecode(body.body);
      List attendance = bd;
      print(attendance.length);
      for (int i = 0; i < attendance.length; i++) {
        attendanceDetails.add(attendanceModel.fromJson(attendance[i]));
        overall += double.parse(attendanceDetails[i].totalPercentage);
        total += double.parse(attendanceDetails[i].totalNoOfDays);
        attended += double.parse(attendanceDetails[i].noOfPresent);
      }
      attendanceDetails = attendanceDetails.toSet().toList();
      print(attendanceDetails[0].facultyName);
      overall = overall / (attendanceDetails.length);
      print("Overall : " + "${overall}");
      _isLoading = false;
      setState(() {});
    } catch (e) {
      _isError = true;

      _isLoading = false;
      setState(() {});
      print(e.toString());
    }
  }

  var date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          "ATTENDANCE",
          style: TextStyle(
            color: DynamicTheme.of(context).data.textTheme.subtitle1.color,
            fontFamily: "Michroma",
            fontWeight: FontWeight.w300,
            fontSize: 23,
          ),
        ),
        centerTitle: true,
        backgroundColor: DynamicTheme.of(context).data.backgroundColor,
      ),
      backgroundColor: DynamicTheme.of(context).data.backgroundColor,
      body: _isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
            )
          : _isError == true
              ? sapCredForm()
              : Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(12),
                    children: [
                      Card(
                          color: DynamicTheme.of(context)
                              .data
                              .scaffoldBackgroundColor,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(
                                  DateFormat('EEEE').format(date),
                                  style: TextStyle(
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                                subtitle: Text(
                                  DateFormat('d  MMM, yyyy').format(date),
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.w600),
                                ),
                              ))),
                      ListTile(
                        title: Text(
                          "Overall Attendance",
                          style: TextStyle(
                            fontSize: 21,
                            fontFamily: "Quicksand",
                          ),
                        ),
                      ),
                      Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                      height: 180,
                                      width: 190,
                                      child: AspectRatio(
                                        aspectRatio: 0.1,
                                        child: PieChart(
                                          PieChartData(
                                              pieTouchData: PieTouchData(
                                                  touchCallback:
                                                      (pieTouchResponse) {
                                                setState(() {
                                                  if (pieTouchResponse
                                                              .touchInput
                                                          is FlLongPressEnd ||
                                                      pieTouchResponse
                                                              .touchInput
                                                          is FlPanEnd) {
                                                  } else {}
                                                });
                                              }),
                                              borderData: FlBorderData(
                                                show: false,
                                              ),
                                              sectionsSpace: 0,
                                              centerSpaceRadius: 38,
                                              sections: showingSections()),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top: 75,
                                        bottom: 0,
                                        left: 72,
                                        child: Text(
                                          "${overall.toString().substring(0, 4)}%",
                                          style: TextStyle(fontSize: 18),
                                        )),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 170,
                                      height: 35,
                                      child: ListTile(
                                        leading: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: Colors.greenAccent[700],
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                        ),
                                        title: Text(
                                          "Attended",
                                          style: TextStyle(
                                            fontFamily: "Quicksand",
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 170,
                                      height: 45,
                                      child: ListTile(
                                        leading: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: Colors.redAccent[400],
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                        ),
                                        title: Text(
                                          "Skipped",
                                          style: TextStyle(
                                            fontFamily: "Quicksand",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Phewwww....You\'re',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Quicksand",
                                      )),
                                  TextSpan(
                                      text: ' Safe',
                                      style: TextStyle(
                                        color: Colors.lightGreenAccent,
                                        fontFamily: "Quicksand",
                                      )),
                                  TextSpan(
                                    text: ' !',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _middlePage(
                          "${total.toString()}",
                          "${attended.toString()}",
                          "${(total - attended).toString()}"),
                      ListTile(
                        leading: Text(
                          "Subjects",
                          style: TextStyle(
                            fontSize: 21,
                            fontFamily: "Quicksand",
                          ),
                        ),
                      ),
                      for (int i = 0; i < attendanceDetails.length; i++)
                        subjectCards(
                            attendanceDetails[i].subject,
                            double.parse(attendanceDetails[i].totalPercentage),
                            attendanceDetails[i].facultyName),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
    );
  }

  _middlePage(total, attended, skipped) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(children: [
            Text(
              total,
              style: TextStyle(
                fontSize: 21,
                fontFamily: "Quicksand",
              ),
            ),
            Text(
              "Total",
              style: TextStyle(
                fontSize: 21,
                fontFamily: "Quicksand",
              ),
            )
          ]),
          Container(height: 80, child: VerticalDivider(color: Colors.black)),
          Column(children: [
            Text(
              attended,
              style: TextStyle(
                fontSize: 21,
                fontFamily: "Quicksand",
              ),
            ),
            Text(
              "Attended",
              style: TextStyle(
                fontSize: 21,
                fontFamily: "Quicksand",
              ),
            )
          ]),
          Container(height: 80, child: VerticalDivider(color: Colors.black)),
          Column(children: [
            Text(
              skipped,
              style: TextStyle(
                fontSize: 21,
                fontFamily: "Quicksand",
              ),
            ),
            Text(
              "Skipped",
              style: TextStyle(
                fontSize: 21,
                fontFamily: "Quicksand",
              ),
            )
          ])
        ],
      ),
    );
  }

  subjectCards(title, percentage, teacher) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Card(
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontFamily: "Quicksand",
            ),
          ),
          trailing: Text(
            percentage.toString() + "%",
            style: TextStyle(
                fontFamily: "Quicksand",
                color: percentage < 75 ? Colors.red : Colors.green,
                fontSize: 18),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: LinearProgressIndicator(
                    minHeight: 6.2,
                    value: percentage / 100,
                    valueColor: AlwaysStoppedAnimation(
                        percentage < 75 ? Colors.red : Colors.green),
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                teacher,
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: "Quicksand",
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final double radius = 30;
      switch (i) {
        case 0:
          return PieChartSectionData(
              color: Colors.greenAccent[700],
              value: overall,
              radius: radius,
              showTitle: false);
        case 1:
          return PieChartSectionData(
              color: Colors.redAccent[400],
              value: 100 - overall,
              radius: radius,
              showTitle: false);

        default:
          return null;
      }
    });
  }
}
