import 'package:Kide/providers/router.dart';
import 'package:Kide/util/constants.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import "package:provider/provider.dart";

class BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final indexState = Provider.of<BottomNavRouter>(context);
    final int _currentIndex = indexState.bottomNavIndex;
    return CurvedNavigationBar(
      height: 55,
      index: _currentIndex,
      buttonBackgroundColor: DynamicTheme.of(context).data.backgroundColor,
      color:  DynamicTheme.of(context).data.backgroundColor,
      backgroundColor: Color.fromRGBO(0, 0, 0, 0).withOpacity(0),
      onTap: (index) {
        indexState.setIndex(index);
      },
      items: <Widget>[
        Icon(
          Icons.map,
          color: DynamicTheme.of(context).data.textTheme.bodyText1.color,
        ),
        Icon(
          Icons.contacts,
          color:DynamicTheme.of(context).data.textTheme.bodyText1.color,
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 350),
          child: Image.asset(
            MAIN_KIDE_LOGO,
            width: _currentIndex == 2 ? 34 : 28,
            height: _currentIndex == 2 ? 34 : 28,
          ),
        ),
        // Icon(Icons.pin_drop,
        //   color:DynamicTheme.of(context).data.textTheme.bodyText1.color),
        SvgPicture.asset('lib/assets/icons8-sap.svg',color: DynamicTheme.of(context).data.textTheme.bodyText1.color),
        Icon(Icons.more_horiz,
          color: DynamicTheme.of(context).data.textTheme.bodyText1.color),
      ],
    );
  }
}
