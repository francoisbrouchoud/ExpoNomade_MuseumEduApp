import 'dart:collection';
import 'dart:ui';

import 'package:expo_nomade_mobile/bo/expo_axis.dart';
import 'package:expo_nomade_mobile/bo/museum.dart';
import 'package:expo_nomade_mobile/util/base_business_object.dart';
import 'package:expo_nomade_mobile/util/multilingual_string.dart';
import 'package:latlong2/latlong.dart';

/// Class ExpoObject is used to store all details related to an object of an exposition.
class ExpoObject extends BaseBusinessObject {
  ExpoAxis axis;
  Map<int, LatLng> coordinates;
  MultilingualString description;
  String dimension;
  MultilingualString material;
  Museum museum;
  MultilingualString others;
  Picture? picture;
  MultilingualString position;
  MultilingualString title;

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
    MultilingualString description =
        MultilingualString(Map<String, String>.from(json['description']));
    String dimension = json['dimension'] as String;
    MultilingualString material =
        MultilingualString(Map<String, String>.from(json['material']));
    Museum museum = museums[json['museum'] as String]!;
    MultilingualString others =
        MultilingualString(Map<String, String>.from(json['others']));
    MultilingualString title =
        MultilingualString(Map<String, String>.from(json['title']));
    MultilingualString position =
        MultilingualString(Map<String, String>.from(json['position']));
    Picture? picture; // TODO picture
    return ExpoObject(axis, coordinates, description, dimension, material,
        museum, others, picture, position, title);
  }

  @override
  String toListText(String langCode) {
    return title[langCode];
  }
}
