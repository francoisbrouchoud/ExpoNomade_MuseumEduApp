import 'package:expo_nomade_mobile/util/multilingual_string.dart';

/// Class ExpoAxis is used to store all details related to one axis of an exposition.
class ExpoAxis {
  String id;
  MultilingualString description;
  MultilingualString title;

  /// ExpoAxis complete constructor.
  ExpoAxis(this.id, this.description, this.title);

  /// Convert json into the business object ExpoAxis.
  factory ExpoAxis.fromJson(String id, dynamic json) {
    return ExpoAxis(
        id,
        MultilingualString(Map<String, String>.from(json['description'])),
        MultilingualString(Map<String, String>.from(json['title'])));
  }
}
