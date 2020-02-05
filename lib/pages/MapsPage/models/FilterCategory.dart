import 'package:flutter/material.dart';

class FilterCategory {
  String label;
  IconData icon;
  bool isToggled;
  FilterCategory(this.label, this.icon, {this.isToggled=false});

  void toggle () {
    isToggled = !isToggled;
  }
}