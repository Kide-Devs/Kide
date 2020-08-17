import 'package:Kide/config/Viewport.dart';
import 'package:Kide/pages/MapsPage/Maps.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: src,
            fit: BoxFit.cover,
            width: ViewPort.screenWidth * 0.43,
            height: 200,
          ),
        ),
        InkWell(
          child: Container(
            width: ViewPort.screenWidth * 0.44,
            height: 205.0,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.64),
                borderRadius: BorderRadius.circular(8.0)),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Quicksand",
                  fontSize: 16,
                ),
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapsPage(eventMarker: marker),
              ),
            );
          },
        ),
      ],
    );
  }
}
