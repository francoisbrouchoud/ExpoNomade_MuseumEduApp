import 'package:expo_nomade_mobile/bo/base_business_object.dart';
import 'package:expo_nomade_mobile/helper/multilingual_string.dart';

/// Class ExpoPopulationType is used to store all details related to a population type.
class ExpoPopulationType extends BaseBusinessObject {
  String id;
  MultilingualString title;

  /// ExpoPopulationType complete constructor.
  ExpoPopulationType(this.id, this.title);

  /// Convert json into the business object ExpoPopulationType.
  factory ExpoPopulationType.fromJson(String id, dynamic json) {
    return ExpoPopulationType(
        id, MultilingualString(Map<String, String>.from(json['title'])));
  }

  @override
  String toListText(String langCode) {
    return title[langCode];
  }
}
