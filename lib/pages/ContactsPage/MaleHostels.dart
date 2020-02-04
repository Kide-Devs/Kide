import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kide/models/Contact.dart';
import 'package:kide/models/ContactCategory.dart';
import 'package:kide/pages/ContactsPage/widgets/ContactCardButton.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kide/pages/ContactsPage/Contacts.dart';


class MaleHostels extends StatelessWidget {
  static const routeName = '/MaleHostels';
  @override
  Widget build(BuildContext context) {
    final ContactCategory contactCategory = ModalRoute.of(context).settings.arguments;

  //   return Scaffold(
  //     backgroundColor: Color.fromRGBO(18, 18, 18, 1.0),
  //     body : Container(
  //       child: CustomScrollView(
  //         slivers: <Widget>[
  //           SliverList(
  //             delegate: SliverChildListDelegate(
  //               [
  //                 HeaderWidget("KP - 1"),
  //                 Divider(
  //                   color: Colors.white,
  //                   endIndent: 194.0,
  //                 ),
  //                 RotationTransition(
  //                   turns: AlwaysStoppedAnimation(750/360),
  //                   child: Divider(
  //                     height: 0.0,
  //                     color: Colors.white,
  //                     indent: 163.5,
  //                     endIndent: 175.0,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           SliverGrid(
  //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
  //             delegate: SliverChildListDelegate(
  //               [
  //                 const ContactCard("Boy's Hostels"),
  //                 const ContactCard("Girl's Hostels"),
  //                 const ContactCard('Helpline'),
  //                 const ContactCard('Administration'),
  //                 const ContactCard('#1'),
  //                 const ContactCard('#2'),
  //                 const ContactCard('#3'),
  //                 const ContactCard('#4'),
  //               ],
  //               // addRepaintBoundaries: false,
  //               // addAutomaticKeepAlives: false,
  //             ),
  //           )
  //         ]
  //       )
  //     )
  //   ); 
  // }

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          ContactCardButton(
            contactCategory.contacts[index].name,
            contactCategory.contacts[index].phone,
            contactCategory.contacts[index].designation,
          ),
      itemCount: contactCategory.contacts.length,
      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
    );
  }
}