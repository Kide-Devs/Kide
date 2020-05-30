import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:Kide/util/data.dart';
import 'package:Kide/util/constants.dart';
import 'package:Kide/widgets/HeaderWidget.dart';
import 'package:Kide/pages/ContactsPage/widgets/EmergencyCard.dart';
import 'package:Kide/pages/ContactsPage/widgets/CategoryCard.dart';
import 'package:Kide/config/Viewport.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(ContactsPage());

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

  Future<void> _getPermissions() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler()
            .requestPermissions([PermissionGroup.contacts]);
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.contacts);
    ServiceStatus serviceStatus =
        await PermissionHandler().checkServiceStatus(PermissionGroup.contacts);
    bool isShown = await PermissionHandler()
        .shouldShowRequestPermissionRationale(PermissionGroup.contacts);
  }

  @override
  void initState() {
    super.initState();
    _getPermissions();
  }

  @override
  Widget build(BuildContext context) {
    // Offset _offset = Offset(0.95, 0.55);
    ViewPort().init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 18, 18, 1.0),
      body : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    HeaderWidget(EMERGENCY_CONTACTS,12,Colors.white),
                    Divider(
                      color: Colors.white,
                      endIndent: ViewPort.screenWidth*0.44,
                    ),
                    // Transform(
                    //   transform: Matrix4.identity()
                    //   ..setEntry(1, 3, 0.001) // perspective
                    //   ..rotateX(_offset.dy)
                    //   ..rotateY(_offset.dx),
                    //   alignment: FractionalOffset(0.57,0.57),
                    //   child: Divider(
                    //     height: 0.0,
                    //     color: Colors.white,
                    //     indent: ViewPort.screenWidth*0.49,
                    //     endIndent: ViewPort.screenWidth*0.37,
                    //   ),
                    // )
                    // RotationTransition(
                    //   turns: AlwaysStoppedAnimation(750/360),
                    //   child: Divider(
                    //     height: 0.0,
                    //     color: Colors.white,
                    //     indent: 95,
                    //     endIndent: ViewPort.screenWidth*0.55,
                    //   ),
                    // ),
                  ],
                ),
              ),
              SliverStaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                staggeredTiles: _staggeredTiles,
                children: <Widget>[
                  for(int i=0;i<_emergencyContacts.length;i++)
                    new EmergencyCard(_emergencyContacts[i].iconAsset, _emergencyContacts[i].emergency, _emergencyContacts[i].number),
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    HeaderWidget(OTHER_CONTACTS,12,Colors.white),
                    Divider(
                      color: Colors.white,
                      endIndent: ViewPort.screenWidth*0.44,
                    ),
                    // Transform(
                    //   transform: Matrix4.identity()
                    //   ..setEntry(1, 3, 0.001) // perspective
                    //   ..rotateX(_offset.dy)
                    //   ..rotateY(_offset.dx),
                    //   alignment: FractionalOffset(0.57,0.57),
                    //   child: Divider(
                    //     height: 0.0,
                    //     color: Colors.white,
                    //     indent: ViewPort.screenWidth*0.49,
                    //     endIndent: ViewPort.screenWidth*0.37,
                    //   ),
                    // )
                    // RotationTransition(
                    //   turns: AlwaysStoppedAnimation(750/360),
                    //   child: Divider(
                    //     height: 0.0,
                    //     color: Colors.white,
                    //     indent: 163.5,
                    //     endIndent: 175.0,
                    //   ),
                    // ),
                  ],
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                delegate: SliverChildListDelegate(
                  [
                    for(int i=0;i<contactCategoryList.length;i++)
                      CategoryCard(_contactCategories[i]),
                  ],
                ),
              )
            ]
          )
        ),
      )
    ); 
  }
}