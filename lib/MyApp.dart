import 'package:Kide/pages/Auth/Login.dart';
import 'package:Kide/pages/Profile/profile.dart';
import 'package:Kide/pages/SettingsPage/settings.dart';
import 'package:auro_avatar/auro_avatar.dart';
import 'package:share/share.dart';

import 'package:Kide/pages/ForYou/ForYou.dart';
import 'package:Kide/providers/getGameDetails.dart';
import 'package:Kide/widgets/HeaderWidget.dart';
import 'package:Kide/AboutUsPage.dart/AboutUs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

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
  String name = '';
  String email = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchName();
  }

  void fetchName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    name = prefs.getString('Name');
    email = prefs.getString('Email');
    print(name);
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
  //         titleTextStyle: TextStyle(color: Colors.white, fontSize: 16),
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final indexState = Provider.of<Router>(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(10),
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
                                child: InitialNameAvatar(
                              name,
                              circleAvatar: true,
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              textSize: 32,
                              borderColor: Colors.grey,
                            )),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              name,
                              style: TextStyle(
                                  fontSize: 19, fontFamily: "EncodeSans"),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              email,
                              style: TextStyle(
                                  fontSize: 17, fontFamily: "EncodeSans"),
                            )
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
                  ListTile(
                    title: Text(
                      "Saved Posts",
                      style: TextStyle(fontFamily: "EncodeSans", fontSize: 17),
                    ),
                    leading: Icon(Icons.save),
                  ),
                  ListTile(
                      onTap: () async {
                        print("Clicked");
                        final DynamicLinkParameters parameters =
                            DynamicLinkParameters(
                                uriPrefix: 'https://kiitdev.page.link',
                                link: Uri.parse(
                                    'https://kiitdev.page.link/post/'),
                                androidParameters: AndroidParameters(
                                  packageName: 'com.kiitdev.Kide',
                                ),
                                socialMetaTagParameters: SocialMetaTagParameters(
                                    imageUrl: Uri.parse(
                                        "https://lh3.googleusercontent.com/C60ciedUhQScbWSFG5BY0P1YpA3Js1SLJZKwB0W4csaR5OzfgjjUopGiHeD5Q_krvAw=s180-rw")),
                                dynamicLinkParametersOptions:
                                    DynamicLinkParametersOptions(
                                        shortDynamicLinkPathLength:
                                            ShortDynamicLinkPathLength.short)
                                // NOT ALL ARE REQUIRED ===== HERE AS AN EXAMPLE =====
                                );
                        final ShortDynamicLink shortDynamicLink =
                            await parameters.buildShortLink();
                        final Uri shortUrl = shortDynamicLink.shortUrl;
                        print(shortUrl);
                        Share.share("${shortUrl}");
                      },
                      leading: Icon(Icons.archive),
                      title: Text(
                        'Invite Friends',
                        style:
                            TextStyle(fontFamily: "EncodeSans", fontSize: 16),
                      )),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AboutUs()));
                    },
                    title: Text(
                      "About Us",
                      style: TextStyle(fontFamily: "EncodeSans", fontSize: 16),
                    ),
                    leading: Icon(Icons.info),
                  ),
                  ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Settings()));
                      },
                      leading: Icon(Icons.settings),
                      title: Text(
                        'Settings',
                        style:
                            TextStyle(fontFamily: "EncodeSans", fontSize: 16),
                      )),
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
                            title: Text('Help and Feedback')),
                        ListTile(
                            onTap: () async {
                              FirebaseAuth _auth = FirebaseAuth.instance;
                              await _auth.signOut();
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool('loggedOut', true);
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            leading: Icon(Icons.exit_to_app),
                            title: Text('Sign Out'))
                      ],
                    )))),
            SizedBox(height: 3),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Text("Version:v2.1.1 "),
            // ),
            // SizedBox(height: 10),
          ],
        ),
      ),
      appBar: indexState.bottomNavIndex != 0 && indexState.bottomNavIndex != 2
          ? AppBar(
              leading: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  icon: Icon(
                    Icons.clear_all,
                    color: DynamicTheme.of(context).data.iconTheme.color,
                  )),
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
