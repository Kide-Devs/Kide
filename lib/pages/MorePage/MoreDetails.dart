import 'package:Kide/config/Viewport.dart';
import 'package:flutter/material.dart';
import 'package:Kide/models/More.dart';
import 'package:Kide/widgets/HeaderWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreDetails extends StatelessWidget{
  static const routeName = '/MoreDetails';
   Widget build(BuildContext context){
    ViewPort().init(context);
      final More _moreInformation = ModalRoute.of(context).settings.arguments;
      return Scaffold(
        appBar: AppBar(
          title: HeaderWidget(_moreInformation.moreName, 15,Colors.white),
        ),
      backgroundColor: Color.fromRGBO(18, 18, 18, 1.0),
        body : Padding(
          padding: const EdgeInsets.fromLTRB(12, 0 , 12 , 0 ),
          child: Container(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Card(
                        color: Colors.black12,
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: InkWell(
                          child: Image.asset(_moreInformation.assetRoute),
                          onTap: (){
                            launch(_moreInformation.link);
                          },
                        ),
                      ),
                      for(int i=0;i<_moreInformation.pageFormat.length; i++)
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                            HeaderWidget(_moreInformation.pageFormat[i].header,15.0,Colors.white),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Divider(
                                color: Colors.white,
                                endIndent: ViewPort.screenWidth*0.55,
                              ),
                            ),
                            Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0 , 0 , 12 ),
                              child: HeaderWidget(_moreInformation.pageFormat[i].desc, 12,Colors.white),
                            ),
                            ],
                          ),
                        )
                      )
                    ]
                  )
                )
              ]
            )
          )
        )
     );
   }
}