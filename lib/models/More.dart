import 'package:flutter/foundation.dart';
import 'package:kide/models/MoreInfo.dart';

class More {
  final String id;
  final String moreName;
  final List<MoreInfo> pageFormat;
  final String assetRoute;
  final String link;
  More({
    @required this.id,
    @required this.moreName,
    @required this.pageFormat,
    @required this.assetRoute,
    @required this.link,
  });
}