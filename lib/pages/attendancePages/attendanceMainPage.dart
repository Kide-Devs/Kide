import 'dart:convert';

import 'package:Kide/pages/attendancePages/models.dart';
import 'package:Kide/pages/attendancePages/sapCredForm.dart';
import 'package:Kide/util/colors.dart';
import 'package:Kide/util/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
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
      Map map = {"roll_no": email.split('@')[0], "password": password};
      var ans = jsonEncode(map);
      var body = await http.post(
          ATTENDANCE_API_URL,
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
      print("Overall : " + "$overall");
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
      // appBar: AppBar(
      //   title: new Text(
      //     "ATTENDANCE",
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontFamily: "Michroma",
      //       fontWeight: FontWeight.w300,
      //       fontSize: 23,
      //     ),
      //   ),
      //   centerTitle: true,
      //   backgroundColor:
      //       REALLY_NOSTALGIC_BLUE_BG, // DynamicTheme.of(context).data.backgroundColor,
      // ),
      backgroundColor: REALLY_NOSTALGIC_BLUE_BG,
      // DynamicTheme.of(context).data.backgroundColor,
      body: _isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
            )
          : _isError == true
              ? SapCredForm()
              : Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(12),
                    children: [
                      Card(
                        color: Colors.transparent,
                        shadowColor: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('EEEE').format(date),
                                style: TextStyle(
                                    fontFamily: "Quicksand",
                                    color: Colors.white),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${date.day}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 34,
                                        ),
                                      ),
                                      Text(
                                        date.day % 10 == 1
                                            ? "st"
                                            : date.day % 10 == 2 ? "nd" : "th",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${DateFormat(" MMM, yyyy").format(date)}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 26,
                                      fontFamily: "Quicksand",
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
//                          child: ListTile(
//                            title:
//                            subtitle:
//                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Overall Attendance",
                          style: TextStyle(
                            fontSize: 21,
                            fontFamily: "Quicksand",
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.blue[400].withOpacity(0.2),
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
                                      top: 78,
                                      bottom: 0,
                                      left: 72,
                                      child: Text(
                                        "${overall.toStringAsFixed(1)}%",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
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
                                              color: NOSTALGIC_GREEN,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                        ),
                                        title: Text(
                                          "Attended",
                                          style: TextStyle(
                                            fontFamily: "Quicksand",
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
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
                                              color: NOSTALGIC_RED,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                        ),
                                        title: Text(
                                          "Skipped",
                                          style: TextStyle(
                                            fontFamily: "Quicksand",
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                             overall >= 75.00 ? RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Phewwww....You\'re',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Quicksand",
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' Safe',
                                    style: TextStyle(
                                      color: NOSTALGIC_GREEN,
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' !',
                                  ),
                                ],
                              ),
                            ):RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'you\'re in',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Quicksand",
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' danger',
                                    style: TextStyle(
                                      color: NOSTALGIC_RED,
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
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
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(width: 1, color: Colors.grey)),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(children: [
            Text(
              total,
              style: TextStyle(
                fontSize: 21,
                fontFamily: "Quicksand",
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Text(
              "Total",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Quicksand",
                color: Colors.white,
              ),
            )
          ]),
          Container(
            height: 48,
            width: 2,
            margin: EdgeInsets.symmetric(vertical: 12),
            color: Colors.grey,
          ),
          Column(children: [
            Text(
              attended,
              style: TextStyle(
                fontSize: 21,
                fontFamily: "Quicksand",
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Text(
              "Attended",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Quicksand",
                color: Colors.white,
              ),
            )
          ]),
          Container(
            height: 48,
            width: 2,
            margin: EdgeInsets.symmetric(vertical: 12),
            color: Colors.grey,
          ),
          Column(children: [
            Text(
              skipped,
              style: TextStyle(
                fontSize: 21,
                fontFamily: "Quicksand",
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Text(
              "Skipped",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Quicksand",
                color: Colors.white,
              ),
            )
          ])
        ],
      ),
    );
  }

  subjectCards(title, percentage, teacher) {
    return Padding(
      padding: EdgeInsets.only(top: 12),
      child: Card(
        color: Colors.transparent,
        shadowColor: Colors.lightBlueAccent[100].withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(
                fontFamily: "Quicksand",
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            trailing: Text(
              percentage.toString() + "%",
              style: TextStyle(
                fontFamily: "Quicksand",
                color: percentage < 75 ? NOSTALGIC_RED : NOSTALGIC_GREEN,
                fontSize: 18,
              ),
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
                          percentage < 75 ? NOSTALGIC_RED : NOSTALGIC_GREEN),
                      backgroundColor: Colors.transparent,
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
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
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
              color: NOSTALGIC_GREEN,
              value: overall,
              radius: radius,
              showTitle: false);
        case 1:
          return PieChartSectionData(
              color: NOSTALGIC_RED,
              value: 100 - overall,
              radius: radius,
              showTitle: false);

        default:
          return null;
      }
    });
  }
}
