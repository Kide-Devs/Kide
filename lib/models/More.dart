import 'package:flutter/foundation.dart';
import 'package:Kide/models/MoreInfo.dart';
import 'package:flutter/material.dart';

class More {
  final String id;
  final String moreName;
  final List<MoreInfo> pageFormat;
  final String assetRoute;
  final String link;
  final Color color;
  More({
    @required this.id,
    @required this.moreName,
    @required this.pageFormat,
    @required this.assetRoute,
    @required this.link,
    @required this.color,
  });
}