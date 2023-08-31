import 'dart:collection';

import '../bo/expo_event.dart';
import '../bo/expo_object.dart';

List<ExpoEvent> filterEventsByYear(List<ExpoEvent> events, double startYear, double endYear) {
  return events.where((event) {
    return event.startYear >= startYear && event.endYear <= endYear;
  }).toList();
}

Map<ExpoObject, int> filterObjectsByYear(List<ExpoObject> objs, double startYear, double endYear) {
    Map<ExpoObject, int> filtered = HashMap();
    for (ExpoObject obj in objs) {
        int? y;
        List<int> potentialY = obj.coordinates.keys.where((yr) { return yr >= startYear && yr <= endYear; }).toList();
        if (potentialY.isNotEmpty) {
            for (int year in potentialY) {
                if (y == null) {
                    y = year;
                }
                else if (year > y) {
                    y = year;
                }
            }
        }
        if (y != null) {
            filtered.putIfAbsent(obj, () => y!);
        }
    }
    return filtered;
}
