import 'package:Kide/pages/ForYou/ForYou.dart';
import 'package:Kide/pages/HomePage/HomepageProvider.dart';
import 'package:Kide/providers/getGameDetails.dart';
import 'package:Kide/widgets/HeaderWidget.dart';
import 'package:flutter/material.dart';
import 'package:Kide/pages/ContactsPage/ContactList.dart';
import 'package:Kide/pages/EventsPage/BookmarksPage.dart';
import 'package:Kide/pages/EventsPage/DetailsPage.dart';
import 'package:Kide/pages/MorePage/MoreDetails.dart';
import 'package:Kide/providers/getEvents.dart';
import 'package:Kide/providers/bookmarks.dart';
import 'package:Kide/providers/getMarkers.dart';
import 'package:Kide/util/constants.dart';
import 'package:provider/provider.dart';
import 'package:Kide/pages/ContactsPage/Contacts.dart';
import 'package:Kide/pages/EventsPage/SubEvents.dart';
import 'package:Kide/pages/HomePage/Home.dart';
import 'package:Kide/pages/MapsPage/Maps.dart';
import 'package:Kide/pages/MorePage/More.dart';
import 'package:Kide/providers/router.dart';
import 'package:Kide/widgets/BottomNav.dart';

import 'pages/EventsPage/BookmarksPage.dart';
import 'providers/router.dart';


class MyApp extends StatelessWidget {
  static const routeName = '/MyApp';
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (context) => Router()),
        ChangeNotifierProvider( create: (context) => Bookmarks()),
        // ChangeNotifierProvider( create: (context) => GetEvents()),
        ChangeNotifierProvider( create: (context) => GetMarkers()),
        ChangeNotifierProvider( create: (context) => GetGameDetails()),
        ChangeNotifierProvider( create: (context) => HomePageProvider()),
      ],
      child: MaterialApp(
        title: KIDE_L_CAPS,
        theme: ThemeData.dark(),
        home: MyHomePage(title: KIDE_CAPS),
        routes: {
          // SubEvents.routeName: (context) => SubEvents(),
          BookmarksPage.routeName: (context) => BookmarksPage(),
          ContactList.routeName: (context) => ContactList(),
          DetailsPage.routeName: (context) => DetailsPage(),
          MoreDetails.routeName: (context) => MoreDetails(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> _tabs = [
    MapsPage(),
    ContactsPage(),
    HomePage(),
    ForYouPage(),
    MorePage(),
  ];
  
  final List<String> _tabNames = [
    MAPS,
    CONTACTS,
    "K  I  D  E",
    "For You",
    MORE
  ];

  // void showUserSelectionDialog(BuildContext context) async {
  //   showDialog(
  //     context: context,
  //     useRootNavigator: true,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         backgroundColor: Color(0xff222222),
  //         titlePadding: EdgeInsets.fromLTRB(10.0, 10, 10, 2),
  //         contentPadding: EdgeInsets.fromLTRB(5.0, 2, 5, 8),
  //         title: Center(child: Text(EVENT_OVERVIEW)),
  //         titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         content: HeaderWidget("Default User Select", 30, Colors.white)
  //       );
  //     }
  //   );
  // }
  
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final _getEvents = Provider.of<GetEvents>(context);
  //   if (_getEvents.eventList.length == 0) _getEvents.setEvents();
  // }
  
  @override
  Widget build(BuildContext context) {
    
    final indexState = Provider.of<Router>(context);
    
    return Scaffold(
      appBar: indexState.bottomNavIndex != 0 ? AppBar(
        title: Center(
          child: Text(
            _tabNames[indexState.bottomNavIndex],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Roboto',
            ),
          )
        ),
      ): null,
      backgroundColor: Color.fromRGBO(18, 18, 18, 1.0),
      body: _tabs[indexState.bottomNavIndex],
      bottomNavigationBar: BottomNav(),
    );
  }
}

