import 'dart:math';

import 'package:expo_nomade_mobile/bo/expo_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'dart:ui' as ui;

class PolygonLayerTest extends StatelessWidget {
  final List<ExpoEvent> expoEvents;
  const PolygonLayerTest({required this.expoEvents});

  @override
  Widget build(BuildContext context) {
    double posx = 0;

    double posy = 0;

    void onTapDown(BuildContext context, TapDownDetails details) {
      final MapController _mapController = MapController();
      // creating instance of renderbox
      final RenderBox box = context.findRenderObject() as RenderBox;
      // find the coordinate
      final Offset localOffset = box.globalToLocal(details.globalPosition);
      posx = localOffset.dx;
      posy = localOffset.dy;
      // this string contain the x and y coordinates.
      print('Tapped\nX:$posx \nY:$posy');
      ;
    }

    return GestureDetector(
      onTapDown: (details) => onTapDown(context, details),
      child: PolygonLayer(
        polygons: expoEvents.map((ExpoEvent expoEvent) {
          final List<LatLng> sortedCoordinates =
              sortCoordinates(expoEvent.from);
          sortedCoordinates.add(sortedCoordinates.first); // Close the polygon
          return Polygon(
            points: sortedCoordinates,
            color: Colors.lightBlueAccent.withOpacity(0.3),
            isFilled: true,
          );
        }).toList(),
      ),
    );
  }

  bool _pointInPolygon(LatLng position, Polygon polygon) {
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
}
