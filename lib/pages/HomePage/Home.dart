import 'package:Kide/pages/Auth/Login.dart';
import 'package:Kide/pages/HomePage/widgets/PostsPage.dart';
import 'package:Kide/pages/MorePage/More.dart';
import 'package:Kide/pages/Preferences/PreferencesPage.dart';
import 'package:Kide/pages/Profile/profile.dart';
import 'package:Kide/pages/SettingsPage/settings.dart';
import 'package:Kide/util/constants.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share/share.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<HomePage> {
  ScrollController _scrollController;
  TabController _tabController;
  String name = '';
  String email = '';
  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: 3);
    fetchName();
    super.initState();
  }

  void fetchName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('Name');
    email = prefs.getString('Email');
    print(name);
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                              child: Image.asset(
                                MAIN_KIDE_LOGO,
                                height:
                                    MediaQuery.of(context).size.height * 0.10,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'name',
                              style: TextStyle(
                                  fontSize: 19, fontFamily: "EncodeSans"),
                            ),
                            Text(
                              'email',
                              style: TextStyle(
                                  fontSize: 17, fontFamily: "EncodeSans"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListTile(
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
      key: _scaffoldKey,
      backgroundColor: DynamicTheme.of(context).data.scaffoldBackgroundColor,
      body: new NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              expandedHeight: 100,
              leading: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  icon: Icon(Icons.clear_all)),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.person),
                  color: DynamicTheme.of(context).data.iconTheme.color,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(),
                      ),
                    ); //_changeBrigh
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: DynamicTheme.of(context).data.iconTheme.color,
                  ),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PreferencesPage(),
                    ),
                  ), //_changeBrightness,
                ),
                SizedBox(
                  width: 5,
                ),
              ],
              title: new Text(
                KIDE_CAPS,
                style: TextStyle(
                  color:
                      DynamicTheme.of(context).data.textTheme.subtitle1.color,
                  fontFamily: "Michroma",
                  fontWeight: FontWeight.w300,
                  fontSize: 25,
                ),
              ),
              centerTitle: true,
              backgroundColor: DynamicTheme.of(context).data.backgroundColor,
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              bottom: new TabBar(
                indicatorColor: DynamicTheme.of(context).data.indicatorColor,
                labelColor:
                    DynamicTheme.of(context).data.tabBarTheme.labelStyle.color,
                labelStyle: TextStyle(
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
                tabs: <Widget>[
                  new Tab(text: "News"),
                  new Tab(text: "Blogs"),
                  new Tab(text: "Events"),
                ],
                controller: _tabController,
              ),
            ),
          ];
        },
        body: new TabBarView(
          controller: _tabController,
          children: <Widget>[
            new PostsPage(postType: "news"),
            new PostsPage(postType: "blogs"),
            new PostsPage(postType: "events_home")
          ],
        ),
      ),
    );
  }
}
