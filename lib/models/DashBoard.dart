import 'package:flutter/foundation.dart';
import 'Official.dart';

class DashBoard {
  final String totalParticipants;
  final List<Official> officials;
  DashBoard({
    @required this.totalParticipants,
    @required this.officials,
  });
}