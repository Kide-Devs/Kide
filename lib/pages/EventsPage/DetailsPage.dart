import 'package:flutter/material.dart';
import '../../models/SubEvent.dart';
import 'package:kide/pages/ContactsPage/widgets/HeaderWidget.dart';

class DetailsPage extends StatelessWidget{
  DetailsPage(this.detail);
  final SubEvent detail;
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(detail.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
          ),
        )
      ),
      backgroundColor: Color.fromRGBO(18, 18, 18, 1.0),
      body : Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  HeaderWidget(detail.date),
                  Divider(
                    color: Colors.white,
                    endIndent: 194.0,
                  ),
                  for(int i = 0;i<detail.details.length; i++)
                  Center(
                    child: Text(detail.details[i++].description,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]
        )
      )
    ); 
  }
}
