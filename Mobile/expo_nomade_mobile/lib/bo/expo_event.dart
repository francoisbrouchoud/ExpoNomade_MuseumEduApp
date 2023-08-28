import 'dart:ui';
import 'package:latlong2/latlong.dart';

import 'package:expo_nomade_mobile/bo/expo_population_type.dart';
import 'package:expo_nomade_mobile/bo/expo_axis.dart';

/// Class ExpoEvent is used to store all details related to an event of an exposition.
class ExpoEvent {
  ExpoAxis axis;
  Map<String, String> description;
  int endYear;
  List<LatLng> from;
  Picture? picture;
  ExpoPopulationType populationType;
  Map<String, String> reason;
  int startYear;
  Map<String, String> title;
  List<LatLng> to;

  /// ExpoEvent complete constructor.
  ExpoEvent(this.axis, this.description, this.endYear, this.from, this.picture,
      this.populationType, this.reason, this.startYear, this.title, this.to);

  /// Convert json into the business object ExpoEvent.
  factory ExpoEvent.fromJson(dynamic json, Map<String, ExpoAxis> axes,
      Map<String, ExpoPopulationType> populationTypes) {
    ExpoAxis axis = axes[json['axe']]!;
    Map<String, String> description =
        Map<String, String>.from(json['description']);
    int endYear = json['endYear'] as int;
    List<LatLng> from = List<dynamic>.from(json['from'])
        .map((coordinate) =>
            LatLng(coordinate['lat'] as double, coordinate['lon'] as double))
        .toList();
    ExpoPopulationType popType = populationTypes[json['populationType']]!;
    Map<String, String> reason = Map<String, String>.from(json['reason']);
    int startYear = json['startYear'] as int;
    Map<String, String> title = Map<String, String>.from(json['title']);
    List<LatLng> to = List<dynamic>.from(json['to'])
        .map((coordinate) =>
            LatLng(coordinate['lat'] as double, coordinate['lon'] as double))
        .toList();
    Picture? picture; // TODO get picture if existing
    return ExpoEvent(axis, description, endYear, from, picture, popType, reason,
        startYear, title, to);
  }
}