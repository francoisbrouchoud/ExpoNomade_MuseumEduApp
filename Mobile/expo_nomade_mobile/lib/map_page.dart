import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FlutterMap(
      /** Those options define the "spawning" coordinates of the map when we load it and the default zoom to show only a specific area of the world map. 
       *  The latitude and the longitude we use here are the coordinates of Sion, capital city of the State Valais. 
      */
      options: MapOptions(
        center: LatLng(46.22809, 7.35886),
        zoom: 10,
      ),
      nonRotatedChildren: [
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              /** The following launchUrl is a link to the rendering open-source stylesheet that provides us the template we use in our application.
               *  Change the uri according to the template you want to use in the TileLayer section below.
               */
              'OpenStreetMap contributors',
              onTap: () =>
                  launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
            ),
          ],
        ),
      ],
      children: [
        /** TileLayer is responsible for choosing and loading the map templates (made of tiles) that you want to use in your application.
         *  More information about available map templates at https://wiki.openstreetmap.org/wiki/Raster_tile_providers.
        */
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
      ],
    );
  }
}
