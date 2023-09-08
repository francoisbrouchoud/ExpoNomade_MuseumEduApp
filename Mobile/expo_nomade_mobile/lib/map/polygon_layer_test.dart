import 'dart:math';

import 'package:expo_nomade_mobile/bo/expo_event.dart';
import 'package:expo_nomade_mobile/map/poly_marker_layer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:geodesy/geodesy.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;

class PolygonLayerTest extends StatelessWidget {
  final Function(ExpoEvent) onMarkerTap;
  final List<ExpoEvent> expoEvents;
  final MapController mapController = MapController();
  PolygonLayerTest(
      {super.key, required this.expoEvents, required this.onMarkerTap});
  Geodesy geodesy = Geodesy();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Couche de polygones
        PolygonLayer(
          polygons: expoEvents.map((ExpoEvent expoEvent) {
            final List<LatLng> sortedCoordinates =
                sortCoordinates(expoEvent.from);
            sortedCoordinates
                .add(sortedCoordinates.first); // Fermez le polygone
            return Polygon(
              points: sortedCoordinates,
              color: Colors.lightBlueAccent.withOpacity(0.3),
              isFilled: true,
            );
          }).toList(),
        ),

        // Couche de marqueurs
        PolyMarkerLayerWidget(
          expoEvents: expoEvents,
          onMarkerTap: (expoEvents) {},
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
