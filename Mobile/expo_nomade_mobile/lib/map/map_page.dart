import 'package:expo_nomade_mobile/map/info_panel.dart';
import 'package:expo_nomade_mobile/map/marker_layer_widget.dart';
import 'package:expo_nomade_mobile/map/tile_layer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// Class MapPage is used to display the map and the information related to the exposition.
class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

/// Class _MapPageState is the state class for the MapPage class, used to manage the behavior on click of the markers.
class _MapPageState extends State<MapPage> {
  bool isLargeScreen = false;
  String? selectedMarkerId;

  @override
  Widget build(BuildContext context) {
    isLargeScreen = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      body: SafeArea(
        child: Flex(
          direction: isLargeScreen ? Axis.horizontal : Axis.vertical,
          children: [
            Flexible(
              flex: 1,
              child: FlutterMap(
                /// The map options define the "spawning" coordinates of the map when we load it and the default zoom to show only a specific area of the world map.
                /// The latitude and the longitude we use here are the coordinates of Sion, capital city of the State Valais.
                options: MapOptions(
                  center: const LatLng(46.22809, 7.35886),
                  zoom: 10,
                ),
                children: [
                  /// Both the tile layer and the marker layer have their own class to prevent messy code.
                  /// They are in charge of rendering the map and adding any markers on it.
                  TileLayerWidget(),
                  MarkerLayerWidget(
                    onMarkerTap: (String markerId) {
                      setState(() {
                        selectedMarkerId = markerId;
                      });
                    },
                  ),
                ],
              ),
            ),
            if (selectedMarkerId != null)
              Flexible(
                flex: 1,
                child: InfoPanel(
                    markerId: selectedMarkerId!,
                    onClose: () {
                      setState(() {
                        selectedMarkerId = null;
                      });
                    }),
              ),
          ],
        ),
      ),
    );
  }
}
