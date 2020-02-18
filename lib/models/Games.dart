import 'package:flutter/foundation.dart';

class GameDetails {
  final String name;
  final String food;
  final Map<dynamic, dynamic> venues;
  final Map<dynamic, dynamic> gameAccomodations;
  GameDetails({
    @required this.name,
    @required this.food,
    @required this.venues,
    @required this.gameAccomodations
  });
}