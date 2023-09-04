import 'multilingual_string.dart';
import 'package:latlong2/latlong.dart';

// Global fields for validation
const emptyString = "EMPTY";
const eventMinCoordinatesNb = 3;

bool isValidEmail(String email) {
  final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  return emailRegex.hasMatch(email);
}

bool isEmptyString(String string) {
  return string == emptyString;
}

bool isEmptyMultiLingString(MultilingualString multiLingString) {
  return isEmptyTranslationMap(multiLingString.toMap());
}

bool isEmptyTranslationMap(Map<String, String> translations) {
  for (var translation in translations.values) {
    if (translation.trim().isEmpty || isEmptyString(translation.trim())) {
      return true;
    }
  }
  return false;
}

bool isIncompleteLatLngListForEvent(List<LatLng> coordinates) {
  if (coordinates.length < eventMinCoordinatesNb) {
    return true;
  }
  return false;
}
