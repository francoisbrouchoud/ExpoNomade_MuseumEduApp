import 'dart:ui';
import 'package:expo_nomade_mobile/util/base_business_object.dart';
import 'package:expo_nomade_mobile/util/multilingual_string.dart';
import 'package:latlong2/latlong.dart';

import 'package:expo_nomade_mobile/bo/expo_population_type.dart';
import 'package:expo_nomade_mobile/bo/expo_axis.dart';

/// Class ExpoEvent is used to store all details related to an event of an exposition.
class ExpoEvent extends BaseBusinessObject {
  ExpoAxis axis;
  MultilingualString description;
  int endYear;
  List<LatLng> from;
  Picture? picture;
  ExpoPopulationType populationType;
  MultilingualString reason;
  int startYear;
  MultilingualString title;
  List<LatLng> to;

  /// ExpoEvent complete constructor.
  ExpoEvent(this.axis, this.description, this.endYear, this.from, this.picture,
      this.populationType, this.reason, this.startYear, this.title, this.to);

  /// Convert json into the business object ExpoEvent.
  factory ExpoEvent.fromJson(dynamic json, Map<String, ExpoAxis> axes,
      Map<String, ExpoPopulationType> populationTypes) {
    ExpoAxis axis = axes[json['axe']]!;
    MultilingualString description =
        MultilingualString(Map<String, String>.from(json['description']));
    int endYear = json['endYear'] as int;
    List<LatLng> from = List<dynamic>.from(json['from'])
        .map((coordinate) =>
            LatLng(coordinate['lat'] as double, coordinate['lon'] as double))
        .toList();
    ExpoPopulationType popType = populationTypes[json['populationType']]!;
    MultilingualString reason =
        MultilingualString(Map<String, String>.from(json['reason']));
    int startYear = json['startYear'] as int;
    MultilingualString title =
        MultilingualString(Map<String, String>.from(json['title']));
    List<LatLng> to = List<dynamic>.from(json['to'])
        .map((coordinate) =>
            LatLng(coordinate['lat'] as double, coordinate['lon'] as double))
        .toList();
    Picture? picture; // TODO get picture if existing
    return ExpoEvent(axis, description, endYear, from, picture, popType, reason,
        startYear, title, to);
  }

  @override
  String toListText(String langCode) {
    return title[langCode];
  }
}
