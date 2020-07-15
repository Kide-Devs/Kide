import 'package:Kide/pages/HomePage/widgets/PostsPage.dart';
import 'package:Kide/pages/MorePage/More.dart';
import 'package:Kide/pages/Preferences/PreferencesPage.dart';
import 'package:Kide/util/constants.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  _changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: DynamicTheme.of(context).data.scaffoldBackgroundColor,
      body: new NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              expandedHeight: 100,
              actions: <Widget>[
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
