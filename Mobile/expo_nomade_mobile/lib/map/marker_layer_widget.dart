import 'package:expo_nomade_mobile/util/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../bo/expo_object.dart';

/// This class is the layer that allows us to manage the markers on the map.
class MarkerLayerWidget extends StatelessWidget {
  final Function(ExpoObject) onMarkerTap;
  final Map<ExpoObject, int> expoObjects;
  const MarkerLayerWidget(
      {Key? key, required this.onMarkerTap, required this.expoObjects})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final markers = <Marker>[];
    for (final expoObject in expoObjects.entries) {
      final coordinates = expoObject.key.coordinates[expoObject.value];
      if (coordinates != null) {
        markers.add(
          Marker(
            point: LatLng(coordinates.latitude, coordinates.longitude),
            width: GlobalConstants.markerMapSize,
            height: GlobalConstants.markerMapSize,
            builder: (ctx) => GestureDetector(
              onTap: () => {onMarkerTap(expoObject.key)},
              child: Image.asset(GlobalConstants.markerMapImagePath),
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
