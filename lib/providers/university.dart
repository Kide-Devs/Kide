import 'package:flutter/material.dart';

class University with ChangeNotifier{
  String _university = "Select University";

  String get university {
    return _university;
  }

  void setUniversity( String univ ) {
    _university = univ;
    notifyListeners();
  }
  void unsetUniversity() {
    _university = "Select University";
    notifyListeners();
  }
}