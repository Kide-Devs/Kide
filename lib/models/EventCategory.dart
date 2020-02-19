import 'package:flutter/foundation.dart';
import 'package:Kide/models/SubEvent.dart';

class EventCategory {
  final int id;
  final String name;
  final List<SubEvent> subEvents;
  EventCategory({
    @required this.id,
    @required this.name,
    @required this.subEvents
  });
}