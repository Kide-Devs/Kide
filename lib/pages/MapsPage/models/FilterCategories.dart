import 'package:Kide/pages/MapsPage/models/FilterCategory.dart';
import 'package:flutter/material.dart';

List<FilterCategory> categories = [
  FilterCategory('sports', Icons.fitness_center),
  FilterCategory('food', Icons.restaurant),
  FilterCategory('hostels', Icons.home),
  FilterCategory('toilets', Icons.wc),
  FilterCategory('campuses', Icons.local_convenience_store),
  FilterCategory('gates', Icons.transfer_within_a_station),
  FilterCategory('events', Icons.event),
];

FilterCategory categoriesAll = FilterCategory('all', null);