import 'package:flutter/material.dart';
import 'package:Kide/util/data.dart';
import 'package:Kide/pages/MorePage/Widgets/MoreCard.dart';
void main() => runApp(MorePage());

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 18, 18, 1.0),
      body : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                delegate: SliverChildListDelegate(
                  [
                    for(int i=0;i<more.length;i++)
                      MoreCard(more[i])
                  ],
                ),
              )
              ]
            )
        )
      )
    );
  }
}
