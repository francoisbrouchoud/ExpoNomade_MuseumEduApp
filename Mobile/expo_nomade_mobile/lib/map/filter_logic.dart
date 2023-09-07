import 'dart:collection';

import 'package:expo_nomade_mobile/bo/expo_axis.dart';

import '../bo/expo_event.dart';
import '../bo/expo_object.dart';
import '../bo/expo_population_type.dart';
import '../util/multilingual_string.dart';

/// Filters a list of ExpoEvent by year, by reason and by population type.
List<ExpoEvent> filterEvents(
    List<ExpoEvent> events, double startYear, double endYear, Set<ExpoAxis> reasons, Set<ExpoPopulationType> populations) {
  return events.where((event) {
    return event.startYear >= startYear && 
            event.endYear <= endYear &&
            reasons.contains(event.axis) &&
            populations.contains(event.populationType);
  }).toList();
}

/// Filters a list of ExpoObject by year and by reason.
Map<ExpoObject, int> filterObjects(
    List<ExpoObject> objs, double startYear, double endYear, Set<ExpoAxis> reasons) {
  Map<ExpoObject, int> filtered = HashMap();

  //Filter by year
  for (ExpoObject obj in objs) {
    int? y;
    List<int> potentialY = obj.coordinates.keys.where((yr) {
      return yr >= startYear && yr <= endYear;
    }).toList();
    // if no year is between the selected dates, we want to display the most recent one
    if (potentialY.isEmpty) {
      potentialY = obj.coordinates.keys.where((yr) {
        return startYear >= yr && endYear >= yr;
      }).toList();
    }
    if (potentialY.isNotEmpty) {
      for (int year in potentialY) {
        if (y == null) {
          y = year;
        } else if (year > y) {
          y = year;
        }
      }
    }
    if (y != null) {
      filtered.putIfAbsent(obj, () => y!);
    }
  }

  // Filter by reason
  filtered.removeWhere((ExpoObject obj, int year) => !reasons.contains(obj.axis));

  return filtered;
}
