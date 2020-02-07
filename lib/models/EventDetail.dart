import 'package:flutter/foundation.dart';

class EventDetail {
  final String id;
  final String header;
  final String desc;
  EventDetail({
    @required this.id,
    @required this.header,
    @required this.desc,
  });
}