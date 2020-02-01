import 'package:flutter/foundation.dart';

class SubEvent {
  final String id;
  final String name;
  final String date;
  final String time;
  final String description;
  final String location;
  final String linkDetails;
  final String linkRegister;
  bool isBookmarked;

  SubEvent({
    @required this.id,
    @required this.name,
    @required this.date,
    @required this.time,
    this.description,
    @required this.location,
    @required this.linkDetails,
    @required this.linkRegister,
    this.isBookmarked,
  });
}