import 'package:flutter/material.dart';
import 'package:Kide/models/ContactCategory.dart';
import 'package:Kide/pages/ContactsPage/widgets/ContactCardDiallable.dart';
import 'package:Kide/util/constants.dart';
import 'package:Kide/widgets/HeaderWidget.dart';
import 'package:Kide/config/Viewport.dart';


class ContactList extends StatelessWidget {
  // Offset _offset = Offset(0.95, 0.55);
  static const routeName = '/ContactList';
  @override
  Widget build(BuildContext context) {
    ViewPort().init(context);
    final ContactCategory contactCategory = ModalRoute.of(context).settings.arguments;
    final _contactList = contactCategory.contacts;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(CONTACT_LIST,
          style: TextStyle(
            fontFamily: 'Roboto',
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(18, 18, 18, 1.0),
      body : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    HeaderWidget(contactCategory.name,12, Colors.white),
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
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    for(int i=0;i<_contactList.length;i++)
                      ContactCardDiallable(_contactList[i].name, _contactList[i].number, _contactList[i].designation),
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