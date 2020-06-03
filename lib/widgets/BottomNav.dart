import 'package:dynamic_theme/dynamic_theme.dart';
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
      currentIndex: _currentIndex,
      unselectedIconTheme: IconThemeData(
        color: DynamicTheme.of(context).data.textTheme.subtitle.color
      ),
      selectedIconTheme: IconThemeData(
        color: Colors.blueAccent
      ),
      backgroundColor: DynamicTheme.of(context).data.backgroundColor,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text(
            MAPS,
            style: TextStyle(
              fontSize: 12.0,
              color: DynamicTheme.of(context).data.textTheme.subtitle.color
            ),
          ),
          backgroundColor: DynamicTheme.of(context).data.backgroundColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.perm_contact_calendar),
          title: Text(
            CONTACTS,
            style: TextStyle(
              fontSize: 12.0,
              color: DynamicTheme.of(context).data.textTheme.subtitle.color
            ),
          ),
          backgroundColor: DynamicTheme.of(context).data.backgroundColor,
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
          title: Container(),
          backgroundColor: DynamicTheme.of(context).data.backgroundColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pin_drop),
          title: Text(
            "For You",
            style: TextStyle(
              fontSize: 12.0,
              color: DynamicTheme.of(context).data.textTheme.subtitle.color
            ),
          ),
          backgroundColor: DynamicTheme.of(context).data.backgroundColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          title: Text(
            MORE,
            style: TextStyle(
              fontSize: 12.0,
              color: DynamicTheme.of(context).data.textTheme.subtitle.color
            ),
          ),
          backgroundColor: DynamicTheme.of(context).data.backgroundColor,
        ),
      ],
      onTap: (index) {
        indexState.setIndex(index);
      },
    );
  }
}
