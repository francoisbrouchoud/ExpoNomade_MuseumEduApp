/// Class ExpoPopulationType is used to store all details related to a population type.
class ExpoPopulationType {
  Map<String, String> title;

  /// ExpoPopulationType complete constructor.
  ExpoPopulationType(this.title);

  /// Convert json into the business object ExpoPopulationType.
  factory ExpoPopulationType.fromJson(dynamic json) {
    return ExpoPopulationType(Map<String, String>.from(json['title']));
  }
}
