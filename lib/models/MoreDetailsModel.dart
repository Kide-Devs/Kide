import 'package:flutter/foundation.dart';

class MoreDetailsModel {
  final String id;
  final String header;
  final String aim;
  final String mission;
  final String asset_route;
  final String link;
  MoreDetailsModel({
    @required this.id,
    @required this.header,
    @required this.aim,
    @required this.mission,
    @required this.asset_route,
    @required this.link,
  });
}