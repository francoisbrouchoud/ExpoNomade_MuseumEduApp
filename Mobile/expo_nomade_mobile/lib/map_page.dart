import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';

const styleUrl =
    "https://api.mapbox.com/styles/v1/laumey/clk7147pb009801nw2y750jx5/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoibGF1bWV5IiwiYSI6ImNsazcxbWRiZDA1a2kzdHA2OTFzd2JkdmYifQ.8xOnsXZQ7GZprIYer0llfw";

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      /** Those options define the "spawning" coordinates of the map when we load it and the default zoom to show only a specific area of the world map. 
       *  The latitude and the longitude we use here are the coordinates of Sion, capital city of the State Valais. 
      */
      options: MapOptions(
        center: const LatLng(46.22809, 7.35886),
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
          urlTemplate: styleUrl,
          //additionalOptions: {"api_key": apiKey},
          maxZoom: 20,
          maxNativeZoom: 20,
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(46.22809, 7.35886),
              width: 80,
              height: 80,
              builder: (ctx) => GestureDetector(
                onTap: _onMarkerTap,
                child: const FlutterLogo(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _onMarkerTap() {
    // Action à effectuer lorsque le marqueur est cliqué
    print('Marqueur cliqué !');
  }
}
