import 'package:flutter/foundation.dart';

class Contact {
  final String id;
  final String name;
  final String designation;
  final String number;
  Contact({
    @required this.id,
    @required this.name,
    @required this.designation,
    @required this.number,
  });
}