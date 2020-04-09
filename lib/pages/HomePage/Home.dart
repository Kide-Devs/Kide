import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  ScrollController controller;
  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DynamicTheme.of(context).data.scaffoldBackgroundColor,
      body: new NestedScrollView(
        controller: this.controller,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              stretch: true,
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              title: new TabBar(
                tabs: <Tab>[
                  new Tab(text: "News Alerts",),
                  new Tab(text: "Events",),
                  new Tab(text: "Blogs",),
                ]
              ),
            )
          ];
        }, 
        body: Container()
      )
    );
  }
}
