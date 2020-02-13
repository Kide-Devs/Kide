import 'package:flutter/foundation.dart';
import 'Official.dart';

class QuickOverview {
  final String totalParticipants;
  final List<Official> officials;
  QuickOverview({
    @required this.totalParticipants,
    @required this.officials,
  });
}