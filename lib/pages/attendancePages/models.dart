class attendanceModel {
  String facultyName;
  String noOfExcuses;
  String noOfAbsent;
  String noOfPresent;
  String subject;
  String totalNoOfDays;
  String totalPercentage;
  String totalPercentageWithExcuses;

  attendanceModel(
      {this.facultyName,
      this.noOfExcuses,
      this.noOfAbsent,
      this.noOfPresent,
      this.subject,
      this.totalNoOfDays,
      this.totalPercentage,
      this.totalPercentageWithExcuses});

  attendanceModel.fromJson(Map<String, dynamic> json) {
    facultyName = json['Faculty Name'];
    noOfExcuses = json['No. of Excuses'];
    noOfAbsent = json['No.of Absent'];
    noOfPresent = json['No.of Present'];
    subject = json['Subject'];
    totalNoOfDays = json['Total No. of Days'];
    totalPercentage = json['Total Percentage'];
    totalPercentageWithExcuses = json['Total Percentage with Excuses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Faculty Name'] = this.facultyName;
    data['No. of Excuses'] = this.noOfExcuses;
    data['No.of Absent'] = this.noOfAbsent;
    data['No.of Present'] = this.noOfPresent;
    data['Subject'] = this.subject;
    data['Total No. of Days'] = this.totalNoOfDays;
    data['Total Percentage'] = this.totalPercentage;
    data['Total Percentage with Excuses'] = this.totalPercentageWithExcuses;
    return data;
  }
}
