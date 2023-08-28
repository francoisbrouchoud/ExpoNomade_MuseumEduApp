import 'package:expo_nomade_mobile/util/multilingual_string.dart';

/// Class ExpoPopulationType is used to store all details related to a population type.
class ExpoPopulationType {
  MultilingualString title;

  /// ExpoPopulationType complete constructor.
  ExpoPopulationType(this.title);

  /// Convert json into the business object ExpoPopulationType.
  factory ExpoPopulationType.fromJson(dynamic json) {
    return ExpoPopulationType(
        MultilingualString(Map<String, String>.from(json['title'])));
  }
}
