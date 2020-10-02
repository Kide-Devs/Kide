import 'package:Kide/models/EventCategory.dart';
import 'package:flutter/foundation.dart';

class Event {
  final String id;
  final String name;
  final String startDate;
  final String endDate;
  final List<EventCategory> eventCategories;
  Event({
    @required this.id,
    @required this.name,
    @required this.startDate,
    @required this.endDate,
    @required this.eventCategories
  });
}