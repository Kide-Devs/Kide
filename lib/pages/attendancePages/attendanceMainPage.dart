import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceMainPage extends StatefulWidget {
  @override
  _AttendanceMainPageState createState() => _AttendanceMainPageState();
}

class _AttendanceMainPageState extends State<AttendanceMainPage> {
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(12),
          children: [
            Card(
                color: DynamicTheme.of(context).data.scaffoldBackgroundColor,
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
                                        touchCallback: (pieTouchResponse) {
                                      setState(() {
                                        if (pieTouchResponse.touchInput
                                                is FlLongPressEnd ||
                                            pieTouchResponse.touchInput
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
                              left: 80,
                              child: Text(
                                "80%",
                                style: TextStyle(fontSize: 20),
                              )),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 180,
                            height: 35,
                            child: ListTile(
                              leading: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.greenAccent[700],
                                    borderRadius: BorderRadius.circular(40)),
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
                            width: 180,
                            height: 45,
                            child: ListTile(
                              leading: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.redAccent[400],
                                    borderRadius: BorderRadius.circular(40)),
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
            _middlePage("200", "140", "60"),
            ListTile(
              leading: Text(
                "Subjects",
                style: TextStyle(
                  fontSize: 21,
                  fontFamily: "Quicksand",
                ),
              ),
            ),
            subjectCards("Computer Networks", 80.0, "Bhaswati Sahoo"),
            SizedBox(
              height: 10,
            ),
            subjectCards("Computer Intelligence", 23.0, "Chandrani Kumar"),
            SizedBox(
              height: 10,
            ),
            subjectCards("Design and Analysis of Algorithm", 90.0,
                "Nachiketa Tarasaria"),
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
    return Card(
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
              color: percentage < 70 ? Colors.red : Colors.green,
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
                      percentage < 70 ? Colors.red : Colors.green),
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
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final double radius = 30;
      switch (i) {
        case 0:
          return PieChartSectionData(
              color: Colors.greenAccent[700],
              value: 80,
              radius: radius,
              showTitle: false);
        case 1:
          return PieChartSectionData(
              color: Colors.redAccent[400],
              value: 20,
              radius: radius,
              showTitle: false);

        default:
          return null;
      }
    });
  }
}
