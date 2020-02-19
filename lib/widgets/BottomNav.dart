import 'package:flutter/material.dart';
import 'package:Kide/util/constants.dart';
import 'package:Kide/providers/router.dart';
import "package:provider/provider.dart";

class BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final indexState = Provider.of<Router>(context);
    final int _currentIndex = indexState.bottomNavIndex;

    return BottomNavigationBar(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedIconTheme: IconThemeData(
        size: 36,
        color: Color.fromRGBO(0, 112, 240, 100),
      ),
      currentIndex: _currentIndex,
      backgroundColor: Colors.black87,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text(
            MAPS,
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
          backgroundColor: Colors.black87,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.perm_contact_calendar),
          title: Text(
            CONTACTS,
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
          backgroundColor: Colors.black87,
        ),
        BottomNavigationBarItem(
          icon: AnimatedContainer(
            duration: Duration(milliseconds: 350),
            child: Image.asset(
              MAIN_KIDE_LOGO,
              width: _currentIndex == 2 ? 34 : 28,
              height: _currentIndex == 2 ? 34 : 28,
            ),
          ),
          title: Text(
            KIDE_CAPS,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 5.0, letterSpacing: 5),
          ),
          backgroundColor: Colors.black87,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pin_drop),
          title: Text(
            "For You",
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
          backgroundColor: Colors.black87,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          title: Text(
            MORE,
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
          backgroundColor: Colors.black87,
        ),
      ],
      onTap: (index) {
        indexState.setIndex(index);
      },
    );
  }
}
