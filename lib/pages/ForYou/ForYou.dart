import 'package:Kide/pages/ForYou/widgets/MustSeeWidget.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:Kide/config/Viewport.dart';
// import 'package:Kide/providers/getEvents.dart';
// import 'package:Kide/util/constants.dart';
// import 'package:provider/provider.dart';
// import 'package:Kide/widgets/HeaderWidget.dart';

void main() => runApp(ForYouPage());

class ForYouPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ViewPort().init(context);
    return Scaffold(
      backgroundColor: DynamicTheme.of(context).data.backgroundColor,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Text(
                        "MUST SEE PLACES",
                        style: TextStyle(
                          fontSize: 20,
                          color: DynamicTheme.of(context).data.textTheme.subtitle.color,
                          fontWeight: FontWeight.w600,
                          letterSpacing: ViewPort.screenWidth * 0.01),
                        )
                      ),
                      Center(
                        child: Text(
                        "IN KIIT CAMPUS",
                        style: TextStyle(
                          fontSize: 10,
                          color: DynamicTheme.of(context).data.textTheme.subtitle.color,
                          fontWeight: FontWeight.w600,
                          letterSpacing: ViewPort.screenWidth * 0.02),
                        )
                      ),
                      Divider(thickness: 3, color: Colors.blueAccent,),
                      Container(height: 24,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MustSeeWidget(
                            src: "https://cdn.kiit.ac.in/main/2017/09/19095700/campus1.jpg",
                            title: "Sculpture Garden",
                            marker: "sculpture_garden",
                          ),
                          Spacer(),
                          MustSeeWidget(
                            src: "https://i.ytimg.com/vi/MNANkwA2gNc/hqdefault.jpg",
                            title: "KISS Temple",
                            marker: "kiss_temple",
                          ),
                        ],
                      ),
                      Container(height: 24,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MustSeeWidget(
                            src: "https://getmyuni.azureedge.net/college-images-test/kiit-school-of-management-ksom-bhubaneswar/fbe0c84d22054965b453a17ea4ad601d.png",
                            title: "KSOM Campus Pond",
                            marker: "ksom_campus_pond"
                          ),
                          Spacer(),
                          MustSeeWidget(
                            src: "https://i.ytimg.com/vi/gVlEh_VfFvo/maxresdefault.jpg",
                            title: "Rose Garden",
                            marker: "rose_garden"
                          )
                        ],
                      ),
                      Container(height: 24,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MustSeeWidget(
                            src: "https://cdn.kiit.ac.in/main/2017/09/19095658/campus7.jpg",
                            title: "Convention Center",
                            marker: "campus_6",
                          ),
                          Spacer(),
                          MustSeeWidget(
                            src: "https://cdn.kiit.ac.in/main/2017/09/19095653/campus4.jpg",
                            title: "Kathjodi Campus",
                            marker: "campus_3",
                          ),
                        ],
                      ),
                      Container(height: 24,),
                    ]
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//   Card _buildEventCard(
//       BuildContext context, GetEvents _getEvents, int position) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
//       child: InkWell(
//         splashColor: Colors.blue.withAlpha(30),
//         onTap: () {
//         },
//         child: Stack(children: <Widget>[
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.transparent,
//               borderRadius: BorderRadius.circular(8.0),
//               image: DecorationImage(
//                 fit: BoxFit.cover,
//                 image: AssetImage(
//                   EVENTS_PAGE_EVENT_JPG,
//                 ),
//               ),
//             ),
//             height: 120.0,
//           ),
//           Container(
//               height: 120.0,
//               decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(0.64),
//                   borderRadius: BorderRadius.circular(8.0)),
//               child: Center(
//                 child: Text(
//                   _getEvents.eventCategories[position].name.toUpperCase(),
//                   style: TextStyle(
//                       color: Colors.white,
//                       letterSpacing: ViewPort.screenWidth * 0.05,
//                       fontWeight: FontWeight.w600),
//                 ),
//               )),
//         ]),
//       ),
//       margin: const EdgeInsets.fromLTRB(0.0, 14.0, 0.0, 14.0),
//     );
//   }
}
