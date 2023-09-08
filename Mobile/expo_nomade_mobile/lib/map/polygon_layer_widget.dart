import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

class PolygonLayerWidget extends StatelessWidget {
  final List<Polygon> expoEvents;
  const PolygonLayerWidget({super.key, required this.expoEvents});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Couche de polygones
        PolygonLayer(
          polygons: expoEvents,
        ),
      ],
    );
  }

  // ... Le reste de votre code ...
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
