import 'package:Kide/pages/AboutUsPage.dart/AboutUs.dart';
import 'package:Kide/pages/ContactsPage/ContactList.dart';
import 'package:Kide/pages/ContactsPage/Contacts.dart';
import 'package:Kide/pages/EventsPage/BookmarksPage.dart';
import 'package:Kide/pages/EventsPage/DetailsPage.dart';
import 'package:Kide/pages/ForYou/ForYou.dart';
import 'package:Kide/pages/HomePage/Home.dart';
import 'package:Kide/pages/MapsPage/Maps.dart';
import 'package:Kide/pages/MorePage/More.dart';
import 'package:Kide/pages/MorePage/MoreDetails.dart';
import 'package:Kide/pages/Profile/profile.dart';
import 'package:Kide/pages/SettingsPage/settings.dart';
import 'package:Kide/pages/attendancePages/attendanceMainPage.dart';
import 'package:Kide/providers/bookmarks.dart';
import 'package:Kide/providers/getGameDetails.dart';
import 'package:Kide/providers/getMarkers.dart';
import 'package:Kide/providers/router.dart';
import 'package:Kide/util/constants.dart';
import 'package:Kide/widgets/BottomNav.dart';
import 'package:Kide/widgets/CircularAvatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/EventsPage/BookmarksPage.dart';
import 'pages/HomePage/PostDetailsPage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void configOneSignal() {
  OneSignal.shared.init('90f8e0a4-45e3-4fed-8521-89a8e869b370');
}

getYI() async {
  var status = await OneSignal.shared.getPermissionSubscriptionState();
  var playerId = status.subscriptionStatus.userId;
  print(playerId);
}

class MyApp extends StatefulWidget {
  static const routeName = '/MyApp';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    configOneSignal();
    super.initState();
    handleDynamicLinks();

    getYI();
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
      },
      onError: (OnLinkErrorException e) async {},
    );
  }

  Future<void> _handleDeepLink(PendingDynamicLinkData data) async {
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      var isPost = deepLink.pathSegments.contains('post');
      if (isPost) {
        // get the title of the post
        var title = deepLink.queryParameters['id'];

        if (title != null) {
          // if we have a
          var postType = deepLink.queryParameters['type'];
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

          querySnapshot.get().then(
            (value) {
              body = value.data['body'];
              tit = value.data['title'];
              image = value.data['imageUrl'];
              subtitle = value.data['subtitle'];
              likes = value.data['likes'];
              views = value.data['views'];
              date = value.data['date'];
              date = (date as Timestamp).toDate();
              String formattedDate = DateFormat.yMMMd().format(date);

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
                  ),
                ),
              );
              //  post navigate to the CreatePostViewRoute and pass in the title as the arguments.
            },
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavRouter()),
        ChangeNotifierProvider(create: (context) => Bookmarks()),
        ChangeNotifierProvider(create: (context) => GetMarkers()),
        ChangeNotifierProvider(create: (context) => GetGameDetails()),
      ],
      child: MaterialApp(
        title: KIDE_L_CAPS,
        theme: DynamicTheme.of(context).data.brightness == Brightness.dark
            ? ThemeData.dark()
            : ThemeData.light(),
        home: MyHomePage(title: KIDE_CAPS),
        routes: {
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
  String name = '';
  String email = '';
  bool isDarkModeEnabled = false;
  String url;
  bool isAv = false;

  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((value) {
      Firestore.instance
          .collection('userInfo')
          .document(value.uid)
          .get()
          .then((val) {
        setState(() {
          url = val.data['avatarUrl'];
          if (url != null)
            setState(() {
              isAv = true;
            });
        });
      });
    });
    super.initState();
    fetchName();
  }

  _changeBrightness(context) {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  void fetchName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    name = prefs.getString('Name');
    email = prefs.getString('Email');
    setState(() {});
  }

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

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    fetchName();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int ct = 0;

  @override
  Widget build(BuildContext context) {
    if (ct == 0) {
      isDarkModeEnabled =
          Theme.of(context).brightness == Brightness.dark ? true : false;
      ct++;
    }
    final indexState = Provider.of<BottomNavRouter>(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: DrawerHeader(
                      padding: EdgeInsets.all(15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ClipRRect(
                              child: isAv
                                  ? SvgPicture.network(
                                      url,
                                      height:  (640 / MediaQuery.of(context).size.height) * 150,
                                      width: (360 / MediaQuery.of(context).size.height) * 100,
                                      alignment: Alignment.topLeft,
                                    )
                                  : InitialNameAvatar(
                                      name,
                                      backgroundColor:
                                          Colors.tealAccent.shade700,
                                      foregroundColor: Colors.white,
                                      textSize: 32,
                                      borderSize: 10,
                                      borderColor: Colors.grey.withOpacity(0.4),
                                    ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              name,
                              style: TextStyle(
                                  fontSize: 19,
                                  fontFamily: "Quicksand",
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              email,
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: "Quicksand",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                      );
                    },
                    title: Text(
                      "Your Profile",
                      style: TextStyle(fontFamily: "EncodeSans", fontSize: 17),
                    ),
                    leading: Icon(Icons.person),
                  ),
//                  ListTile(
//                    title: Text(
//                      "Saved Posts",
//                      style: TextStyle(fontFamily: "EncodeSans", fontSize: 17),
//                    ),
//                    leading: Icon(Icons.save),
//                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Settings(),
                        ),
                      );
                    },
                    leading: Icon(Icons.settings),
                    title: Text(
                      'Settings',
                      style: TextStyle(fontFamily: "EncodeSans", fontSize: 16),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Dark Mode ",
                      style: TextStyle(fontFamily: "Quicksand", fontSize: 20),
                    ),
                    trailing: Transform.scale(
                      scale: 0.6,
                      child: DayNightSwitcher(
                        isDarkModeEnabled: isDarkModeEnabled,
                        onStateChanged: (isDarkModeEnabled) {
                          setState(() {
                            this.isDarkModeEnabled = isDarkModeEnabled;
                            _changeBrightness(context);
                          });
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AttendanceMainPage()));
                    },
                    leading: Icon(Icons.assignment_return),
                    title: Text(
                      'Attendance',
                      style: TextStyle(fontFamily: "EncodeSans", fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // This align moves the children to the bottom
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                // This container holds all the children that will be aligned
                // on the bottom and should not scroll with the above ListView
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.help),
                        title: Text('Help and Feedback'),
                      ),
                      ListTile(
                        onTap: () async {
                          final DynamicLinkParameters parameters =
                              DynamicLinkParameters(
                            uriPrefix: 'https://kiitdev.page.link',
                            link: Uri.parse('https://kiitdev.page.link/post/'),
                            androidParameters: AndroidParameters(
                              packageName: 'com.kiitdev.Kide',
                            ),
                            socialMetaTagParameters: SocialMetaTagParameters(
                              imageUrl: Uri.parse(
                                  "https://lh3.googleusercontent.com/C60ciedUhQScbWSFG5BY0P1YpA3Js1SLJZKwB0W4csaR5OzfgjjUopGiHeD5Q_krvAw=s180-rw"),
                            ),
                            dynamicLinkParametersOptions:
                                DynamicLinkParametersOptions(
                              shortDynamicLinkPathLength:
                                  ShortDynamicLinkPathLength.short,
                            ),
                            // NOT ALL ARE REQUIRED ===== HERE AS AN EXAMPLE =====
                          );
                          final ShortDynamicLink shortDynamicLink =
                              await parameters.buildShortLink();
                          final Uri shortUrl = shortDynamicLink.shortUrl;

                          Share.share("$shortUrl");
                        },
                        leading: Icon(Icons.archive),
                        title: Text(
                          'Invite Friends',
                          style:
                              TextStyle(fontFamily: "EncodeSans", fontSize: 16),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutUs(),
                            ),
                          );
                        },
                        title: Text(
                          "About Us",
                          style:
                              TextStyle(fontFamily: "EncodeSans", fontSize: 16),
                        ),
                        leading: Icon(Icons.info),
                      ),
                      SizedBox(
                        height: 55,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 3),
          ],
        ),
      ),
      appBar: indexState.bottomNavIndex != 0 && indexState.bottomNavIndex != 2
          ? AppBar(
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                },
                icon: Icon(
                  Icons.clear_all,
                  color: DynamicTheme.of(context).data.iconTheme.color,
                ),
              ),
              backgroundColor: DynamicTheme.of(context).data.backgroundColor,
              title: Text(
                _tabNames[indexState.bottomNavIndex],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'EncodeSans',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                    color:
                        DynamicTheme.of(context).data.textTheme.subtitle.color),
              ),
            )
          : null,
      extendBody: true,
      backgroundColor: DynamicTheme.of(context).data.scaffoldBackgroundColor,
      body: _tabs[indexState.bottomNavIndex],
      bottomNavigationBar: BottomNav(),
    );
  }
}
