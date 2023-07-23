import 'package:expo_nomade_mobile/map/marker_layer_widget.dart';
import 'package:expo_nomade_mobile/map/tile_layer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      /// The map options define the "spawning" coordinates of the map when we load it and the default zoom to show only a specific area of the world map.
      /// The latitude and the longitude we use here are the coordinates of Sion, capital city of the State Valais.
      options: MapOptions(
        center: const LatLng(46.22809, 7.35886),
        zoom: 10,
      ),

      /// Both the tile layer and the marker layer have their own class to prevent messy code.
      /// They are in charge of rendering the map and adding any markers on it.
      children: const [
        TileLayerWidget(),
        MarkerLayerWidget(),
      ],
    );
  }
}
