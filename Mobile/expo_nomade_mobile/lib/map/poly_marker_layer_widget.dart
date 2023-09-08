import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../bo/expo_event.dart';

class PolyMarkerLayerWidget extends StatelessWidget {
  final Function(ExpoEvent) onMarkerTap;
  final List<ExpoEvent> expoEvents;

  const PolyMarkerLayerWidget({
    Key? key,
    required this.onMarkerTap,
    required this.expoEvents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final markers = expoEvents.map((expoEvent) {
      // Calculez le centre du polygone
      LatLng center = calculatePolygonCenter(expoEvent.from);

      return Marker(
        point: center,
        width: 50,
        height: 50,
        builder: (ctx) => GestureDetector(
          onTap: () => {onMarkerTap(expoEvent)},
          child: Image.asset('assets/images/zone.png'),
        ),
      );
    }).toList();

    return MarkerLayer(
      markers: markers,
    );
  }

  LatLng calculatePolygonCenter(List<LatLng> coordinates) {
    double totalLatitude = 0.0;
    double totalLongitude = 0.0;

    for (final coord in coordinates) {
      totalLatitude += coord.latitude;
      totalLongitude += coord.longitude;
    }

    final int pointCount = coordinates.length;
    final double centerLatitude = totalLatitude / pointCount;
    final double centerLongitude = totalLongitude / pointCount;

    return LatLng(centerLatitude, centerLongitude);
  }
}
