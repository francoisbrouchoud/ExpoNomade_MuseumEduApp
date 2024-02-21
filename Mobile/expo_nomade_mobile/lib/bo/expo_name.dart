import 'package:expo_nomade_mobile/bo/base_business_object.dart';
import 'package:expo_nomade_mobile/helper/multilingual_string.dart';

/// Class ExpoPopulationType is used to store all details related to a population type.
class ExpoName extends BaseBusinessObject {
  MultilingualString name;

  /// ExpoPopulationType complete constructor.
  ExpoName(super.id, this.name);

  /// Convert json into the business object ExpoPopulationType.
  factory ExpoName.fromJson(String id, dynamic json) {
    return ExpoName(
        id, MultilingualString(Map<String, String>.from(json['name'])));
  }

  @override
  String toListText(String langCode) {
    return name[langCode];
  }
}
