import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kide/assets/Icon/custom_icons_icons.dart';
import '../providers/router.dart';
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
            'Maps',
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
          backgroundColor: Colors.black87,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.perm_contact_calendar),
          title: Text(
            'Contacts',
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
              "./lib/assets/Icon/kide_logoldpi.png",
              width: _currentIndex == 2 ? 34 : 28,
              height: _currentIndex == 2 ? 34 : 28,
            ),
          ),
          title: Text(
            'KIDE',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 5.0, letterSpacing: 5),
          ),
          backgroundColor: Colors.black87,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event_note),
          title: Text(
            'Events',
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
          backgroundColor: Colors.black87,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          title: Text(
            'More',
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
