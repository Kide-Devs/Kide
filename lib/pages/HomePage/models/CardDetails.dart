import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class CardDetails {
  final String heading;
  final String description;
  final Image image;
  final int cardType; //1 for latge cards and 0 for small cards

  CardDetails({
    @required this.heading,
    this.description,
    @required this.image,
    @required this.cardType
  });
}