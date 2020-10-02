import 'package:flutter/material.dart';

class BottomNavRouter with ChangeNotifier{
  int _bottomNavIndex = 2;

  int get bottomNavIndex {
    return _bottomNavIndex;
  }

  void setIndex(idx) {
    _bottomNavIndex = idx;
    notifyListeners();
  }
}