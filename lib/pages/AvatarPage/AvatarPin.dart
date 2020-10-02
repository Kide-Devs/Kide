import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Avatar extends StatelessWidget {
  Avatar(
      {@required this.width,
      @required this.height,
      @required this.skinTone,
      @required this.hair,
      @required this.hairColor,
      @required this.clothingType,
      @required this.clothingColor,
      @required this.eye,
      @required this.eyebrow,
      @required this.mouth,
      @required this.facialHair,
      @required this.accessory,
      @required this.hat,
      @required this.hatColor});

  final double height, width;
  final String skinTone,
      hair,
      hairColor,
      clothingType,
      clothingColor,
      eye,
      eyebrow,
      mouth,
      facialHair,
      accessory,
      hat,
      hatColor;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      "https://bigheads.io/svg?"
      "accessory=$accessory&"
      "body=chest&"
      "circleColor=blue&"
      "clothing=$clothingType&"
      "clothingColor=$clothingColor&"
      "eyebrows=$eyebrow&"
      "eyes=$eye&"
      "faceMask=false&"
      "faceMaskColor=red&"
      "facialHair=$facialHair&"
      "graphic=none&"
      "hair=$hair&"
      "hairColor=$hairColor&"
      "hat=$hat&"
      "hatColor=$hatColor&"
      "lashes=true&"
      "lipColor=pink&"
      "mask=true&"
      "mouth=$mouth&"
      "skinTone=$skinTone",
      height: this.height,
      width: this.width,
      placeholderBuilder: (context) {
        return CircularProgressIndicator();
      },
      key: Key(skinTone +
          hair +
          hairColor +
          clothingType +
          clothingColor +
          eye +
          eyebrow +
          mouth +
          facialHair +
          accessory +
          hat +
          hatColor),
    );
  }
}
