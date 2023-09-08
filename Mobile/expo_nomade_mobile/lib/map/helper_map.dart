import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../bo/expo_event.dart';

/// generate a liste of polygon with expo to show in map
Map<ExpoEvent, Polygon> generatePolygone(
    List<ExpoEvent> expoEvents, Color color) {
  Map<ExpoEvent, Polygon> eventPoly = HashMap();
  for (var event in expoEvents) {
    eventPoly[event] = Polygon(
      points: event.from,
      color: color.withOpacity(0.2),
      isFilled: true,
    );
  }
  return eventPoly;
}

/// Detect if a point is in a polygon
bool pointInPolygon(LatLng position, Polygon polygon) {
  bool isInside = false;
  var verticesCount = polygon.points.length;

  for (int i = 0, j = verticesCount - 1; i < verticesCount; j = i++) {
    LatLng vertex1 = polygon.points[i];
    LatLng vertex2 = polygon.points[j];

    if (((vertex1.latitude > position.latitude) !=
            (vertex2.latitude > position.latitude)) &&
        (position.longitude <
            (vertex2.longitude - vertex1.longitude) *
                    (position.latitude - vertex1.latitude) /
                    (vertex2.latitude - vertex1.latitude) +
                vertex1.longitude)) {
      isInside = !isInside;
    }
  }

  return isInside;
}
