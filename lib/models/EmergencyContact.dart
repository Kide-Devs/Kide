import 'package:flutter/material.dart';

class EmergencyContact {
  final Color color;
  final IconData icon;
  final String emergency;
  final String number;
  EmergencyContact({
    @required this.color,
    @required this.icon,
    @required this.emergency,
    @required this.number,
  });
}