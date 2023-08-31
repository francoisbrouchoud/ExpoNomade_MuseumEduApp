import 'dart:math';

import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../bo/expo_object.dart';

/// This class is the layer that allows us to manage the markers on the map.
class MarkerLayerWidget extends StatelessWidget {
  final Function(ExpoObject) onMarkerTap;
  final List<ExpoObject> expoObjects;

  const MarkerLayerWidget(
      {Key? key, required this.onMarkerTap, required this.expoObjects})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final markers = <Marker>[];

    for (final expoObject in expoObjects) {
      final coordinates = expoObject.coordinates.values.toList();
      if (coordinates.isNotEmpty) {
        final latLng = coordinates.first;
        markers.add(
          Marker(
            point: LatLng(latLng.latitude, latLng.longitude),
            width: 50,
            height: 50,
            builder: (ctx) => GestureDetector(
              onTap: () => {onMarkerTap(expoObject)},
              child: Image.asset('assets/images/marker.png'),
            ),
          ),
        );
      }
    }
    return MarkerLayer(
      markers: markers,
    );
  }
}
