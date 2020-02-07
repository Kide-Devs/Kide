import 'package:kide/config/Viewport.dart';
import 'package:flutter/material.dart';
import 'package:kide/models/MoreDetailsModel.dart';
import 'package:kide/widgets/HeaderWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreDetails extends StatelessWidget{
  static const routeName = '/MoreDetails';
   Widget build(BuildContext context){
    ViewPort().init(context);
     final MoreDetailsModel _moreDetails = ModalRoute.of(context).settings.arguments;
     return Scaffold(
       appBar: AppBar(
         title: HeaderWidget(_moreDetails.header, 15),
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
                      // child: Image.asset(_moreDetails.asset_route),
                      child: InkWell(
                        child: Image.asset(_moreDetails.asset_route),
                        onTap: (){
                          launch(_moreDetails.link);
                        },
                      ),
                      ),
                      HeaderWidget("AIM",15.0),
                      Divider(
                        color: Colors.white,
                        endIndent: ViewPort.screenWidth*0.55,
                        ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0 , 0 , 12 ),
                        child: HeaderWidget(_moreDetails.aim, 12),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20 , 0 ,0 ),
                        child: HeaderWidget("OUR VISION", 15.0),
                      ),
                      Divider(
                        color: Colors.white,
                        endIndent: ViewPort.screenWidth*0.55,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0 , 0 ,35 ),
                          child: HeaderWidget(_moreDetails.mission, 12),
                        )
                    ],
                  )
                )
              ]
            )
          )
        )
     );
   }

}



// body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           child: CustomScrollView(
//             slivers: <Widget>[
//               SliverList(
//                 delegate: SliverChildListDelegate(
//                   [
//                     Card(
//                       color: Colors.black12,
//                       clipBehavior: Clip.hardEdge,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0)
//                       ),
//                       child: Image.asset(_moreDetails.asset_route)
//                     ),
//                     Text(_moreDetails.desc,
//                       style: TextStyle(
//                         fontSize: 12.0,
//                         color: Colors.white
//                       ),
//                     )
//                   ]
//                 )
//               )
//             ]
//           )
//         ),
//       )