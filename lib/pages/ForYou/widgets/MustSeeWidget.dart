import 'package:Kide/pages/MapsPage/Maps.dart';
import 'package:flutter/material.dart';
import 'package:Kide/config/Viewport.dart';

class MustSeeWidget extends StatelessWidget {
  final String src;
  final String title;
  final String marker;

  MustSeeWidget({
    this.src,
    this.title,
    this.marker,
  });

  @override
  Widget build(BuildContext context) {
    ViewPort().init(context);
    return Stack(
      children: [
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: Image.network(
            src, 
            fit: BoxFit.cover,
            width: ViewPort.screenWidth * 0.43,
            height: 200,
          ),
        ),
        InkWell(
          child: Container(
            width: ViewPort.screenWidth * 0.45,
            height: 210.0,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.64),
                borderRadius: BorderRadius.circular(8.0)),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          onTap: () {
            print("Sugg tap : $marker");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapsPage(eventMarker: marker)
              )
            );
          },
        ),
      ]
    );
  }
}