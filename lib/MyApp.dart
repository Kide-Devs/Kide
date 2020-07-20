import 'package:Kide/pages/ForYou/ForYou.dart';
import 'package:Kide/providers/getGameDetails.dart';
import 'package:Kide/widgets/HeaderWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:Kide/pages/ContactsPage/ContactList.dart';
import 'package:Kide/pages/EventsPage/BookmarksPage.dart';
import 'package:Kide/pages/EventsPage/DetailsPage.dart';
import 'package:Kide/pages/MorePage/MoreDetails.dart';
import 'package:Kide/providers/getEvents.dart';
import 'package:Kide/providers/bookmarks.dart';
import 'package:Kide/providers/getMarkers.dart';
import 'package:Kide/util/constants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:Kide/pages/ContactsPage/Contacts.dart';
import 'package:Kide/pages/EventsPage/SubEvents.dart';
import 'package:Kide/pages/HomePage/Home.dart';
import 'package:Kide/pages/MapsPage/Maps.dart';
import 'package:Kide/pages/MorePage/More.dart';
import 'package:Kide/providers/router.dart';
import 'package:Kide/widgets/BottomNav.dart';

import 'pages/EventsPage/BookmarksPage.dart';
import 'pages/HomePage/PostDetailsPage.dart';
import 'providers/router.dart';

class MyApp extends StatefulWidget {
  static const routeName = '/MyApp';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleDynamicLinks();
  }

  Future handleDynamicLinks() async {
    // 1. Get the initial dynamic link if the app is opened with a dynamic link
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    // 2. handle link that has been retrieved
    _handleDeepLink(data);

    // 3. Register a link callback to fire if the app is opened up from the background
    // using a dynamic link.
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      // 3a. handle link that has been retrieved
      _handleDeepLink(dynamicLink);
    }, onError: (OnLinkErrorException e) async {
      print('Link Failed: ${e.message}');
    });
  }

  Future<void> _handleDeepLink(PendingDynamicLinkData data) async {
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      print('_handleDeepLink | deeplink: ${deepLink}');
      var isPost = deepLink.pathSegments.contains('post');
      print(isPost);
      print("-----");
      if (isPost) {
        // get the title of the post
        var title = deepLink.queryParameters['id'];

        if (title != null) {
          print(title);
          // if we have a
          var postType = deepLink.queryParameters['type'];
          print(postType);
          Firestore firestore = Firestore.instance;
          DocumentReference querySnapshot =
              firestore.collection(postType).document(title);
          var body = '';
          var tit;
          var image;
          var subtitle;
          var likes;
          var views;
          var date;

          querySnapshot.get().then((value) {
            body = value.data['body'];
            tit = value.data['title'];
            image = value.data['imageUrl'];
            subtitle = value.data['subtitle'];
            likes = value.data['likes'];
            views = value.data['views'];
            date = value.data['date'];
            date = (date as Timestamp).toDate();
            String formattedDate = DateFormat.yMMMd().format(date);

            print(title);
            print(body);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PostDetailsPage(
                          id: title.toString(),
                          postType: postType.toString(),
                          title: tit.toString(),
                          body: body.toString(),
                          image: image.toString(),
                          subtitle: subtitle.toString(),
                          likes: likes.toString(),
                          views: views.toString(),
                          date: formattedDate,
                        )));
            //  post navigate to the CreatePostViewRoute and pass in the title as the arguments.
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Router()),
        ChangeNotifierProvider(create: (context) => Bookmarks()),
        // ChangeNotifierProvider( create: (context) => GetEvents()),
        ChangeNotifierProvider(create: (context) => GetMarkers()),
        ChangeNotifierProvider(create: (context) => GetGameDetails()),
        //ChangeNotifierProvider( create: (context) => HomePageProvider()),
      ],
      child: MaterialApp(
        title: KIDE_L_CAPS,
        theme: DynamicTheme.of(context).data.brightness == Brightness.dark
            ? ThemeData.dark()
            : ThemeData.light(),
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
      appBar: indexState.bottomNavIndex != 0 && indexState.bottomNavIndex != 2
          ? AppBar(
              backgroundColor: DynamicTheme.of(context).data.backgroundColor,
              title: Center(
                child: Text(
                  _tabNames[indexState.bottomNavIndex],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'EncodeSans',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                      color: DynamicTheme.of(context)
                          .data
                          .textTheme
                          .subtitle
                          .color),
                ),
              ),
            )
          : null,
      backgroundColor: DynamicTheme.of(context).data.scaffoldBackgroundColor,
      body: _tabs[indexState.bottomNavIndex],
      bottomNavigationBar: BottomNav(),
    );
  }
}
