import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:Kide/util/data.dart';
import 'package:Kide/util/constants.dart';
import 'package:Kide/widgets/HeaderWidget.dart';
import 'package:Kide/pages/ContactsPage/widgets/EmergencyCard.dart';
import 'package:Kide/pages/ContactsPage/widgets/CategoryCard.dart';
import 'package:Kide/config/Viewport.dart';

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(4, 1),
];

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final _contactCategories = contactCategoryList;

  final _emergencyContacts = emergency;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ViewPort().init(context);
    return Scaffold(
      backgroundColor: DynamicTheme.of(context).data.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    HeaderWidget(EMERGENCY_CONTACTS, 12,
                        DynamicTheme.of(context).data.textTheme.subtitle2.color),
                    Divider(
                      color: Colors.white,
                      endIndent: ViewPort.screenWidth * 0.44,
                    ),
                  ],
                ),
              ),
              SliverStaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                staggeredTiles: _staggeredTiles,
                children: <Widget>[
                  for (int i = 0; i < _emergencyContacts.length; i++)
                    new EmergencyCard(
                      _emergencyContacts[i].iconAsset,
                      _emergencyContacts[i].emergency,
                      _emergencyContacts[i].number,
                    ),
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    HeaderWidget(OTHER_CONTACTS, 12, Colors.white),
                    Divider(
                      color: Colors.white,
                      endIndent: ViewPort.screenWidth * 0.44,
                    ),
                  ],
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                delegate: SliverChildListDelegate(//category card generator
                  [
                    for (int i = 0; i < contactCategoryList.length; i++)
                      CategoryCard(_contactCategories[i]),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
  