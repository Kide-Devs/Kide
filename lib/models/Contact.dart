import 'package:flutter/foundation.dart';

class Contact {
  final String id;
  final String name;
  final String designation;
  final String phone;
  final String gender;
  Contact({
    @required this.id,
    @required this.name,
    @required this.designation,
    @required this.phone,
    @required this.gender
  });
}