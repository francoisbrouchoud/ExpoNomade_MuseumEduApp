import 'package:expo_nomade_mobile/bo/base_business_object.dart';
import 'package:expo_nomade_mobile/helper/multilingual_string.dart';
import 'package:latlong2/latlong.dart';

import 'package:expo_nomade_mobile/bo/expo_population_type.dart';
import 'package:expo_nomade_mobile/bo/expo_axis.dart';

/// Class ExpoEvent is used to store all details related to an event of an exposition.
class ExpoEvent extends BaseBusinessObject {
  String id;
  ExpoAxis axis;
  MultilingualString description;
  int endYear;
  List<LatLng> from;
  String pictureURL;
  ExpoPopulationType populationType;
  MultilingualString reason;
  int startYear;
  MultilingualString title;
  List<LatLng> to;

  /// ExpoEvent complete constructor.
  ExpoEvent(
      this.id,
      this.axis,
      this.description,
      this.endYear,
      this.from,
      this.pictureURL,
      this.populationType,
      this.reason,
      this.startYear,
      this.title,
      this.to);

  /// Convert json into the business object ExpoEvent.
  factory ExpoEvent.fromJson(
      String id,
      dynamic json,
      Map<String, ExpoAxis> axes,
      Map<String, ExpoPopulationType> populationTypes) {
    ExpoAxis axis = axes[json['axe']]!;
    MultilingualString description =
        MultilingualString(Map<String, String>.from(json['description']));
    int endYear = json['endYear'] as int;
    List<LatLng> from = List<dynamic>.from(json['from'])
        .map((coordinate) => LatLng(
            coordinate['lat'] is int
                ? (coordinate['lat'] as int).toDouble()
                : coordinate['lat'] as double,
            coordinate['lon'] is int
                ? (coordinate['lon'] as int).toDouble()
                : coordinate['lon'] as double))
        .toList();
    ExpoPopulationType popType = populationTypes[json['populationType']]!;
    MultilingualString reason =
        MultilingualString(Map<String, String>.from(json['reason']));
    int startYear = json['startYear'] as int;
    MultilingualString title =
        MultilingualString(Map<String, String>.from(json['title']));
    List<LatLng> to = List<dynamic>.from(json['to'])
        .map((coordinate) => LatLng(
            coordinate['lat'] is int
                ? (coordinate['lat'] as int).toDouble()
                : coordinate['lat'] as double,
            coordinate['lon'] is int
                ? (coordinate['lon'] as int).toDouble()
                : coordinate['lon'] as double))
        .toList();
    String pictureURL = json['picture'] as String;
    return ExpoEvent(id, axis, description, endYear, from, pictureURL, popType,
        reason, startYear, title, to);
  }

  @override
  String toListText(String langCode) {
    return title[langCode];
  }
}
