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
import 'package:Kide/pages/EventsPage/Events.dart';
import 'package:Kide/pages/EventsPage/SubEvents.dart';
import 'package:Kide/pages/HomePage/Home.dart';
import 'package:Kide/pages/MapsPage/Maps.dart';
import 'package:Kide/pages/MorePage/More.dart';
import 'package:Kide/providers/router.dart';
import 'package:Kide/widgets/BottomNav.dart';


class MyApp extends StatelessWidget {
  static const routeName = '/MyApp';
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (context) => Router()),
        ChangeNotifierProvider( create: (context) => Bookmarks()),
        ChangeNotifierProvider( create: (context) => GetEvents()),
        ChangeNotifierProvider( create: (context) => GetMarkers()),
        ChangeNotifierProvider( create: (context) => GetGameDetails()),
      ],
      child: MaterialApp(
        title: KIDE_L_CAPS,
        theme: ThemeData.dark(),
        home: MyHomePage(title: KIDE_CAPS),
        routes: {
          SubEvents.routeName: (context) => SubEvents(),
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
    EventsPage(),
    MorePage(),
  ];
  final List<Widget> _uloTabs = [
    MapsPage(),
    ContactsPage(),
    HomePage(),
    EventsPage(),
    MorePage(),
  ];
  
  final List<String> _tabNames = [
    MAPS,
    CONTACTS,
    HOME,
    EVENTS,
    MORE
  ];

  void showUserSelectionDialog(BuildContext context) async {
    showDialog(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff222222),
          titlePadding: EdgeInsets.fromLTRB(10.0, 10, 10, 2),
          contentPadding: EdgeInsets.fromLTRB(5.0, 2, 5, 8),
          title: Center(child: Text(EVENT_OVERVIEW)),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: HeaderWidget("Default User Select", 30, Colors.white)
        );
      }
    );
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _getEvents = Provider.of<GetEvents>(context);
    if (_getEvents.eventList.length == 0) _getEvents.setEvents();
  }
  
  @override
  Widget build(BuildContext context) {
    
    final indexState = Provider.of<Router>(context);
    
    final _getEvents = Provider.of<GetEvents>(context);
    return _getEvents.userType == "Participant or ULO?" ?
      AlertDialog(
        backgroundColor: Color(0xff222222),
        titlePadding: EdgeInsets.fromLTRB(10.0, 10, 10, 2),
        contentPadding: EdgeInsets.fromLTRB(5.0, 2, 5, 8),
        title: Center(child: Text("Welcom to KIDE!")),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Divider(
              indent: 0,
              endIndent: 0,
              color: Colors.blueAccent,
              thickness: 3,
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      HeaderWidget("Please Tell us About Yourself!", 18, Colors.white70),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: DropdownButton(
                          isExpanded: true,
                          isDense: true,
                          value: _getEvents.locUserType,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                          underline: Container(
                            height: 2,
                            color: Color.fromRGBO(0, 112, 240, 87),
                          ),
                          items: [
                            "Participant or ULO?",
                            "Participant",
                            "ULO"
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newVal) =>
                            _getEvents.setLocUserType(newVal)
                              // _getEvents.setUserType(newVal),
                        ),
                      ),
                      if(_getEvents.locUserType == "Participant") 
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: DropdownButton(
                          isExpanded: true,
                          isDense: true,
                          value: _getEvents.university,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                          underline: Container(
                            height: 2,
                            color: Color.fromRGBO(0, 112, 240, 87),
                          ),
                          items: [
                            SELECT_YOUR_UNIVERSITY,
                            ..._getEvents.universities
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newVal) =>
                              _getEvents.setUniversity(newVal),
                          ),
                        ),
                      if(_getEvents.locUserType == "ULO") 
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: DropdownButton(
                            isExpanded: true,
                            isDense: true,
                            value: _getEvents.currentULO,
                            icon: Icon(Icons.keyboard_arrow_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                            underline: Container(
                              height: 2,
                              color: 
                                _getEvents.currentULO == "Select Your ID" ?
                                Colors.grey : Color.fromRGBO(0, 112, 240, 87),
                            ),
                            items: [
                              "Select Your ID",
                              ..._getEvents.uloNameList
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String newVal) =>
                              _getEvents.setCurrentULO(newVal),
                          ),
                        ),
                      RaisedButton(
                        color: 
                          _getEvents.currentULO == "Select Your ID" &&
                          _getEvents.university == SELECT_YOUR_UNIVERSITY
                          ?
                          Colors.grey : Colors.blueAccent,
                        child: Text(
                          "SUBMIT",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () =>
                          _getEvents.currentULO == "Select Your ID" &&
                          _getEvents.university == SELECT_YOUR_UNIVERSITY
                          ? {} :
                          _getEvents.setUserType(_getEvents.locUserType) 
                        ,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                      ),
                    ]
                  ),
                )
              )
            )
          ]
        )
      )
    : Scaffold(
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

