import 'package:flutter/material.dart';
import 'package:kide/pages/EventsPage/BookmarksPage.dart';
import 'package:kide/providers/bookmarks.dart';
import 'package:provider/provider.dart';
import 'package:kide/pages/ContactsPage/Contacts.dart';
import 'package:kide/pages/ContactsPage/MaleHostels.dart';
import 'package:kide/pages/EventsPage/Events.dart';
import 'package:kide/pages/EventsPage/SubEvents.dart';
import 'package:kide/pages/Home.dart';
import 'package:kide/pages/MapsPage/Maps.dart';
import 'package:kide/pages/More.dart';
import 'package:kide/providers/router.dart';
import 'package:kide/widgets/BottomNav.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (context) => Router()),
        ChangeNotifierProvider( create: (context) => Bookmarks()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: MyHomePage(title: 'KIDE'),
        routes: {
          SubEvents.routeName: (context) => SubEvents(),
          BookmarksPage.routeName: (context) => BookmarksPage(),
          MaleHostels.routeName: (context) => MaleHostels(),
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
    EventsPage(),
    MorePage(),
  ];

  final List<String> _tabNames = [
    "Maps",
    "Contacts",
    "Home",
    "Events",
    "More"
  ];
  
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

