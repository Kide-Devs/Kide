import 'package:Kide/pages/AboutUsPage.dart/AboutUs.dart';
import 'package:Kide/pages/AvatarPage/AvatarLoading.dart';
import 'package:Kide/pages/HomePage/widgets/PostsPage.dart';
import 'package:Kide/pages/Profile/profile.dart';
import 'package:Kide/pages/SettingsPage/settings.dart';
import 'package:Kide/util/constants.dart';
import 'package:Kide/widgets/CircularAvatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:Kide/pages/attendancePages/attendanceMainPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
String name = '';
String email = '';
class _HomePageState extends State<HomePage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<HomePage> {
  ScrollController _scrollController;
  TabController _tabController;
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
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: 3);
    fetchName();
    super.initState();
  }

  _changeBrightness(context) {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  void fetchName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('Name');
      email = prefs.getString('Email');
    });
  }

  @override
  bool get wantKeepAlive => true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int ct = 0;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final avatarWidth = (360 / MediaQuery.of(context).size.height) * 100;
    final avatarHeight = (640 / MediaQuery.of(context).size.height) * 100;

    if (ct == 0) {
      // Checking for darkTheme enabled
      isDarkModeEnabled =
          Theme.of(context).brightness == Brightness.dark ? true : false;
      ct++;
    }
    return new Scaffold(
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
                              // Using Custom avatar Widget
                              child: isAv
                                  ? SvgPicture.network(
                                      url,
                                      height: avatarHeight,
                                      width: avatarWidth,
                                      alignment: Alignment.topLeft,
                                      placeholderBuilder: (_) => AvatarLoading(
                                        avatarWidth,
                                        avatarHeight,
                                      ),
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
                                fontWeight: FontWeight.w600,
                              ),
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Settings()));
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

                  // ListTile(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => AttendanceMainPage()));
                  //   },
                  //   leading: Icon(Icons.assignment_return),
                  //   title: Text(
                  //     'Attendance',
                  //     style: TextStyle(fontFamily: "EncodeSans", fontSize: 16),
                  //   ),
                  // ),
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
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Choose subject'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FlatButton.icon(
                                    onPressed: () {
                                      _createEmail(
                                          '[FEEDBACK]: $name : $email');
                                    },
                                    icon: Icon(Icons.feedback),
                                    label: Text("Feedback"),
                                  ),
                                  FlatButton.icon(
                                    onPressed: () {
                                      _createEmail('[HELP]: $name : $email');
                                    },
                                    icon: Icon(Icons.help),
                                    label: Text("Help"),
                                  ),
                                ],
                              ),
                              actions: [
                                FlatButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(Icons.close),
                                  label: Text("Cancel"),
                                ),
                              ],
                            ),
                          );
                        },
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
                          print(shortUrl);
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
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 3),
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
                icon: Icon(
                  Icons.clear_all,
                  color: DynamicTheme.of(context).data.iconTheme.color,
                ),
              ),
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
                  new Tab(text: "Blog"),
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

void _createEmail(String subject) async {
  String emailaddress = 'mailto:kide.kiit@gmail.com?subject=$subject';

  if (await canLaunch(emailaddress)) {
    await launch(emailaddress);
  } else {
    throw 'Could not Email';
  }
}
