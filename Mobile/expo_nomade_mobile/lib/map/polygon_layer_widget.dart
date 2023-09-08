import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';

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
}
