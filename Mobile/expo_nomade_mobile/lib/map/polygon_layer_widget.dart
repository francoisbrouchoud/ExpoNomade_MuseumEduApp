import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';

class PolygonLayerWidget extends StatelessWidget {
  List<Polygon> polygons = [
    Polygon(points: [
      LatLng(46.23842228129187, 7.245663852872407),
      LatLng(46.24429885795251, 7.346168917661903),
      LatLng(46.18600898280903, 7.294217024268299),
    ], color: Colors.redAccent.withOpacity(0.3), isFilled: true)
  ];

  @override
  Widget build(BuildContext context) {
    return PolygonLayer(
      polygons: polygons,
    );
  }
}
