import 'dart:collection';
import 'dart:ui';

import 'package:expo_nomade_mobile/bo/expo_axis.dart';
import 'package:expo_nomade_mobile/bo/museum.dart';
import 'package:latlong2/latlong.dart';

/// Class ExpoObject is used to store all details related to an object of an exposition.
class ExpoObject {
  ExpoAxis axis;
  Map<int, LatLng> coordinates;
  Map<String, String> description;
  String dimension;
  Map<String, String> material;
  Museum museum;
  Map<String, String> others;
  Picture? picture;
  Map<String, String> position;
  Map<String, String> title;

  /// ExpoObject complete constructor.
  ExpoObject(
      this.axis,
      this.coordinates,
      this.description,
      this.dimension,
      this.material,
      this.museum,
      this.others,
      this.picture,
      this.position,
      this.title);

  /// Convert json into the business object ExpoObject.
  factory ExpoObject.fromJson(
      dynamic json, Map<String, ExpoAxis> axes, Map<String, Museum> museums) {
    ExpoAxis axis = axes[json['axe']]!;
    Map<int, LatLng> coordinates = HashMap();
    for (var coordinate in List<dynamic>.from(json['coordinates'])) {
      coordinates[coordinate['year'] as int] = LatLng(
          coordinate['coordonate']['lat'] as double,
          coordinate['coordonate']['lon'] as double);
    }
    Map<String, String> description =
        Map<String, String>.from(json['description']);
    String dimension = json['dimension'] as String;
    Map<String, String> material = Map<String, String>.from(json['material']);
    Museum museum = museums[json['museum'] as String]!;
    Map<String, String> others = Map<String, String>.from(json['others']);
    Map<String, String> title = Map<String, String>.from(json['title']);
    Map<String, String> position = Map<String, String>.from(json['position']);
    Picture? picture; // TODO picture
    return ExpoObject(axis, coordinates, description, dimension, material,
        museum, others, picture, position, title);
  }
}
