import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../bo/expo_event.dart';

/// generate a liste of polygon with expo to show in map
Map<ExpoEvent, Polygon> generatePolygone(
    List<ExpoEvent> expoEvents, Color color) {
  Map<ExpoEvent, Polygon> eventPoly = HashMap();
  for (var event in expoEvents) {
    final List<LatLng> sortedCoordinates = sortCoordinates(event.from);
    sortedCoordinates.add(sortedCoordinates.first);
    eventPoly[event] = Polygon(
      points: sortedCoordinates,
      color: color.withOpacity(0.2),
      isFilled: true,
    );
  }
  return eventPoly;
}

/// sort the coordinate to have a clean polygone
List<LatLng> sortCoordinates(List<LatLng> coordinates) {
  // Trouver le point le plus bas à gauche comme point de référence (pivot).
  LatLng pivot = coordinates[0];
  for (final coord in coordinates) {
    if (coord.latitude < pivot.latitude ||
        (coord.latitude == pivot.latitude &&
            coord.longitude < pivot.longitude)) {
      pivot = coord;
    }
  }
  // Trier les coordonnées en fonction de leur angle par rapport au pivot.
  coordinates.sort((a, b) {
    double angleA =
        atan2(a.latitude - pivot.latitude, a.longitude - pivot.longitude);
    double angleB =
        atan2(b.latitude - pivot.latitude, b.longitude - pivot.longitude);
    return angleA.compareTo(angleB);
  });

  return coordinates;
}

/// detect if a point is in a polygon
bool pointInPolygon(LatLng position, Polygon polygon) {
  // Check if the point is inside the polygon or on the boundary
  int intersections = 0;
  var verticesCount = polygon.points.length;

  for (int i = 1; i < verticesCount; i++) {
    LatLng vertex1 = polygon.points[i - 1];
    LatLng vertex2 = polygon.points[i];

    // Check if point is on an horizontal polygon boundary
    if (vertex1.latitude == vertex2.latitude &&
        vertex1.latitude == position.latitude &&
        position.longitude > min(vertex1.longitude, vertex2.longitude) &&
        position.longitude < max(vertex1.longitude, vertex2.longitude)) {
      return true;
    }

    if (position.latitude > min(vertex1.latitude, vertex2.latitude) &&
        position.latitude <= max(vertex1.latitude, vertex2.latitude) &&
        position.longitude <= max(vertex1.longitude, vertex2.longitude) &&
        vertex1.latitude != vertex2.latitude) {
      var xinters = (position.latitude - vertex1.latitude) *
              (vertex2.longitude - vertex1.longitude) /
              (vertex2.latitude - vertex1.latitude) +
          vertex1.longitude;
      if (xinters == position.longitude) {
        // Check if point is on the polygon boundary (other than horizontal)
        return true;
      }
      if (vertex1.longitude == vertex2.longitude ||
          position.longitude <= xinters) {
        intersections++;
      }
    }
  }

  // If the number of edges we passed through is odd, then it's in the polygon.
  return intersections % 2 != 0;
}
