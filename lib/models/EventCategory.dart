import 'package:flutter/foundation.dart';
import 'package:kide/models/SubEvent.dart';

class EventCategory {
  final String id;
  final String name;
  final List<SubEvent> subEvents;
  EventCategory({
    @required this.id,
    @required this.name,
    @required this.subEvents
  });
}