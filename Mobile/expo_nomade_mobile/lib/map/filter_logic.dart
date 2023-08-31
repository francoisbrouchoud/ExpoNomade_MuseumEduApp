import '../bo/expo_event.dart';
import '../bo/expo_object.dart';

List<ExpoEvent> filterEventsByYear(List<ExpoEvent> events, double startYear, double endYear) {
  return events.where((event) {
    return event.startYear >= startYear && event.endYear <= endYear;
  }).toList();
}

List<ExpoObject> filterObjectsByYear(List<ExpoObject> objects, double startYear, double endYear) {
  return objects.where((object) {
    // todo logic
    //return object.year >= startYear && object.year <= endYear;
    return true;
  }).toList();
}
